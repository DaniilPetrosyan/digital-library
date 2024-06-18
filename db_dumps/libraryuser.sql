--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1)

-- Started on 2024-06-18 09:21:56 EDT

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16444)
-- Name: user_books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_books (
    id integer NOT NULL,
    login_user character varying(255) NOT NULL,
    book_id integer NOT NULL,
    author_id integer NOT NULL
);


ALTER TABLE public.user_books OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16443)
-- Name: user_books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_books_id_seq OWNER TO postgres;

--
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 215
-- Name: user_books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_books_id_seq OWNED BY public.user_books.id;


--
-- TOC entry 3203 (class 2604 OID 16447)
-- Name: user_books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_books ALTER COLUMN id SET DEFAULT nextval('public.user_books_id_seq'::regclass);


--
-- TOC entry 3350 (class 0 OID 16444)
-- Dependencies: 216
-- Data for Name: user_books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_books (id, login_user, book_id, author_id) FROM stdin;
13	testGenaVas	1	5
14	testGenaVas	2	4
23	testGenaVas	6	1
24	testGenaVas	5	1
31	daniel	1	5
33	testInvite	1	5
35	testInvite	3	3
\.


--
-- TOC entry 3357 (class 0 OID 0)
-- Dependencies: 215
-- Name: user_books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_books_id_seq', 35, true);


--
-- TOC entry 3205 (class 2606 OID 16449)
-- Name: user_books user_books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_books
    ADD CONSTRAINT user_books_pkey PRIMARY KEY (id);


-- Completed on 2024-06-18 09:21:59 EDT

--
-- PostgreSQL database dump complete
--

