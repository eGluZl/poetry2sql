const fs = require('fs')
const {Pool} = require('pg')
const path = require('path')

const config = {
    host: 'localhost',
    port: 5432,
    database: 'poetry',
    user: 'egluzl',
    password: 'pg525300',

    connectionTimeoutMillis: 30000,
    max: 20,
    idleTimeoutMillis: 30000,
}

const pool = new Pool(config)

const rootDir = 'F:\\chinese-poetry\\'

main()

function main() {
    //因爲太菜，下面三個函數只能手動分三次執行
    //todo 花間集數據還沒寫導入

    clearAllTables()
    // makeAllAuthorsData()
    // makeAllPoetryData()
}

function clearAllTables() {
    clearTable('poetry_authors', true)
    clearTable('poems_authors', true)
    clearTable('poetry', true)
    clearTable('strains', true)
    clearTable('nantang', true)
    clearTable('poems', true)
    clearTable('caocao', true)
    clearTable('lunyu', true)
    clearTable('shijing', true)
    clearTable('youmengying', true)
    clearTable('sishuwujing', true)
}

async function makeAllAuthorsData() {
    await makeAuthorsData('tang')
    await makeAuthorsData('song')
    await makeAuthorsData('nantang')
    return Promise.resolve()
}

function makeAllPoetryData(){
    makePoemAuthorsData()
    makePoetryData('tang')
    makePoetryData('song')
    makeStrainsData()
    makeNanTangPoetryData()
    makePoemsData()
    makeCaocaoData()
    makeLunyuData()
    makeShiJingData()
    makeYouMengYingData()
    makeSiShuWuJingData()
}

function query(sql) {
    return new Promise((resolve, reject) => {
        pool.connect().then(client => {
            client.query(sql).then(res => {
                resolve(res)
            }).catch(err => {
                reject(err)
            }).then(() => {
                client.release()
            })
        })
    })
}

function readFile(dir) {
    return new Promise((resolve, reject) => {
        fs.readFile(dir, 'utf-8', ((err, data) => {
            if (err === null) {
                resolve(data)
            } else {
                reject(err)
            }
        }))
    })
}

function readDir(dir, reg = '') {
    return new Promise((resolve, reject) => {
        fs.readdir(path.join(rootDir, dir), ((err, files) => {
            if (err != null) {
                reject(err)
            } else {
                if (reg == null || reg === '') {
                    resolve(files)
                } else {
                    resolve(files.filter(f => reg.test(f)))
                }
            }
        }))
    })
}

function splitBigArray(array, length) {
    let index = 0;
    let newArray = [];

    while (index < array.length) {
        newArray.push(array.slice(index, index += length));
    }

    return newArray;
}

function clearTable(tableName, isResetId) {
    query(`delete from ${tableName} where 1 = 1`).then(res => {
        console.log(`delete table: ${tableName}, ${res.rowCount} rows`)
    }, err => {
        console.error(err)
    })
    if (isResetId && isResetId === true) {
        query(`TRUNCATE TABLE ${tableName} RESTART IDENTITY;`).then(res => {
            console.log(`reset table ${tableName} id`)
        }, err => {
            console.error(err)
        })
    }
}

function array2Line(array) {
    if (array == null || array.length === 0) {
        return ''
    }
    let strLine = ''
    for (let i = 0; i < array.length; i++) {
        strLine += strLine === '' ? array[i] : `|${array[i]}`
    }
    return strLine
}

function makeAuthorsData(dynasty) {
    if (!dynasty || dynasty.length === 0) {
        return null
    }

    let dir = ''
    switch (dynasty) {
        case 'tang' : {
            dir = path.join(rootDir, `json/authors.tang.json`)
            break
        }
        case 'song' : {
            dir = path.join(rootDir, `json/authors.song.json`)
            break
        }
        case 'nantang' : {
            dir = path.join(rootDir, `wudai/nantang/authors.json`)
        }
    }

    if (dir === '') {
        return null
    }

    return Promise.resolve(
        readFile(dir).then((res) => {
            const json = JSON.parse(res.toString())
            console.log(`read file: ${dir}, data length: ${json.length}`)
            const arrives = splitBigArray(json, 1000)
            arrives.forEach(subArray => {
                if (!subArray || typeof subArray !== 'object') {
                    return
                }
                let sql = `insert into poetry_authors(name, intro, dynasty) values `
                let values = ''
                subArray.forEach(author => {
                    const val = `('${author.name}', '${author.desc}','${dynasty}')`
                    values += values === '' ? val : `,${val}`
                })
                sql += values
                query(sql).then(res => {
                    console.log(`process ${res.rowCount} data`)
                }, err => {
                    console.error(err)
                })
            })

        }, err => {
            console.error(err)
        })
    )

}

