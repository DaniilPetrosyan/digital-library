--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1)

-- Started on 2024-06-18 09:19:57 EDT

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
-- TOC entry 216 (class 1259 OID 16390)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    login text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16389)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3203 (class 2604 OID 16393)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3350 (class 0 OID 16390)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, login, password) FROM stdin;
1	testgena1	123
2	testgena2	e219eef0a868b0c73fe3b72d2fe8ad13c64b068f84b656bef036c45ea8c1edd6e6311a20c62661eda36e215eb8d6fc6e2e33bb64fff2b815d4190bec200f9f2a
3	testgena3	96e8d9a65e49701a4c28d7a21b26196471a8ab66c935dcf55e7c050f0f176698f29774d0e1a1bc604990daaf97677fb9cbb2982f98e0159787e7c485bdd8a371
4	testgena4	65a92c1794a3026354eb210edf09dbc4f1b8e4a2abb8b63a194fdfdbb848b1e9f2a3bfc5f38a4d978f1319da701c52e98e14c7b3f17b26f456a9e26a2cd0c70b
5	daniel	f58e19ffe2d5ef9a043cb71fddca34a9bdc7eeb1d4d6fd578df11cb289e92b4852d216bbfa439fab243a1479fea0158551f3dc0a8865c8d58a2d6ee6638b4ea9
6	petrsoyan	05af692fd9101b49455d7b3c9a43fed08a32cb59d89f2a6b277cc81e92adaf0f370c9ff56bcf600724653a4f07eaf66258661259ea61fb65c253e4cadf87b4ff
7	TestPedrik	0cab8eef126b6c1d0d81d2eba200305c8e8757213373a6b903f8dcb01fd5f5306035ae93ad12bb0731076e6164750141bfa3ed8a166f2e510d05d65de086d484
8	TestikPedrik	1ed5e47f78e214f8c1e1c14e163032863a8ed07b782dbb4e6f4496f44e9388910086f6f3fa40b3e38b126c169ef58771f3d7bd6b775e72bd63007547616f5619
9	TestikPedrik1	bb5727217a3545f74f8748a0ea70b6ec99f6c6d270c866910a5bf305ee050a79edb2ddcbc4b54dc39c7121b84b8643edc59826bd9ca118442ebad2c51760895e
10	Teasfsdg	0ecbc96796314220c82b2e4be18b3a10ccf0eda278e5bff87afa902ce3f6cc67ed00a5752e8d1668a87920fb7f430899aa3e780331298bd3b468f08ee74a3ac9
11	Teasfsdg1	f18b1e780b4f81b0892615e0283daf2f4f7daf2ec116cc4e3d5c81df6a9f2ef189db613faaab8df1269039ef970c2673beb6d32c2e686aeb540023d841eb2353
12	Teasfsdg2	d0a1fae4294714b4d460c70d52fc567edd35702ad0ed64931d77f9f17c305b00358bdaceee1146c054996455b2ea04e9946726c7354ff4ba30de3530acb88799
13	Teasfsdg3	7979961cdc87823954cb89189e3d1d4fc2db018e80030bce73c6be5c2eaff13ccf71b283e0dc347b59e035d4b3f0e317c49eb00eba45f2731bd14b7764ddd271
14	sdgkjhSdjkghsgd	10bad3d475ab553b6fae01b893245ce06b40bfd8324fbd106bf0c851ba8250bc5f89ffdee891fb6d9e5392ee4a821fa5a9c8203ed003c30044af0c2b591465b9
15	Gena	03c1f1254539cd123e0a41c02ecb33e9fb2a75c76ede7668cfbee4e9295706652b898d23612847263378d3d76b916dd78600f76f1a73f9c6452350f75f3c5a0b
16	Students	74e945b92f99c45a44d7ab12db12fe3dcd3697129c3cda002a6cb7a3c297b99466f8e63b34b205d3ccfee96c4b38065f74fd6c702361aea882a5574aea9812ec
17	TestGenaVas	1447fdba501702a5107061c4bc39d8c1220dfad9db2723988e02c9f5645160245b41d5f2a200b16283b789a943da9b9446bbe140e23bd4a788892d554fb964c2
18	testGenaVas	67f5a6362b81e5f1110191952f4e101d1deb5ef0dc0d22c55a8c7581e482526b956d59f197ae15319d0f8b7c320bc7b1a6f71a88bbc395941387c1c6fafbec51
19	testInvite	ba89c2ad105a2f8c1a3c4a343b3407bf490551f2503c50eb9f139427ef33bb921c929f7ea102a9d5d242047f87c004f7f98497caa9d709aa5b8e08e99668f37d
\.


--
-- TOC entry 3357 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 19, true);


--
-- TOC entry 3205 (class 2606 OID 16397)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Completed on 2024-06-18 09:20:01 EDT

--
-- PostgreSQL database dump complete
--

