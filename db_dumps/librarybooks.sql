--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1)

-- Started on 2024-06-18 09:21:16 EDT

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
-- TOC entry 221 (class 1255 OID 16451)
-- Name: get_author_book_info(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_author_book_info() RETURNS TABLE(author_name character varying, book_title character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        a.name AS author_name,
        b.title AS book_title
    FROM
        author_book ab
    JOIN
        authors a ON ab.author_id = a.id
    JOIN
        books b ON ab.book_id = b.id;
END;
$$;


ALTER FUNCTION public.get_author_book_info() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16415)
-- Name: author_book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author_book (
    book_id integer NOT NULL,
    author_id integer NOT NULL
);


ALTER TABLE public.author_book OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16400)
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.authors_id_seq OWNER TO postgres;

--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 215
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;


--
-- TOC entry 218 (class 1259 OID 16407)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    image_path text NOT NULL
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16406)
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_id_seq OWNER TO postgres;

--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 217
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- TOC entry 220 (class 1259 OID 16430)
-- Name: page; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.page (
    number integer NOT NULL,
    book_id integer NOT NULL,
    content text
);


ALTER TABLE public.page OWNER TO postgres;

--
-- TOC entry 3217 (class 2604 OID 16403)
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);


--
-- TOC entry 3218 (class 2604 OID 16410)
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- TOC entry 3377 (class 0 OID 16415)
-- Dependencies: 219
-- Data for Name: author_book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.author_book (book_id, author_id) FROM stdin;
1	5
2	4
3	3
4	2
5	1
6	1
\.


--
-- TOC entry 3374 (class 0 OID 16400)
-- Dependencies: 216
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authors (id, name) FROM stdin;
1	Александр Сергеевич Пушкин
2	Лев Николаевич Толстой
3	Аркадий Петрович Гайдар
4	Николай Васильевич Гоголь
5	Владимир Семёнович Высоцкий
\.


--
-- TOC entry 3376 (class 0 OID 16407)
-- Dependencies: 218
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (id, title, image_path) FROM stdin;
6	Сказка о рыбаке и рыбке	./img/titlebook/A._Pushkin__Skazka_o_rybake_i_rybke.png
5	Евгений Онегин	./img/titlebook/Aleksandr_Pushkin__Evgenij_Onegin.png
4	Анна Каренина	./img/titlebook/Lev_Tolstoj__Anna_Karenina.png
3	Тимур и его команда	./img/titlebook/Arkadij_Gajdar__Timur_i_ego_komanda.png
2	Вий	./img/titlebook/Nikolaj_Gogol__Vij.png
1	Четыре четверти пути	./img/titlebook/Vladimir_Vysotskij__Chetyre_chetverti_puti.png
\.


--
-- TOC entry 3378 (class 0 OID 16430)
-- Dependencies: 220
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.page (number, book_id, content) FROM stdin;
\.


--
-- TOC entry 3386 (class 0 OID 0)
-- Dependencies: 215
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_id_seq', 5, true);


--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 217
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 6, true);


--
-- TOC entry 3224 (class 2606 OID 16419)
-- Name: author_book author_book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author_book
    ADD CONSTRAINT author_book_pkey PRIMARY KEY (book_id, author_id);


--
-- TOC entry 3220 (class 2606 OID 16405)
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- TOC entry 3222 (class 2606 OID 16414)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- TOC entry 3226 (class 2606 OID 16436)
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (number, book_id);


--
-- TOC entry 3227 (class 2606 OID 16425)
-- Name: author_book author_book_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author_book
    ADD CONSTRAINT author_book_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(id) ON DELETE CASCADE;


--
-- TOC entry 3228 (class 2606 OID 16420)
-- Name: author_book author_book_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author_book
    ADD CONSTRAINT author_book_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- TOC entry 3229 (class 2606 OID 16437)
-- Name: page page_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


-- Completed on 2024-06-18 09:21:19 EDT

--
-- PostgreSQL database dump complete
--