function makePoemAuthorsData() {
    const dir = path.join(rootDir, 'ci/author.song.json')
    readFile(dir).then((res) => {
        const json = JSON.parse(res.toString())
        console.log(`read file: ${dir}, data length: ${json.length}`)
        const arrives = splitBigArray(json, 1000)
        arrives.forEach(subArray => {
            if (!subArray || typeof subArray !== 'object') {
                return
            }
            let sql = `insert into poems_authors(name, intro_short, intro_long) values `
            let values = ''
            subArray.forEach(author => {
                const val = `('${author.name}', '${author.short_description}','${author.description}')`
                values += values === '' ? val : `,${val}`
            })
            sql += values
            query(sql).then(res => {
                console.log(`process ${res.rowCount} data`)
            }, err => {
                console.error(err)
            })
        })
    })
}

async function makePoetryData(dynasty) {
    if (!dynasty || dynasty.length === 0) {
        return null
    }

    let dirList = []
    switch (dynasty) {
        case 'tang' : {
            await readDir('json/', /^poet.tang.*.json/).then(res => {
                dirList = res
            }, err => {
                console.error(err)
            })
            break
        }
        case 'song' : {
            await readDir('json/', /^poet.song.*.json/).then(res => {
                dirList = res
            }, err => {
                console.error(err)
            })
        }
    }

    if (dirList.length === 0) {
        return
    }
    let authors = []
    await query(`select id,name from poetry_authors where dynasty= '${dynasty}'`).then(res => {
        authors = res.rows
    })
    dirList.forEach(dir => {
        readFile(path.join(rootDir, `json/${dir}`)).then(async res => {
            const json = JSON.parse(res.toString())
            console.log(`read file: ${dir}, data length: ${json.length}`)
            const arrives = splitBigArray(json, 1000)
            for (let i = 0; i < arrives.length; i++) {
                const subArray = arrives[i]
                let sql = `insert into poetry (title, author, author_id, content, dynasty, strains_id) values `
                let values = ''
                for (let j = 0; j < subArray.length; j++) {
                    const poetry = subArray[j]
                    const author_index = await authors.findIndex(a => a.name === poetry.author)
                    const author_id = authors[author_index].id
                    const content = array2Line(poetry.paragraphs)
                    const val = `('${poetry.title}', '${poetry.author}', ${author_id}, '${content}', '${dynasty}', '${poetry.id}')`
                    values += values === '' ? val : `,${val}`
                }
                sql += values
                query(sql).then(res => {
                    console.log(`process ${res.rowCount} data`)
                }, err => {
                    console.error(err)
                })
            }
        })
    })

}

async function makeNanTangPoetryData() {
    let authors = []
    await query(`select id,name from poetry_authors where dynasty= 'nantang'`).then(res => {
        authors = res.rows
    })
    const dir = path.join(rootDir, 'wudai/nantang/poetrys.json')
    readFile(dir).then(async res => {
        const json = JSON.parse(res.toString())
        console.log(`read file: ${dir}, data length: ${json.length}`)
        const arrives = splitBigArray(json, 1000)
        for (let i = 0; i < arrives.length; i++) {
            const subArray = arrives[i]
            let sql = `insert into nantang (title, author, author_id, content, rhythmic) values `
            let values = ''
            for (let j = 0; j < subArray.length; j++) {
                const poetry = subArray[j]
                const author_index = await authors.findIndex(a => a.name === poetry.author)
                const author_id = authors[author_index].id
                const content = array2Line(poetry.paragraphs)
                const val = `('${poetry.title}', '${poetry.author}', ${author_id}, '${content}', '${poetry.rhythmic}')`
                values += values === '' ? val : `,${val}`
            }
            sql += values
            query(sql).then(res => {
                console.log(`process ${res.rowCount} data`)
            }, err => {
                console.error(err)
            })
        }
    })
}

async function makePoemsData() {
    let authors = []
    await query(`select id,name from poems_authors`).then(res => {
        authors = res.rows
    })
    let dirList = []
    await readDir('ci/', /^ci.song.*.json/).then(res => {
        dirList = res
    }, err => {
        console.error(err)
    })

    dirList.forEach(dir => {
        readFile(path.join(rootDir, `ci/${dir}`)).then(async res => {
            const json = JSON.parse(res.toString())
            console.log(`read file: ${dir}, data length: ${json.length}`)
            const arrives = splitBigArray(json, 1000)
            for (let i = 0; i < arrives.length; i++) {
                const subArray = arrives[i]
                let sql = `insert into poems (rhythmic, author, author_id, content) values `
                let values = ''
                for (let j = 0; j < subArray.length; j++) {
                    const poetry = subArray[j]
                    const author_index = await authors.findIndex(a => a.name === poetry.author)
                    let author_id = 0
                    if (author_index > -1) {
                        author_id = authors[author_index].id
                    }
                    const content = array2Line(poetry.paragraphs)
                    const val = `('${poetry.rhythmic}', '${poetry.author}', ${author_id}, '${content}')`
                    values += values === '' ? val : `,${val}`
                }
                sql += values
                query(sql).then(res => {
                    console.log(`process ${res.rowCount} data`)
                }, err => {
                    console.error(err)
                })
            }
        })
    })
}

