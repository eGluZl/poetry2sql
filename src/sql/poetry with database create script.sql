--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: poetry; Type: DATABASE; Schema: -; Owner: egluzl
--

CREATE DATABASE poetry WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Chinese (Simplified)_China.936' LC_CTYPE = 'Chinese (Simplified)_China.936';


ALTER DATABASE poetry OWNER TO egluzl;

\connect poetry

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE poetry; Type: COMMENT; Schema: -; Owner: egluzl
--

COMMENT ON DATABASE poetry IS '中国古诗词数据库';


--
-- Name: poetry; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA poetry;


ALTER SCHEMA poetry OWNER TO postgres;

--
-- Name: SCHEMA poetry; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA poetry IS 'poetry schemas';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: caocao; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.caocao (
    id integer NOT NULL,
    title character varying NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.caocao OWNER TO egluzl;

--
-- Name: TABLE caocao; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.caocao IS '曹操詩集數據';


--
-- Name: caocao_id_seq; Type: SEQUENCE; Schema: public; Owner: egluzl
--

CREATE SEQUENCE public.caocao_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.caocao_id_seq OWNER TO egluzl;

--
-- Name: caocao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: egluzl
--

ALTER SEQUENCE public.caocao_id_seq OWNED BY public.caocao.id;


--
-- Name: huajianji; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.huajianji (
    id integer NOT NULL,
    title character varying NOT NULL,
    author character varying NOT NULL,
    rhythmic character varying NOT NULL,
    content text NOT NULL,
    notes text NOT NULL,
    roll character varying NOT NULL
);


ALTER TABLE public.huajianji OWNER TO egluzl;

--
-- Name: TABLE huajianji; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.huajianji IS '花間集 數據';


--
-- Name: huajianji_id_seq; Type: SEQUENCE; Schema: public; Owner: egluzl
--

CREATE SEQUENCE public.huajianji_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.huajianji_id_seq OWNER TO egluzl;

--
-- Name: huajianji_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: egluzl
--

ALTER SEQUENCE public.huajianji_id_seq OWNED BY public.huajianji.id;


--
-- Name: lunyu; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.lunyu (
    id integer NOT NULL,
    chapter character varying NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.lunyu OWNER TO egluzl;

--
-- Name: TABLE lunyu; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.lunyu IS '論語數據';


--
-- Name: lunyu_id_seq; Type: SEQUENCE; Schema: public; Owner: egluzl
--

CREATE SEQUENCE public.lunyu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lunyu_id_seq OWNER TO egluzl;

--
-- Name: lunyu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: egluzl
--

ALTER SEQUENCE public.lunyu_id_seq OWNED BY public.lunyu.id;


--
-- Name: nantang; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.nantang (
    id integer NOT NULL,
    rhythmic character varying NOT NULL,
    title character varying NOT NULL,
    author character varying NOT NULL,
    author_id character varying NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.nantang OWNER TO egluzl;

--
-- Name: TABLE nantang; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.nantang IS '南唐二主詞';


--
-- Name: nantang_id_seq; Type: SEQUENCE; Schema: public; Owner: egluzl
--

CREATE SEQUENCE public.nantang_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nantang_id_seq OWNER TO egluzl;

--
-- Name: nantang_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: egluzl
--

ALTER SEQUENCE public.nantang_id_seq OWNED BY public.nantang.id;


--
-- Name: poems; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.poems (
    id integer NOT NULL,
    rhythmic character varying NOT NULL,
    author character varying NOT NULL,
    author_id integer DEFAULT 0,
    content text NOT NULL
);


ALTER TABLE public.poems OWNER TO egluzl;

--
-- Name: TABLE poems; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.poems IS '宋詞數據';


--
-- Name: poems_authors; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.poems_authors (
    id integer NOT NULL,
    name character varying NOT NULL,
    intro_short text,
    intro_long text
);


ALTER TABLE public.poems_authors OWNER TO egluzl;

--
-- Name: TABLE poems_authors; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.poems_authors IS '宋詞作者數據';


--
-- Name: poems_authors_id_seq; Type: SEQUENCE; Schema: public; Owner: egluzl
--

CREATE SEQUENCE public.poems_authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poems_authors_id_seq OWNER TO egluzl;

--
-- Name: poems_authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: egluzl
--

ALTER SEQUENCE public.poems_authors_id_seq OWNED BY public.poems_authors.id;


--
-- Name: poems_id_seq; Type: SEQUENCE; Schema: public; Owner: egluzl
--

CREATE SEQUENCE public.poems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poems_id_seq OWNER TO egluzl;

--
-- Name: poems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: egluzl
--

ALTER SEQUENCE public.poems_id_seq OWNED BY public.poems.id;


--
-- Name: poetry; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.poetry (
    id integer NOT NULL,
    title character varying NOT NULL,
    author character varying NOT NULL,
    author_id integer DEFAULT 0 NOT NULL,
    content text NOT NULL,
    dynasty character varying NOT NULL,
    strains_id character varying NOT NULL
);


ALTER TABLE public.poetry OWNER TO egluzl;

--
-- Name: TABLE poetry; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.poetry IS '唐詩、宋詩數據';


--
-- Name: poetry_authors; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.poetry_authors (
    id integer NOT NULL,
    name character varying NOT NULL,
    intro text,
    dynasty character varying
);


ALTER TABLE public.poetry_authors OWNER TO egluzl;

--
-- Name: TABLE poetry_authors; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.poetry_authors IS '唐詩、宋詩作者以及南唐二主數據';


--
-- Name: poetry_authors_id_seq; Type: SEQUENCE; Schema: public; Owner: egluzl
--

CREATE SEQUENCE public.poetry_authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poetry_authors_id_seq OWNER TO egluzl;

--
-- Name: poetry_authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: egluzl
--

ALTER SEQUENCE public.poetry_authors_id_seq OWNED BY public.poetry_authors.id;


--
-- Name: poetry_id_seq; Type: SEQUENCE; Schema: public; Owner: egluzl
--

CREATE SEQUENCE public.poetry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poetry_id_seq OWNER TO egluzl;

--
-- Name: poetry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: egluzl
--

ALTER SEQUENCE public.poetry_id_seq OWNED BY public.poetry.id;


--
-- Name: shijing; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.shijing (
    id integer NOT NULL,
    chapter character varying NOT NULL,
    section character varying NOT NULL,
    title character varying NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.shijing OWNER TO egluzl;

--
-- Name: TABLE shijing; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.shijing IS '詩經數據';


--
-- Name: shijing_id_seq; Type: SEQUENCE; Schema: public; Owner: egluzl
--

CREATE SEQUENCE public.shijing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shijing_id_seq OWNER TO egluzl;

--
-- Name: shijing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: egluzl
--

ALTER SEQUENCE public.shijing_id_seq OWNED BY public.shijing.id;


--
-- Name: sishuwujing; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.sishuwujing (
    id integer NOT NULL,
    section character varying NOT NULL,
    chapter character varying NOT NULL,
    content text
);


ALTER TABLE public.sishuwujing OWNER TO egluzl;

--
-- Name: TABLE sishuwujing; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.sishuwujing IS '四書五經數據';


--
-- Name: sishuwujing_id_seq; Type: SEQUENCE; Schema: public; Owner: egluzl
--

CREATE SEQUENCE public.sishuwujing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sishuwujing_id_seq OWNER TO egluzl;

--
-- Name: sishuwujing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: egluzl
--

ALTER SEQUENCE public.sishuwujing_id_seq OWNED BY public.sishuwujing.id;


--
-- Name: strains; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.strains (
    id character varying NOT NULL,
    strains text NOT NULL
);


ALTER TABLE public.strains OWNER TO egluzl;

--
-- Name: TABLE strains; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.strains IS '唐詩、宋詩韻律';


--
-- Name: youmengying; Type: TABLE; Schema: public; Owner: egluzl
--

CREATE TABLE public.youmengying (
    id integer NOT NULL,
    content text NOT NULL,
    comment text NOT NULL
);


ALTER TABLE public.youmengying OWNER TO egluzl;

--
-- Name: TABLE youmengying; Type: COMMENT; Schema: public; Owner: egluzl
--

COMMENT ON TABLE public.youmengying IS '幽夢令';


--
-- Name: youmengying_id_seq; Type: SEQUENCE; Schema: public; Owner: egluzl
--

CREATE SEQUENCE public.youmengying_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.youmengying_id_seq OWNER TO egluzl;

--
-- Name: youmengying_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: egluzl
--

ALTER SEQUENCE public.youmengying_id_seq OWNED BY public.youmengying.id;


--
-- Name: caocao id; Type: DEFAULT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.caocao ALTER COLUMN id SET DEFAULT nextval('public.caocao_id_seq'::regclass);


--
-- Name: huajianji id; Type: DEFAULT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.huajianji ALTER COLUMN id SET DEFAULT nextval('public.huajianji_id_seq'::regclass);


--
-- Name: lunyu id; Type: DEFAULT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.lunyu ALTER COLUMN id SET DEFAULT nextval('public.lunyu_id_seq'::regclass);


--
-- Name: nantang id; Type: DEFAULT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.nantang ALTER COLUMN id SET DEFAULT nextval('public.nantang_id_seq'::regclass);


--
-- Name: poems id; Type: DEFAULT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.poems ALTER COLUMN id SET DEFAULT nextval('public.poems_id_seq'::regclass);


--
-- Name: poems_authors id; Type: DEFAULT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.poems_authors ALTER COLUMN id SET DEFAULT nextval('public.poems_authors_id_seq'::regclass);


--
-- Name: poetry id; Type: DEFAULT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.poetry ALTER COLUMN id SET DEFAULT nextval('public.poetry_id_seq'::regclass);


--
-- Name: poetry_authors id; Type: DEFAULT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.poetry_authors ALTER COLUMN id SET DEFAULT nextval('public.poetry_authors_id_seq'::regclass);


--
-- Name: shijing id; Type: DEFAULT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.shijing ALTER COLUMN id SET DEFAULT nextval('public.shijing_id_seq'::regclass);


--
-- Name: sishuwujing id; Type: DEFAULT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.sishuwujing ALTER COLUMN id SET DEFAULT nextval('public.sishuwujing_id_seq'::regclass);


--
-- Name: youmengying id; Type: DEFAULT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.youmengying ALTER COLUMN id SET DEFAULT nextval('public.youmengying_id_seq'::regclass);


--
-- Data for Name: caocao; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.caocao (id, title, content) FROM stdin;
\.


--
-- Data for Name: huajianji; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.huajianji (id, title, author, rhythmic, content, notes, roll) FROM stdin;
\.


--
-- Data for Name: lunyu; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.lunyu (id, chapter, content) FROM stdin;
\.


--
-- Data for Name: nantang; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.nantang (id, rhythmic, title, author, author_id, content) FROM stdin;
\.


--
-- Data for Name: poems; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.poems (id, rhythmic, author, author_id, content) FROM stdin;
\.


--
-- Data for Name: poems_authors; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.poems_authors (id, name, intro_short, intro_long) FROM stdin;
\.


--
-- Data for Name: poetry; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.poetry (id, title, author, author_id, content, dynasty, strains_id) FROM stdin;
\.


--
-- Data for Name: poetry_authors; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.poetry_authors (id, name, intro, dynasty) FROM stdin;
\.


--
-- Data for Name: shijing; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.shijing (id, chapter, section, title, content) FROM stdin;
\.


--
-- Data for Name: sishuwujing; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.sishuwujing (id, section, chapter, content) FROM stdin;
\.


--
-- Data for Name: strains; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.strains (id, strains) FROM stdin;
\.


--
-- Data for Name: youmengying; Type: TABLE DATA; Schema: public; Owner: egluzl
--

COPY public.youmengying (id, content, comment) FROM stdin;
\.


--
-- Name: caocao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: egluzl
--

SELECT pg_catalog.setval('public.caocao_id_seq', 1, false);


--
-- Name: huajianji_id_seq; Type: SEQUENCE SET; Schema: public; Owner: egluzl
--

SELECT pg_catalog.setval('public.huajianji_id_seq', 1, false);


--
-- Name: lunyu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: egluzl
--

SELECT pg_catalog.setval('public.lunyu_id_seq', 1, false);


--
-- Name: nantang_id_seq; Type: SEQUENCE SET; Schema: public; Owner: egluzl
--

SELECT pg_catalog.setval('public.nantang_id_seq', 1, false);


--
-- Name: poems_authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: egluzl
--

SELECT pg_catalog.setval('public.poems_authors_id_seq', 1, false);


--
-- Name: poems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: egluzl
--

SELECT pg_catalog.setval('public.poems_id_seq', 1, false);


--
-- Name: poetry_authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: egluzl
--

SELECT pg_catalog.setval('public.poetry_authors_id_seq', 1, false);


--
-- Name: poetry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: egluzl
--

SELECT pg_catalog.setval('public.poetry_id_seq', 1, false);


--
-- Name: shijing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: egluzl
--

SELECT pg_catalog.setval('public.shijing_id_seq', 1, false);


--
-- Name: sishuwujing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: egluzl
--

SELECT pg_catalog.setval('public.sishuwujing_id_seq', 1, false);


--
-- Name: youmengying_id_seq; Type: SEQUENCE SET; Schema: public; Owner: egluzl
--

SELECT pg_catalog.setval('public.youmengying_id_seq', 1, false);


--
-- Name: caocao caocao_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.caocao
    ADD CONSTRAINT caocao_pk PRIMARY KEY (id);


--
-- Name: huajianji huajianji_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.huajianji
    ADD CONSTRAINT huajianji_pk PRIMARY KEY (id);


--
-- Name: lunyu lunyu_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.lunyu
    ADD CONSTRAINT lunyu_pk PRIMARY KEY (id);


--
-- Name: nantang nantang_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.nantang
    ADD CONSTRAINT nantang_pk PRIMARY KEY (id);


--
-- Name: poems_authors poems_authors_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.poems_authors
    ADD CONSTRAINT poems_authors_pk PRIMARY KEY (id);


--
-- Name: poems poems_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.poems
    ADD CONSTRAINT poems_pk PRIMARY KEY (id);


--
-- Name: poetry_authors poetry_authors_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.poetry_authors
    ADD CONSTRAINT poetry_authors_pk PRIMARY KEY (id);


--
-- Name: poetry poetry_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.poetry
    ADD CONSTRAINT poetry_pk PRIMARY KEY (id);


--
-- Name: shijing shijing_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.shijing
    ADD CONSTRAINT shijing_pk PRIMARY KEY (id);


--
-- Name: sishuwujing sishuwujing_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.sishuwujing
    ADD CONSTRAINT sishuwujing_pk PRIMARY KEY (id);


--
-- Name: strains strains_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.strains
    ADD CONSTRAINT strains_pk PRIMARY KEY (id);


--
-- Name: youmengying youmengying_pk; Type: CONSTRAINT; Schema: public; Owner: egluzl
--

ALTER TABLE ONLY public.youmengying
    ADD CONSTRAINT youmengying_pk PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

