const {Pool} = require('pg')

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

pool.connect().then(client => {
    client.query('select now()').then(res => {
        console.log(res)
        client.release()
    }).catch(err => {
        console.error(err)
        client.release()
    })
})