function makeCaocaoData() {
    const dir = path.join(rootDir, 'caocaoshiji/caocao.json')
    readFile(dir).then(res => {
        const json = JSON.parse(res.toString())
        console.log(`read file: ${dir}, data length: ${json.length}`)
        const arrives = splitBigArray(json, 1000)
        arrives.forEach(subArray => {
            let sql = `insert into caocao (title, content) values `
            let values = ''
            subArray.forEach(poetry => {
                const content = array2Line(poetry.paragraphs)
                const val = `('${poetry.title}', '${content}')`
                values += values === '' ? val : `,${val}`
            })
            sql += values
            query(sql).then(res => {
                console.log(`process ${res.rowCount} data`)
            }, err => {
                console.error(err)
            })
        })
    })
}

function makeLunyuData() {
    const dir = path.join(rootDir, 'lunyu/lunyu.json')
    readFile(dir).then(res => {
        const json = JSON.parse(res.toString())
        console.log(`read file: ${dir}, data length: ${json.length}`)
        const arrives = splitBigArray(json, 1000)
        arrives.forEach(subArray => {
            let sql = `insert into lunyu (chapter, content) values `
            let values = ''
            subArray.forEach(poetry => {
                const content = array2Line(poetry.paragraphs)
                const val = `('${poetry.chapter}', '${content}')`
                values += values === '' ? val : `,${val}`
            })
            sql += values
            query(sql).then(res => {
                console.log(`process ${res.rowCount} data`)
            }, err => {
                console.error(err)
            })
        })
    })
}

function makeShiJingData() {
    const dir = path.join(rootDir, 'shijing/shijing.json')
    readFile(dir).then(res => {
        const json = JSON.parse(res.toString())
        console.log(`read file: ${dir}, data length: ${json.length}`)
        const arrives = splitBigArray(json, 1000)
        arrives.forEach(subArray => {
            let sql = `insert into shijing (title, chapter, section, content) values `
            let values = ''
            subArray.forEach(poetry => {
                const content = array2Line(poetry.content)
                const val = `('${poetry.title}', '${poetry.chapter}', '${poetry.section}', '${content}')`
                values += values === '' ? val : `,${val}`
            })
            sql += values
            query(sql).then(res => {
                console.log(`process ${res.rowCount} data`)
            }, err => {
                console.error(err)
            })
        })
    })
}

async function makeStrainsData() {
    let dirList = []
    await readDir('strains/json', /^poet.*.json/).then(res => {
        dirList = res
    }, err => {
        console.error(err)
    })

    dirList.forEach(dir => {
        readFile(path.join(rootDir, `strains/json/${dir}`)).then(async res => {
            const json = JSON.parse(res.toString())
            console.log(`read file: ${dir}, data length: ${json.length}`)
            const arrives = splitBigArray(json, 1000)
            for (let i = 0; i < arrives.length; i++) {
                const subArray = arrives[i]
                let sql = `insert into strains (id, strains) values `
                let values = ''
                for (let j = 0; j < subArray.length; j++) {
                    const poetry = subArray[j]
                    const content = array2Line(poetry.strains)
                    const val = `('${poetry.id}', '${content}')`
                    values += values === '' ? val : `,${val}`
                }
                sql += values
                query(sql).then(res => {
                    console.log(`process ${res.rowCount} data`)
                }, err => {
                    console.error(err)
                })
            }
        })
    })
}

function makeYouMengYingData() {
    const dir = path.join(rootDir, 'youmengying/youmengying.json')
    readFile(dir).then(res => {
        const json = JSON.parse(res.toString())
        console.log(`read file: ${dir}, data length: ${json.length}`)
        const arrives = splitBigArray(json, 1000)
        arrives.forEach(subArray => {
            let sql = `insert into youmengying (content, comment) values `
            let values = ''
            subArray.forEach(poetry => {
                const comment = array2Line(poetry.comment)
                const val = `('${poetry.content}', '${comment}')`
                values += values === '' ? val : `,${val}`
            })
            sql += values
            query(sql).then(res => {
                console.log(`process ${res.rowCount} data`)
            }, err => {
                console.error(err)
            })
        })
    })
}

function makeSiShuWuJingData() {
    const dirList = [
        {
            section: 'DaXue',
            path: path.join(rootDir, 'sishuwujing/daxue.json')
        },
        {
            section: 'MengZi',
            path: path.join(rootDir, 'sishuwujing/mengzi.json')
        },
        {
            section: 'zhongyong',
            path: path.join(rootDir, 'sishuwujing/zhongyong.json')
        }
    ]

    dirList.forEach(dir => {
        readFile(dir.path).then(res => {
            const json = JSON.parse(res.toString())
            console.log(`read file: ${dir}, data length: ${json.length}`)
            let arrives = []
            if (json instanceof Array) {
                arrives = json
            } else {
                arrives.push(json)
            }
            arrives.forEach(poetry => {
                let sql = `insert into sishuwujing (chapter, section, content) values `
                let values = ''
                const content = array2Line(poetry.paragraphs)
                const val = `('${poetry.chapter}', '${dir.section}', '${content}')`
                values += values === '' ? val : `,${val}`
                sql += values
                query(sql).then(res => {
                    console.log(`process ${res.rowCount} data`)
                }, err => {
                    console.error(err)
                })
            })
        })
    })
}
