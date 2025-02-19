CREATE DATABASE rekadw;
\c rekadw
--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6
-- Dumped by pg_dump version 13.0 (Debian 13.0-1.pgdg100+1)

-- Started on 2021-05-30 11:04:07 UTC

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

--
-- TOC entry 281 (class 1259 OID 17709)
-- Name: product; Type: TABLE; Schema: production; Owner: sqladmin
--

CREATE SCHEMA production
    AUTHORIZATION sqladmin;

COMMENT ON SCHEMA production
    IS 'Contains objects related to products, inventory, and manufacturing.';
    
CREATE SCHEMA public
    AUTHORIZATION sqladmin;

COMMENT ON SCHEMA public
    IS 'standard public schema';    

CREATE TABLE production.product (
    productid integer NOT NULL,
    name public."Name" NOT NULL,
    productnumber character varying(25) NOT NULL,
    makeflag public."Flag" DEFAULT true NOT NULL,
    finishedgoodsflag public."Flag" DEFAULT true NOT NULL,
    color character varying(15),
    safetystocklevel smallint NOT NULL,
    reorderpoint smallint NOT NULL,
    standardcost numeric NOT NULL,
    listprice numeric NOT NULL,
    size character varying(5),
    sizeunitmeasurecode character(3),
    weightunitmeasurecode character(3),
    weight numeric(8,2),
    daystomanufacture integer NOT NULL,
    productline character(2),
    class character(2),
    style character(2),
    productsubcategoryid integer,
    productmodelid integer,
    sellstartdate timestamp without time zone NOT NULL,
    sellenddate timestamp without time zone,
    discontinueddate timestamp without time zone,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Product_Class" CHECK (((upper((class)::text) = ANY (ARRAY['L'::text, 'M'::text, 'H'::text])) OR (class IS NULL))),
    CONSTRAINT "CK_Product_DaysToManufacture" CHECK ((daystomanufacture >= 0)),
    CONSTRAINT "CK_Product_ListPrice" CHECK ((listprice >= 0.00)),
    CONSTRAINT "CK_Product_ProductLine" CHECK (((upper((productline)::text) = ANY (ARRAY['S'::text, 'T'::text, 'M'::text, 'R'::text])) OR (productline IS NULL))),
    CONSTRAINT "CK_Product_ReorderPoint" CHECK ((reorderpoint > 0)),
    CONSTRAINT "CK_Product_SafetyStockLevel" CHECK ((safetystocklevel > 0)),
    CONSTRAINT "CK_Product_SellEndDate" CHECK (((sellenddate >= sellstartdate) OR (sellenddate IS NULL))),
    CONSTRAINT "CK_Product_StandardCost" CHECK ((standardcost >= 0.00)),
    CONSTRAINT "CK_Product_Style" CHECK (((upper((style)::text) = ANY (ARRAY['W'::text, 'M'::text, 'U'::text])) OR (style IS NULL))),
    CONSTRAINT "CK_Product_Weight" CHECK ((weight > 0.00))
);


ALTER TABLE production.product OWNER TO sqladmin;

--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE product; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON TABLE production.product IS 'Products sold or used in the manfacturing of sold products.';


--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.productid; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.productid IS 'Primary key for Product records.';


--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.name; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.name IS 'Name of the product.';


--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.productnumber; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.productnumber IS 'Unique product identification number.';


--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.makeflag; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.makeflag IS '0 = Product is purchased, 1 = Product is manufactured in-house.';


--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.finishedgoodsflag; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.finishedgoodsflag IS '0 = Product is not a salable item. 1 = Product is salable.';


--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.color; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.color IS 'Product color.';


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.safetystocklevel; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.safetystocklevel IS 'Minimum inventory quantity.';


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.reorderpoint; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.reorderpoint IS 'Inventory level that triggers a purchase order or work order.';


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.standardcost; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.standardcost IS 'Standard cost of the product.';


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.listprice; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.listprice IS 'Selling price.';


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.size; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.size IS 'Product size.';


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.sizeunitmeasurecode; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.sizeunitmeasurecode IS 'Unit of measure for Size column.';


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.weightunitmeasurecode; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.weightunitmeasurecode IS 'Unit of measure for Weight column.';


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.weight; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.weight IS 'Product weight.';


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.daystomanufacture; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.daystomanufacture IS 'Number of days required to manufacture the product.';


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.productline; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.productline IS 'R = Road, M = Mountain, T = Touring, S = Standard';


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.class; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.class IS 'H = High, M = Medium, L = Low';


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.style; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.style IS 'W = Womens, M = Mens, U = Universal';


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.productsubcategoryid; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.productsubcategoryid IS 'Product is a member of this product subcategory. Foreign key to ProductSubCategory.ProductSubCategoryID.';


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.productmodelid; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.productmodelid IS 'Product is a member of this product model. Foreign key to ProductModel.ProductModelID.';


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.sellstartdate; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.sellstartdate IS 'Date the product was available for sale.';


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.sellenddate; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.sellenddate IS 'Date the product was no longer available for sale.';


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN product.discontinueddate; Type: COMMENT; Schema: production; Owner: sqladmin
--

COMMENT ON COLUMN production.product.discontinueddate IS 'Date the product was discontinued.';


--
-- TOC entry 324 (class 1259 OID 17960)
-- Name: product_productid_seq; Type: SEQUENCE; Schema: production; Owner: sqladmin
--

CREATE SEQUENCE production.product_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.product_productid_seq OWNER TO sqladmin;

--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 324
-- Name: product_productid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: sqladmin
--

ALTER SEQUENCE production.product_productid_seq OWNED BY production.product.productid;


--
-- TOC entry 4738 (class 2604 OID 18417)
-- Name: product productid; Type: DEFAULT; Schema: production; Owner: sqladmin
--

ALTER TABLE ONLY production.product ALTER COLUMN productid SET DEFAULT nextval('production.product_productid_seq'::regclass);


--
-- TOC entry 4971 (class 0 OID 17709)
-- Dependencies: 281
-- Data for Name: product; Type: TABLE DATA; Schema: production; Owner: sqladmin
--

COPY production.product (productid, name, productnumber, makeflag, finishedgoodsflag, color, safetystocklevel, reorderpoint, standardcost, listprice, size, sizeunitmeasurecode, weightunitmeasurecode, weight, daystomanufacture, productline, class, style, productsubcategoryid, productmodelid, sellstartdate, sellenddate, discontinueddate, rowguid, modifieddate) FROM stdin;
1	Adjustable Race	AR-5381	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	694215b7-08f7-4c0d-acb1-d734ba44c0c8	2014-02-08 10:01:36.827
2	Bearing Ball	BA-8327	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	58ae3c20-4f3a-4749-a7d4-d568806cc537	2014-02-08 10:01:36.827
3	BB Ball Bearing	BE-2349	t	f	\N	800	600	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	9c21aed2-5bfa-4f18-bcb8-f11638dc2e4e	2014-02-08 10:01:36.827
4	Headset Ball Bearings	BE-2908	f	f	\N	800	600	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	ecfed6cb-51ff-49b5-b06c-7d8ac834db8b	2014-02-08 10:01:36.827
316	Blade	BL-2036	t	f	\N	800	600	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	e73e9750-603b-4131-89f5-3dd15ed5ff80	2014-02-08 10:01:36.827
317	LL Crankarm	CA-5965	f	f	Black	500	375	0	0	\N	\N	\N	\N	0	\N	L 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	3c9d10b7-a6b2-4774-9963-c19dcee72fea	2014-02-08 10:01:36.827
318	ML Crankarm	CA-6738	f	f	Black	500	375	0	0	\N	\N	\N	\N	0	\N	M 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	eabb9a92-fa07-4eab-8955-f0517b4a4ca7	2014-02-08 10:01:36.827
319	HL Crankarm	CA-7457	f	f	Black	500	375	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	7d3fd384-4f29-484b-86fa-4206e276fe58	2014-02-08 10:01:36.827
320	Chainring Bolts	CB-2903	f	f	Silver	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	7be38e48-b7d6-4486-888e-f53c26735101	2014-02-08 10:01:36.827
321	Chainring Nut	CN-6137	f	f	Silver	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	3314b1d7-ef69-4431-b6dd-dc75268bd5df	2014-02-08 10:01:36.827
322	Chainring	CR-7833	f	f	Black	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	f0ac2c4d-1a1f-4e3c-b4d9-68aea0ec1ce4	2014-02-08 10:01:36.827
323	Crown Race	CR-9981	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	51a32ca6-65a1-4c31-af2b-d9e4f5d631d4	2014-02-08 10:01:36.827
324	Chain Stays	CS-2812	t	f	\N	1000	750	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	fe0678ed-aef2-4c58-a450-8151cc24ddd8	2014-02-08 10:01:36.827
325	Decal 1	DC-8732	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	05ce123c-a402-478e-ae9b-75d7727aeaad	2014-02-08 10:01:36.827
326	Decal 2	DC-9824	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a56851f9-1cd7-4e2f-8779-2e773e1b5209	2014-02-08 10:01:36.827
327	Down Tube	DT-2377	t	f	\N	800	600	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	1dad47dd-e259-42b8-b8b4-15a0b7d21b2f	2014-02-08 10:01:36.827
328	Mountain End Caps	EC-M092	t	f	\N	1000	750	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	6070b1ea-59b7-4f8b-950f-2be07d00449d	2014-02-08 10:01:36.827
329	Road End Caps	EC-R098	t	f	\N	1000	750	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	88399d13-719e-4545-81d6-f0650f372fa2	2014-02-08 10:01:36.827
330	Touring End Caps	EC-T209	t	f	\N	1000	750	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	6903ce24-d0ce-4191-9198-4231de37a929	2014-02-08 10:01:36.827
331	Fork End	FE-3760	t	f	\N	800	600	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	c91d602e-da52-43d2-bd7e-eb110a9392b9	2014-02-08 10:01:36.827
332	Freewheel	FH-2981	f	f	Silver	500	375	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	d864879a-e8b1-4f7b-bafa-1f136089c2c8	2014-02-08 10:01:36.827
341	Flat Washer 1	FW-1000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a3f2fa3a-22e1-43d8-a131-a9b89c32d8ea	2014-02-08 10:01:36.827
342	Flat Washer 6	FW-1200	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	331addec-e9b9-4a7e-9324-42069c2dcdc4	2014-02-08 10:01:36.827
343	Flat Washer 2	FW-1400	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	84a3473e-ae26-4a21-81b9-60bb418a79b2	2014-02-08 10:01:36.827
344	Flat Washer 9	FW-3400	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	0ae4ce60-5242-48f5-ada1-3013ff45f969	2014-02-08 10:01:36.827
345	Flat Washer 4	FW-3800	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	2c1c58b4-234c-4b3a-8c8e-84524ac05eea	2014-02-08 10:01:36.827
346	Flat Washer 3	FW-5160	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	590c2c3f-a8b6-42b5-9412-d655e37f0eae	2014-02-08 10:01:36.827
347	Flat Washer 8	FW-5800	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	1b73f5fe-ab85-49fc-99ad-0500cebda91d	2014-02-08 10:01:36.827
348	Flat Washer 5	FW-7160	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	d182cf18-4ddf-429b-a0df-de1cfc92622d	2014-02-08 10:01:36.827
349	Flat Washer 7	FW-9160	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	7e55f64d-ea3c-45ff-be72-f7f7b9d61a79	2014-02-08 10:01:36.827
350	Fork Crown	FC-3654	t	f	\N	800	600	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	1cbfa85b-5c9b-4b58-9c17-95238215d926	2014-02-08 10:01:36.827
351	Front Derailleur Cage	FC-3982	f	f	Silver	800	600	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	01c901e3-4323-48ed-ab9e-9bfda28bdef6	2014-02-08 10:01:36.827
352	Front Derailleur Linkage	FL-2301	f	f	Silver	800	600	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	88ed2e08-e775-4915-b506-831600b773fd	2014-02-08 10:01:36.827
355	Guide Pulley	GP-0982	f	f	\N	800	600	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	6a89205b-90c3-4997-8c63-bc6a5ebc752d	2014-02-08 10:01:36.827
356	LL Grip Tape	GT-0820	f	f	\N	800	600	0	0	\N	\N	\N	\N	0	\N	L 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	32c82181-1969-4660-ae04-a02d51994ec1	2014-02-08 10:01:36.827
357	ML Grip Tape	GT-1209	f	f	\N	800	600	0	0	\N	\N	\N	\N	0	\N	M 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	09343e22-2494-4279-9f32-5d961a0fbfea	2014-02-08 10:01:36.827
358	HL Grip Tape	GT-2908	f	f	\N	800	600	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	8e5b2bf7-81dd-4454-b75e-d9ae2a6fbd26	2014-02-08 10:01:36.827
359	Thin-Jam Hex Nut 9	HJ-1213	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a63aff3c-4143-4016-bc99-d3f80ec1ade5	2014-02-08 10:01:36.827
360	Thin-Jam Hex Nut 10	HJ-1220	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a1ae0c6d-92a5-4fda-b33b-1301e83efe5b	2014-02-08 10:01:36.827
361	Thin-Jam Hex Nut 1	HJ-1420	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	e33e8c4c-282a-4d1f-91e7-e9969cf7134f	2014-02-08 10:01:36.827
362	Thin-Jam Hex Nut 2	HJ-1428	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a992684f-4642-4856-a817-2c0740ae8c55	2014-02-08 10:01:36.827
363	Thin-Jam Hex Nut 15	HJ-3410	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	b9d9a30d-cb07-422d-a312-f0535575337e	2014-02-08 10:01:36.827
364	Thin-Jam Hex Nut 16	HJ-3416	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	0ec8f653-24c9-41b6-86f5-39c1789db580	2014-02-08 10:01:36.827
365	Thin-Jam Hex Nut 5	HJ-3816	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	94506c9d-5991-46a7-82ea-00e05d8d9b9c	2014-02-08 10:01:36.827
366	Thin-Jam Hex Nut 6	HJ-3824	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	71e984c6-1d11-4cf2-baee-6c8df494bdad	2014-02-08 10:01:36.827
367	Thin-Jam Hex Nut 3	HJ-5161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	efc09cdb-ecd5-4db5-9e27-277dda6d7f50	2014-02-08 10:01:36.827
368	Thin-Jam Hex Nut 4	HJ-5162	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	0a0c93aa-d06c-48aa-99eb-20f2c8a6d6c4	2014-02-08 10:01:36.827
369	Thin-Jam Hex Nut 13	HJ-5811	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a2728648-9517-4dec-8606-d7d98ecd1e91	2014-02-08 10:01:36.827
370	Thin-Jam Hex Nut 14	HJ-5818	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	0a7ad37c-3696-4844-8633-9fddcd5fcefc	2014-02-08 10:01:36.827
371	Thin-Jam Hex Nut 7	HJ-7161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	acbb1de1-680c-4034-a8c5-3c6b01e57aa7	2014-02-08 10:01:36.827
372	Thin-Jam Hex Nut 8	HJ-7162	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a0da8f8f-45fb-4e62-ab14-aa229087de1e	2014-02-08 10:01:36.827
373	Thin-Jam Hex Nut 12	HJ-9080	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	db99cbcd-f18d-4979-8dcf-1012f3b1cb15	2014-02-08 10:01:36.827
374	Thin-Jam Hex Nut 11	HJ-9161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	ec2e54f5-9d07-4c26-b969-40f835395be3	2014-02-08 10:01:36.827
375	Hex Nut 5	HN-1024	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	f2f3a14c-df15-4957-966d-55e5fcad1161	2014-02-08 10:01:36.827
376	Hex Nut 6	HN-1032	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	e73e44dd-f0b7-45d4-9066-e49f1b1fe7d0	2014-02-08 10:01:36.827
377	Hex Nut 16	HN-1213	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	2b2a5641-bffe-4079-b9f0-8bf355bc3996	2014-02-08 10:01:36.827
378	Hex Nut 17	HN-1220	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	f70bbecd-5be7-4ee9-a9e7-15786e622ba9	2014-02-08 10:01:36.827
379	Hex Nut 7	HN-1224	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	ba3631d1-33d6-4a2f-8413-758bfda6f9c2	2014-02-08 10:01:36.827
380	Hex Nut 8	HN-1420	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	b478b33a-1fd5-4db6-b99a-eb3b2a7c1623	2014-02-08 10:01:36.827
381	Hex Nut 9	HN-1428	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	da46d979-59df-456d-b5ae-e7e89fc589df	2014-02-08 10:01:36.827
382	Hex Nut 22	HN-3410	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	2f457404-197d-4ddf-9868-a3aad1b32d6b	2014-02-08 10:01:36.827
383	Hex Nut 23	HN-3416	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	5f02449e-96e5-4fc8-ade0-8a9a7f533624	2014-02-08 10:01:36.827
384	Hex Nut 12	HN-3816	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	32c97696-7c3d-4793-a54b-3d73200badbc	2014-02-08 10:01:36.827
385	Hex Nut 13	HN-3824	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	8f0902d0-274d-4a4b-8fde-e37f53b2ab29	2014-02-08 10:01:36.827
386	Hex Nut 1	HN-4402	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	57456f8c-cb78-45ec-b9b8-21a9be5c12f5	2014-02-08 10:01:36.827
387	Hex Nut 10	HN-5161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	955811b4-2f17-48f0-a8b4-0c96cba4aa6d	2014-02-08 10:01:36.827
388	Hex Nut 11	HN-5162	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	7d4bad17-374f-4281-9ae5-49abc3fe585d	2014-02-08 10:01:36.827
389	Hex Nut 2	HN-5400	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	17c4b7ba-8574-4ec7-bd3b-7a51aba61f69	2014-02-08 10:01:36.827
390	Hex Nut 20	HN-5811	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	b4e990b7-b3f7-4f97-8f98-ce373833adb4	2014-02-08 10:01:36.827
391	Hex Nut 21	HN-5818	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	433ee702-e028-4630-895c-8cdbd0f1fd89	2014-02-08 10:01:36.827
392	Hex Nut 3	HN-6320	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	ee76fae0-161e-409c-a6f5-837b5b8b344d	2014-02-08 10:01:36.827
393	Hex Nut 14	HN-7161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	eb10b88c-5351-4c06-af51-116baa48a2c8	2014-02-08 10:01:36.827
394	Hex Nut 15	HN-7162	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	35e28755-e8f0-47be-a8be-a20836dbe28d	2014-02-08 10:01:36.827
395	Hex Nut 4	HN-8320	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	69ab8d5e-6101-4203-81b1-794e923782ea	2014-02-08 10:01:36.827
396	Hex Nut 18	HN-9161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	39d42384-66f6-4ccd-b471-0589fc3fc576	2014-02-08 10:01:36.827
397	Hex Nut 19	HN-9168	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	b63f827e-9055-4678-9e90-4ffd8d06d4d4	2014-02-08 10:01:36.827
398	Handlebar Tube	HT-2981	t	f	\N	800	600	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	9f88c58e-5cfa-46c9-8994-da4f3ffe92ed	2014-02-08 10:01:36.827
399	Head Tube	HT-8019	t	f	\N	800	600	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	b047c048-b4fb-4f80-94bc-c5fc00a6f77f	2014-02-08 10:01:36.827
400	LL Hub	HU-6280	t	f	\N	500	375	0	0	\N	\N	\N	\N	1	\N	L 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	ab332dda-dda5-44ad-8c50-34ffaceffa8e	2014-02-08 10:01:36.827
401	HL Hub	HU-8998	t	f	\N	500	375	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	d59403a3-d19e-4803-bda2-b436a6416fda	2014-02-08 10:01:36.827
402	Keyed Washer	KW-4091	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	43024784-2741-4cab-a6dc-8050ce507f2e	2014-02-08 10:01:36.827
403	External Lock Washer 3	LE-1000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	763412f0-6d53-43e2-b371-dcbed69f5e98	2014-02-08 10:01:36.827
404	External Lock Washer 4	LE-1200	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	89b6e84f-5c08-4cd9-b803-01f2ce24e417	2014-02-08 10:01:36.827
405	External Lock Washer 9	LE-1201	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	3330a721-e8cb-4e67-8d27-300db68c2395	2014-02-08 10:01:36.827
406	External Lock Washer 5	LE-1400	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	39314098-768b-49f9-a777-af2e3bb06b17	2014-02-08 10:01:36.827
407	External Lock Washer 7	LE-3800	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	93f7bc73-bd22-45a0-9f2e-a11932342e6b	2014-02-08 10:01:36.827
408	External Lock Washer 6	LE-5160	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	dc5f4cb0-a599-42cd-a96f-e9f01bc1dacc	2014-02-08 10:01:36.827
409	External Lock Washer 1	LE-6000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	802b7687-bc74-43f8-98ae-2112166faca7	2014-02-08 10:01:36.827
410	External Lock Washer 8	LE-7160	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	02c48826-21ad-41f3-85a6-bc9a85a4dce4	2014-02-08 10:01:36.827
411	External Lock Washer 2	LE-8000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	502a2a3d-cd72-43ad-8fb6-77505187edf4	2014-02-08 10:01:36.827
412	Internal Lock Washer 3	LI-1000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	f1168c45-e4d2-4c37-adad-b76eaf402b71	2014-02-08 10:01:36.827
413	Internal Lock Washer 4	LI-1200	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	7f7413bb-bad2-47e4-9bc4-d98b194be35d	2014-02-08 10:01:36.827
414	Internal Lock Washer 9	LI-1201	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	4f040109-8332-4fcf-8084-57e6d8c49283	2014-02-08 10:01:36.827
415	Internal Lock Washer 5	LI-1400	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	0c02f2cc-bdb4-4794-a4f9-0eb33f7545c2	2014-02-08 10:01:36.827
416	Internal Lock Washer 7	LI-3800	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	3c2ac5bc-3f49-4fa4-8340-bc4cda983f46	2014-02-08 10:01:36.827
417	Internal Lock Washer 6	LI-5160	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	7f175dfe-1669-4ee9-8eeb-7b55fce9961c	2014-02-08 10:01:36.827
418	Internal Lock Washer 10	LI-5800	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	c8323eec-bdb2-4933-b3c6-24287638ad56	2014-02-08 10:01:36.827
419	Internal Lock Washer 1	LI-6000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	71f8232d-2b59-41ac-99a1-f5ea197671b5	2014-02-08 10:01:36.827
420	Internal Lock Washer 8	LI-7160	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	e2f03586-02e8-4cd9-a342-1a8d65d393bd	2014-02-08 10:01:36.827
421	Internal Lock Washer 2	LI-8000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	97741a88-92a1-4e72-b0aa-bcb198a1c378	2014-02-08 10:01:36.827
422	Thin-Jam Lock Nut 9	LJ-1213	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	7da2613b-3347-4072-a1dc-943ada161d7f	2014-02-08 10:01:36.827
423	Thin-Jam Lock Nut 10	LJ-1220	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a88f15be-2719-4741-93a4-2d96ef3712eb	2014-02-08 10:01:36.827
424	Thin-Jam Lock Nut 1	LJ-1420	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	48461e5d-d58a-47e5-8ba3-ce4430fca611	2014-02-08 10:01:36.827
425	Thin-Jam Lock Nut 2	LJ-1428	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	36187eb6-ad84-47b7-a55e-2941d3435fe2	2014-02-08 10:01:36.827
426	Thin-Jam Lock Nut 15	LJ-3410	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	99215648-afe8-4556-bc80-b6c62ae74fc8	2014-02-08 10:01:36.827
427	Thin-Jam Lock Nut 16	LJ-3416	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	b4fc4c32-049c-417f-bbb0-f19cdfd64252	2014-02-08 10:01:36.827
428	Thin-Jam Lock Nut 5	LJ-3816	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a57b7915-2e65-49de-87ba-acd007c55adb	2014-02-08 10:01:36.827
429	Thin-Jam Lock Nut 6	LJ-3824	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	5abd940c-d61f-4108-8312-0ea97e469613	2014-02-08 10:01:36.827
430	Thin-Jam Lock Nut 3	LJ-5161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	9883496f-4785-4bfc-8af3-c357347b9f89	2014-02-08 10:01:36.827
431	Thin-Jam Lock Nut 4	LJ-5162	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	8c5ee683-d93c-4f25-9454-22faa4c31365	2014-02-08 10:01:36.827
432	Thin-Jam Lock Nut 13	LJ-5811	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	38e4a447-3d3c-4087-abad-97f006525b52	2014-02-08 10:01:36.827
433	Thin-Jam Lock Nut 14	LJ-5818	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	dce24b6c-76d8-4934-a4f6-c934364943ea	2014-02-08 10:01:36.827
434	Thin-Jam Lock Nut 7	LJ-7161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	344ad07c-cca5-4374-a3f3-8a7e0a1d9916	2014-02-08 10:01:36.827
435	Thin-Jam Lock Nut 8	LJ-7162	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	b2508cf2-c64f-493d-9db4-0d6601af1f73	2014-02-08 10:01:36.827
436	Thin-Jam Lock Nut 12	LJ-9080	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	5d3e589f-4584-406b-b9cc-3c8c060cb9a5	2014-02-08 10:01:36.827
437	Thin-Jam Lock Nut 11	LJ-9161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	64169a28-161c-4737-b724-f42ffd99de80	2014-02-08 10:01:36.827
438	Lock Nut 5	LN-1024	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	eb4c1d34-4816-4130-bb30-07b4de4072b6	2014-02-08 10:01:36.827
439	Lock Nut 6	LN-1032	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	98ccbb38-4683-486e-bbfe-cbbe4ea63c03	2014-02-08 10:01:36.827
440	Lock Nut 16	LN-1213	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	bbfd88f8-28c5-44ee-b625-52e882393dfc	2014-02-08 10:01:36.827
441	Lock Nut 17	LN-1220	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	92dc4ba8-a052-45df-83ec-226f050f876b	2014-02-08 10:01:36.827
442	Lock Nut 7	LN-1224	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	d583d825-c707-4529-b6f2-abffa21b81ec	2014-02-08 10:01:36.827
443	Lock Nut 8	LN-1420	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	e91c3dc2-c99b-4d01-8108-5dde3c87830a	2014-02-08 10:01:36.827
444	Lock Nut 9	LN-1428	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	06534a20-4c00-4824-8bba-b4e3a5724d93	2014-02-08 10:01:36.827
445	Lock Nut 22	LN-3410	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	1e4fa4ec-367e-4d8d-88b4-6cd34d1cfb89	2014-02-08 10:01:36.827
446	Lock Nut 23	LN-3416	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	afa814c8-8ec8-49db-9fee-a291197a8fe9	2014-02-08 10:01:36.827
447	Lock Nut 12	LN-3816	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	9a751f85-7130-4562-9f22-db9cab6e5bbc	2014-02-08 10:01:36.827
448	Lock Nut 13	LN-3824	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	06be8347-45c1-4c40-afcb-6ab34ad135fb	2014-02-08 10:01:36.827
449	Lock Nut 1	LN-4400	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	1dc29704-e0e0-4ef5-b581-4a524730c448	2014-02-08 10:01:36.827
450	Lock Nut 10	LN-5161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	612c26c7-6018-4050-b628-8b2d2e6841fa	2014-02-08 10:01:36.827
451	Lock Nut 11	LN-5162	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	5bcc4558-6c16-48f1-92f0-fd2eefb17306	2014-02-08 10:01:36.827
452	Lock Nut 2	LN-5400	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	53ad147d-c16d-4a8c-b086-625a31405574	2014-02-08 10:01:36.827
453	Lock Nut 20	LN-5811	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	2749030e-49b7-4b24-8d47-fbcf194aba38	2014-02-08 10:01:36.827
454	Lock Nut 21	LN-5818	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	e10a7b34-87f5-42cd-88b3-27a3d8e16b18	2014-02-08 10:01:36.827
455	Lock Nut 3	LN-6320	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	aa5071eb-2145-4d08-9d33-b9d2ba9e1493	2014-02-08 10:01:36.827
456	Lock Nut 14	LN-7161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	1e96b03d-dc07-4a98-bc24-bf5b24c393e5	2014-02-08 10:01:36.827
457	Lock Nut 15	LN-7162	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	ce04de2b-4eca-4203-a108-b7d92ff0e96e	2014-02-08 10:01:36.827
458	Lock Nut 4	LN-8320	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	41bd9389-8b22-4a35-9a2c-233d39ada7ea	2014-02-08 10:01:36.827
459	Lock Nut 19	LN-9080	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	5986504b-22a0-4e74-a137-c7cf99a8216f	2014-02-08 10:01:36.827
460	Lock Nut 18	LN-9161	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a420963f-92fd-4cd4-8531-6926e4162c41	2014-02-08 10:01:36.827
461	Lock Ring	LR-2398	f	f	Silver	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	aeca59da-b61c-4976-8316-97e14cd4eff1	2014-02-08 10:01:36.827
462	Lower Head Race	LR-8520	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	dbb962bf-0603-4095-959b-5ba9c74fbd32	2014-02-08 10:01:36.827
463	Lock Washer 4	LW-1000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a3ee3bc5-73c5-45f3-a952-9991d038dd9c	2014-02-08 10:01:36.827
464	Lock Washer 5	LW-1200	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	ecaed08d-2cf5-4d81-a4ed-8369e25af227	2014-02-08 10:01:36.827
465	Lock Washer 10	LW-1201	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a2212bab-af58-41a5-a659-a6141c8967ca	2014-02-08 10:01:36.827
466	Lock Washer 6	LW-1400	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	9092f2e1-3637-4669-8565-55404a55750e	2014-02-08 10:01:36.827
467	Lock Washer 13	LW-3400	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	3cb31f4a-c61c-408c-be1e-48bee412e511	2014-02-08 10:01:36.827
468	Lock Washer 8	LW-3800	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	900d26e6-21a0-427d-b43c-173f6dcb2045	2014-02-08 10:01:36.827
469	Lock Washer 1	LW-4000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	5402ea37-29df-47ff-9fc7-867d60594c48	2014-02-08 10:01:36.827
470	Lock Washer 7	LW-5160	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	99357255-e66b-458c-ab2e-6f68ef5452d2	2014-02-08 10:01:36.827
471	Lock Washer 12	LW-5800	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	7bc9d58e-3e62-481f-8343-beb0883b3ecf	2014-02-08 10:01:36.827
472	Lock Washer 2	LW-6000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	5f201424-9e6a-4f8d-9c2c-30777e27d64f	2014-02-08 10:01:36.827
473	Lock Washer 9	LW-7160	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	f9426fb2-1e68-464e-bf32-615026e0249e	2014-02-08 10:01:36.827
474	Lock Washer 3	LW-8000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	ac007b7f-73b7-4623-8150-02444c5ec023	2014-02-08 10:01:36.827
475	Lock Washer 11	LW-9160	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	639d8448-b427-47b1-9e5b-0e5090a27632	2014-02-08 10:01:36.827
476	Metal Angle	MA-7075	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	e876e239-7ec2-45c8-ba4b-b9ceacb379a6	2014-02-08 10:01:36.827
477	Metal Bar 1	MB-2024	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	8b5429ce-7876-44b3-9332-baf78a238b36	2014-02-08 10:01:36.827
478	Metal Bar 2	MB-6061	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	2a14f60e-3827-49ba-af13-466dbc30c5ba	2014-02-08 10:01:36.827
479	Metal Plate 2	MP-2066	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	0773a2c9-f47f-429e-814a-25b2e08c128a	2014-02-08 10:01:36.827
480	Metal Plate 1	MP-2503	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	242389be-dde0-42a1-85d9-f99fdc981336	2014-02-08 10:01:36.827
481	Metal Plate 3	MP-4960	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	8b7e90e5-7785-455e-bc7c-e962f18c6848	2014-02-08 10:01:36.827
482	Metal Sheet 2	MS-0253	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	8bb96dfb-23aa-4877-9c5e-866bb18facc7	2014-02-08 10:01:36.827
483	Metal Sheet 3	MS-1256	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	9074e00d-005b-450e-9c92-6667782e8108	2014-02-08 10:01:36.827
484	Metal Sheet 7	MS-1981	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	a9539885-0cee-4aa0-9072-8db1d34a16db	2014-02-08 10:01:36.827
485	Metal Sheet 4	MS-2259	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	3cb3cf7d-ab8e-44a3-b7e9-73149f5ec29f	2014-02-08 10:01:36.827
486	Metal Sheet 5	MS-2341	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	2a2c555d-328d-4299-bd83-591d0762df62	2014-02-08 10:01:36.827
487	Metal Sheet 6	MS-2348	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	64844011-a1c3-4f8f-9caa-9c8d214ecc12	2014-02-08 10:01:36.827
488	Metal Sheet 1	MS-6061	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	3b2febc6-c76c-4a56-9cf7-8af5b76e24ee	2014-02-08 10:01:36.827
489	Metal Tread Plate	MT-1000	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	d2177b6c-3352-43f0-9a41-719754dd280c	2014-02-08 10:01:36.827
490	LL Nipple	NI-4127	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	L 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	88310f73-ab0a-41a2-8597-936f192b7d12	2014-02-08 10:01:36.827
491	HL Nipple	NI-9522	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	88a7b897-6ff5-4ca2-b68a-6ea0e86f92b9	2014-02-08 10:01:36.827
492	Paint - Black	PA-187B	f	f	\N	60	45	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	df20e514-3d47-491b-9454-0911ec3f7d29	2014-02-08 10:01:36.827
493	Paint - Red	PA-361R	f	f	\N	60	45	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	4c568357-5d21-4ad4-bb85-bb5519b3b50c	2014-02-08 10:01:36.827
494	Paint - Silver	PA-529S	f	f	\N	60	45	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	fa81e47d-7333-49c2-809b-308171ca2fb1	2014-02-08 10:01:36.827
495	Paint - Blue	PA-632U	f	f	\N	60	45	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	25a73761-ae90-49d3-8d1d-dd7858db4704	2014-02-08 10:01:36.827
496	Paint - Yellow	PA-823Y	f	f	\N	60	45	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	1c8adb43-9fe8-44a6-b949-8af33ce9486e	2014-02-08 10:01:36.827
497	Pinch Bolt	PB-6109	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	f1694c24-dfab-4c92-bc66-6e717db24ea8	2014-02-08 10:01:36.827
504	Cup-Shaped Race	RA-2345	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	874c800e-334d-4a3c-8d3a-1e872d5b2a1b	2014-02-08 10:01:36.827
505	Cone-Shaped Race	RA-7490	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	35ce3995-9dd2-40e2-98b8-275931ac2d76	2014-02-08 10:01:36.827
506	Reflector	RF-9198	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	1c850499-38ed-4c2d-8665-7edb6a7ce93d	2014-02-08 10:01:36.827
507	LL Mountain Rim	RM-M464	f	f	\N	800	600	0	0	\N	\N	G  	435.00	0	\N	L 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	b2cc7dfb-783d-4587-88c0-2712a538a5b2	2014-02-08 10:01:36.827
508	ML Mountain Rim	RM-M692	f	f	\N	800	600	0	0	\N	\N	G  	450.00	0	\N	M 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	733fd04d-322f-44f5-beec-f326189d1ce6	2014-02-08 10:01:36.827
509	HL Mountain Rim	RM-M823	f	f	\N	800	600	0	0	\N	\N	G  	400.00	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	9fa4a3b5-d396-48d4-adfc-b573bc4a800a	2014-02-08 10:01:36.827
510	LL Road Rim	RM-R436	f	f	\N	800	600	0	0	\N	\N	G  	445.00	0	\N	L 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	c2770757-b258-4eec-a811-6856faf87437	2014-02-08 10:01:36.827
511	ML Road Rim	RM-R600	f	f	\N	800	600	0	0	\N	\N	G  	450.00	0	\N	M 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	80108059-0002-4253-a805-53a2324c33a4	2014-02-08 10:01:36.827
512	HL Road Rim	RM-R800	f	f	\N	800	600	0	0	\N	\N	G  	400.00	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	cd9b5c44-fb31-4e0f-9905-3b2086966cc5	2014-02-08 10:01:36.827
513	Touring Rim	RM-T801	f	f	\N	800	600	0	0	\N	\N	G  	460.00	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	4852db13-308a-4893-aafa-390a0dfe9f12	2014-02-08 10:01:36.827
514	LL Mountain Seat Assembly	SA-M198	t	f	\N	500	375	98.77	133.34	\N	\N	\N	\N	1	\N	L 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	fcfc0a4f-4563-4e0b-bff4-5ddcfe3a9273	2014-02-08 10:01:36.827
515	ML Mountain Seat Assembly	SA-M237	t	f	\N	500	375	108.99	147.14	\N	\N	\N	\N	1	\N	M 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	d3c8ae4c-a1be-448d-bf58-6ecbf36afa0b	2014-02-08 10:01:36.827
516	HL Mountain Seat Assembly	SA-M687	t	f	\N	500	375	145.87	196.92	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	9e18adab-b9c7-45b1-bd95-1805ec4f297d	2014-02-08 10:01:36.827
517	LL Road Seat Assembly	SA-R127	t	f	\N	500	375	98.77	133.34	\N	\N	\N	\N	1	\N	L 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	f5a30b8d-f35b-43f2-83a0-f7f6b51f6241	2014-02-08 10:01:36.827
518	ML Road Seat Assembly	SA-R430	t	f	\N	500	375	108.99	147.14	\N	\N	\N	\N	1	\N	M 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	ad109395-fda9-4c2a-96f1-515ccde3d9f4	2014-02-08 10:01:36.827
519	HL Road Seat Assembly	SA-R522	t	f	\N	500	375	145.87	196.92	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	7b52ee2a-7100-4a39-a0af-c89012da6ef8	2014-02-08 10:01:36.827
520	LL Touring Seat Assembly	SA-T467	t	f	\N	500	375	98.77	133.34	\N	\N	\N	\N	1	\N	L 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	af3d83ba-4b8e-4072-817f-e6b095a1c879	2014-02-08 10:01:36.827
521	ML Touring Seat Assembly	SA-T612	t	f	\N	500	375	108.99	147.14	\N	\N	\N	\N	1	\N	M 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	85b9a3de-000c-4351-9494-05796689c216	2014-02-08 10:01:36.827
522	HL Touring Seat Assembly	SA-T872	t	f	\N	500	375	145.87	196.92	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	8c471bca-a735-4087-ad50-90ede0ac1a1b	2014-02-08 10:01:36.827
523	LL Spindle/Axle	SD-2342	f	f	\N	500	375	0	0	\N	\N	\N	\N	0	\N	L 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	d2bd1f55-2cd4-4998-89fa-28ff2e28de2c	2014-02-08 10:01:36.827
524	HL Spindle/Axle	SD-9872	f	f	\N	500	375	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	6ce0661d-ba1f-4012-b785-55165b3b241a	2014-02-08 10:01:36.827
525	LL Shell	SH-4562	f	f	\N	800	600	0	0	\N	\N	\N	\N	0	\N	L 	\N	\N	\N	2008-04-30 00:00:00	\N	\N	ae7bcda7-e836-4f68-9e61-745f27f9aa3e	2014-02-08 10:01:36.827
526	HL Shell	SH-9312	f	f	\N	800	600	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	d215a3ae-aaf2-4cb0-9d20-3758aad078e2	2014-02-08 10:01:36.827
527	Spokes	SK-9283	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	5aabb729-343b-4084-a235-ccb3da9f29e7	2014-02-08 10:01:36.827
528	Seat Lug	SL-0931	f	f	\N	1000	750	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	4a898b1e-9a3b-4beb-9873-a7465934051a	2014-02-08 10:01:36.827
529	Stem	SM-9087	t	f	\N	500	375	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	1173306e-b616-4c4a-b715-4e0a483ba2b5	2014-02-08 10:01:36.827
530	Seat Post	SP-2981	f	f	\N	500	375	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	9b4ceb84-4e84-43f3-b326-9b7f22905363	2014-02-08 10:01:36.827
531	Steerer	SR-2098	t	f	\N	500	375	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	f3b140a1-b139-4bb5-b144-1b7cbbee6c9a	2014-02-08 10:01:36.827
532	Seat Stays	SS-2985	t	f	\N	800	600	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	20c2c611-dffc-49b5-99cf-d89bdd3a91ce	2014-02-08 10:01:36.827
533	Seat Tube	ST-9828	t	f	\N	500	375	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	41f5388b-7253-4002-bcc6-b2a50920d11f	2014-02-08 10:01:36.827
534	Top Tube	TO-2301	t	f	\N	500	375	0	0	\N	\N	\N	\N	1	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	4c0bad8e-066b-46b8-bfe9-da61539606e8	2014-02-08 10:01:36.827
535	Tension Pulley	TP-0923	f	f	\N	800	600	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	13df62b2-8a7b-47d5-9084-f1172c4779e4	2014-02-08 10:01:36.827
679	Rear Derailleur Cage	RC-0291	f	f	Silver	500	375	0	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	2008-04-30 00:00:00	\N	\N	912b03ea-4447-48c8-85da-09b80ab26340	2014-02-08 10:01:36.827
680	HL Road Frame - Black, 58	FR-R92B-58	t	t	Black	500	375	1059.31	1431.5	58	CM 	LB 	2.24	1	R 	H 	U 	14	6	2008-04-30 00:00:00	\N	\N	43dd68d6-14a4-461f-9069-55309d90ea7e	2014-02-08 10:01:36.827
706	HL Road Frame - Red, 58	FR-R92R-58	t	t	Red	500	375	1059.31	1431.5	58	CM 	LB 	2.24	1	R 	H 	U 	14	6	2008-04-30 00:00:00	\N	\N	9540ff17-2712-4c90-a3d1-8ce5568b2462	2014-02-08 10:01:36.827
707	Sport-100 Helmet, Red	HL-U509-R	f	t	Red	4	3	13.0863	34.99	\N	\N	\N	\N	0	S 	\N	\N	31	33	2011-05-31 00:00:00	\N	\N	2e1ef41a-c08a-4ff6-8ada-bde58b64a712	2014-02-08 10:01:36.827
708	Sport-100 Helmet, Black	HL-U509	f	t	Black	4	3	13.0863	34.99	\N	\N	\N	\N	0	S 	\N	\N	31	33	2011-05-31 00:00:00	\N	\N	a25a44fb-c2de-4268-958f-110b8d7621e2	2014-02-08 10:01:36.827
709	Mountain Bike Socks, M	SO-B909-M	f	t	White	4	3	3.3963	9.5	M	\N	\N	\N	0	M 	\N	U 	23	18	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	18f95f47-1540-4e02-8f1f-cc1bcb6828d0	2014-02-08 10:01:36.827
710	Mountain Bike Socks, L	SO-B909-L	f	t	White	4	3	3.3963	9.5	L	\N	\N	\N	0	M 	\N	U 	23	18	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	161c035e-21b3-4e14-8e44-af508f35d80a	2014-02-08 10:01:36.827
711	Sport-100 Helmet, Blue	HL-U509-B	f	t	Blue	4	3	13.0863	34.99	\N	\N	\N	\N	0	S 	\N	\N	31	33	2011-05-31 00:00:00	\N	\N	fd7c0858-4179-48c2-865b-abd5dfc7bc1d	2014-02-08 10:01:36.827
712	AWC Logo Cap	CA-1098	f	t	Multi	4	3	6.9223	8.99	\N	\N	\N	\N	0	S 	\N	U 	19	2	2011-05-31 00:00:00	\N	\N	b9ede243-a6f4-4629-b1d4-ffe1aedc6de7	2014-02-08 10:01:36.827
713	Long-Sleeve Logo Jersey, S	LJ-0192-S	f	t	Multi	4	3	38.4923	49.99	S	\N	\N	\N	0	S 	\N	U 	21	11	2011-05-31 00:00:00	\N	\N	fd449c82-a259-4fae-8584-6ca0255faf68	2014-02-08 10:01:36.827
714	Long-Sleeve Logo Jersey, M	LJ-0192-M	f	t	Multi	4	3	38.4923	49.99	M	\N	\N	\N	0	S 	\N	U 	21	11	2011-05-31 00:00:00	\N	\N	6a290063-a0cf-432a-8110-2ea0fda14308	2014-02-08 10:01:36.827
715	Long-Sleeve Logo Jersey, L	LJ-0192-L	f	t	Multi	4	3	38.4923	49.99	L	\N	\N	\N	0	S 	\N	U 	21	11	2011-05-31 00:00:00	\N	\N	34cf5ef5-c077-4ea0-914a-084814d5cbd5	2014-02-08 10:01:36.827
716	Long-Sleeve Logo Jersey, XL	LJ-0192-X	f	t	Multi	4	3	38.4923	49.99	XL	\N	\N	\N	0	S 	\N	U 	21	11	2011-05-31 00:00:00	\N	\N	6ec47ec9-c041-4dda-b686-2125d539ce9b	2014-02-08 10:01:36.827
717	HL Road Frame - Red, 62	FR-R92R-62	t	t	Red	500	375	868.6342	1431.5	62	CM 	LB 	2.30	1	R 	H 	U 	14	6	2011-05-31 00:00:00	\N	\N	052e4f8b-0a2a-46b2-9f42-10febcfae416	2014-02-08 10:01:36.827
718	HL Road Frame - Red, 44	FR-R92R-44	t	t	Red	500	375	868.6342	1431.5	44	CM 	LB 	2.12	1	R 	H 	U 	14	6	2011-05-31 00:00:00	\N	\N	a88d3b54-2cae-43f2-8c6e-ea1d97b46a7c	2014-02-08 10:01:36.827
719	HL Road Frame - Red, 48	FR-R92R-48	t	t	Red	500	375	868.6342	1431.5	48	CM 	LB 	2.16	1	R 	H 	U 	14	6	2011-05-31 00:00:00	\N	\N	07befc9a-7634-402b-b234-d7797733baaf	2014-02-08 10:01:36.827
720	HL Road Frame - Red, 52	FR-R92R-52	t	t	Red	500	375	868.6342	1431.5	52	CM 	LB 	2.20	1	R 	H 	U 	14	6	2011-05-31 00:00:00	\N	\N	fcfea68f-310e-4e6e-9f99-bb17d011ebae	2014-02-08 10:01:36.827
721	HL Road Frame - Red, 56	FR-R92R-56	t	t	Red	500	375	868.6342	1431.5	56	CM 	LB 	2.24	1	R 	H 	U 	14	6	2011-05-31 00:00:00	\N	\N	56c85873-4993-41b4-8096-1067cfd7e4bd	2014-02-08 10:01:36.827
722	LL Road Frame - Black, 58	FR-R38B-58	t	t	Black	500	375	204.6251	337.22	58	CM 	LB 	2.46	1	R 	L 	U 	14	9	2011-05-31 00:00:00	\N	\N	2140f256-f705-4d67-975d-32de03265838	2014-02-08 10:01:36.827
723	LL Road Frame - Black, 60	FR-R38B-60	t	t	Black	500	375	204.6251	337.22	60	CM 	LB 	2.48	1	R 	L 	U 	14	9	2011-05-31 00:00:00	\N	\N	aa95e2a5-e7c4-4b74-b1ea-b52ee3b51537	2014-02-08 10:01:36.827
724	LL Road Frame - Black, 62	FR-R38B-62	t	t	Black	500	375	204.6251	337.22	62	CM 	LB 	2.50	1	R 	L 	U 	14	9	2011-05-31 00:00:00	\N	\N	5247be33-50bf-4527-8a30-a39aae500a8e	2014-02-08 10:01:36.827
725	LL Road Frame - Red, 44	FR-R38R-44	t	t	Red	500	375	187.1571	337.22	44	CM 	LB 	2.32	1	R 	L 	U 	14	9	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	137d319d-44ad-42b2-ab61-60b9ce52b5f2	2014-02-08 10:01:36.827
726	LL Road Frame - Red, 48	FR-R38R-48	t	t	Red	500	375	187.1571	337.22	48	CM 	LB 	2.36	1	R 	L 	U 	14	9	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	35213547-275f-4767-805d-c8a4b8e13745	2014-02-08 10:01:36.827
727	LL Road Frame - Red, 52	FR-R38R-52	t	t	Red	500	375	187.1571	337.22	52	CM 	LB 	2.40	1	R 	L 	U 	14	9	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	c455e0b3-d716-419d-abf0-7e03efdd2e26	2014-02-08 10:01:36.827
728	LL Road Frame - Red, 58	FR-R38R-58	t	t	Red	500	375	187.1571	337.22	58	CM 	LB 	2.46	1	R 	L 	U 	14	9	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	799a56ff-5ad2-41b3-bfac-528b477ad129	2014-02-08 10:01:36.827
729	LL Road Frame - Red, 60	FR-R38R-60	t	t	Red	500	375	187.1571	337.22	60	CM 	LB 	2.48	1	R 	L 	U 	14	9	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	1784bb14-d1f5-4b24-92da-9127ad179302	2014-02-08 10:01:36.827
730	LL Road Frame - Red, 62	FR-R38R-62	t	t	Red	500	375	187.1571	337.22	62	CM 	LB 	2.50	1	R 	L 	U 	14	9	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	7e73aa1f-8569-4d87-9f80-ac2e513e0803	2014-02-08 10:01:36.827
731	ML Road Frame - Red, 44	FR-R72R-44	t	t	Red	500	375	352.1394	594.83	44	CM 	LB 	2.22	1	R 	M 	U 	14	16	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	459e041c-3234-409e-b4cd-81728f8a2398	2014-02-08 10:01:36.827
732	ML Road Frame - Red, 48	FR-R72R-48	t	t	Red	500	375	352.1394	594.83	48	CM 	LB 	2.26	1	R 	M 	U 	14	16	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	b673189c-c042-413b-8194-73bc44b0492c	2014-02-08 10:01:36.827
733	ML Road Frame - Red, 52	FR-R72R-52	t	t	Red	500	375	352.1394	594.83	52	CM 	LB 	2.30	1	R 	M 	U 	14	16	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	55ea276b-82d8-4ccb-9ab1-9b1b75b15a83	2014-02-08 10:01:36.827
734	ML Road Frame - Red, 58	FR-R72R-58	t	t	Red	500	375	352.1394	594.83	58	CM 	LB 	2.36	1	R 	M 	U 	14	16	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	df4ce1e2-ba9a-4657-b999-ccfa6c55d9c1	2014-02-08 10:01:36.827
735	ML Road Frame - Red, 60	FR-R72R-60	t	t	Red	500	375	352.1394	594.83	60	CM 	LB 	2.38	1	R 	M 	U 	14	16	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	b2e48e8c-63a5-469a-ba4c-4f5ebb1104a4	2014-02-08 10:01:36.827
736	LL Road Frame - Black, 44	FR-R38B-44	t	t	Black	500	375	204.6251	337.22	44	CM 	LB 	2.32	1	R 	L 	U 	14	9	2011-05-31 00:00:00	\N	\N	c9967889-f490-4a66-943a-bce432e938d8	2014-02-08 10:01:36.827
737	LL Road Frame - Black, 48	FR-R38B-48	t	t	Black	500	375	204.6251	337.22	48	CM 	LB 	2.36	1	R 	L 	U 	14	9	2011-05-31 00:00:00	\N	\N	3b5f29b6-a441-4ff7-a0fa-fad10e2ceb4c	2014-02-08 10:01:36.827
738	LL Road Frame - Black, 52	FR-R38B-52	t	t	Black	500	375	204.6251	337.22	52	CM 	LB 	2.40	1	R 	L 	U 	14	9	2011-05-31 00:00:00	\N	\N	18fc5d72-a012-4dc7-bb35-0d01a84d0219	2014-02-08 10:01:36.827
739	HL Mountain Frame - Silver, 42	FR-M94S-42	t	t	Silver	500	375	747.2002	1364.5	42	CM 	LB 	2.72	1	M 	H 	U 	12	5	2011-05-31 00:00:00	\N	\N	8ae32663-8d6f-457d-8343-5b181fec43a7	2014-02-08 10:01:36.827
740	HL Mountain Frame - Silver, 44	FR-M94S-44	t	t	Silver	500	375	706.811	1364.5	44	CM 	LB 	2.76	1	M 	H 	U 	12	5	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	1909c60c-c490-411d-b3e6-12ddd7832482	2014-02-08 10:01:36.827
741	HL Mountain Frame - Silver, 48	FR-M94S-52	t	t	Silver	500	375	706.811	1364.5	48	CM 	LB 	2.80	1	M 	H 	U 	12	5	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	b181ec1f-ca20-4724-b2eb-15f3e455142e	2014-02-08 10:01:36.827
742	HL Mountain Frame - Silver, 46	FR-M94S-46	t	t	Silver	500	375	747.2002	1364.5	46	CM 	LB 	2.84	1	M 	H 	U 	12	5	2011-05-31 00:00:00	\N	\N	a189d86e-d923-4336-b13d-a5db6f426540	2014-02-08 10:01:36.827
743	HL Mountain Frame - Black, 42	FR-M94B-42	t	t	Black	500	375	739.041	1349.6	42	CM 	LB 	2.72	1	M 	H 	U 	12	5	2011-05-31 00:00:00	\N	\N	27db28f8-5ab8-4091-b94e-6f1b2d8e7ab0	2014-02-08 10:01:36.827
744	HL Mountain Frame - Black, 44	FR-M94B-44	t	t	Black	500	375	699.0928	1349.6	44	CM 	LB 	2.76	1	M 	H 	U 	12	5	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	cb443286-6b25-409f-a10b-1ad4eeb4bd4e	2014-02-08 10:01:36.827
745	HL Mountain Frame - Black, 48	FR-M94B-48	t	t	Black	500	375	699.0928	1349.6	48	CM 	LB 	2.80	1	M 	H 	U 	12	5	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	1fee0573-6676-432d-8d6d-41ba9faa5865	2014-02-08 10:01:36.827
746	HL Mountain Frame - Black, 46	FR-M94B-46	t	t	Black	500	375	739.041	1349.6	46	CM 	LB 	2.84	1	M 	H 	U 	12	5	2011-05-31 00:00:00	\N	\N	50abebcb-451e-42b9-8dbb-e5c4a34470e9	2014-02-08 10:01:36.827
747	HL Mountain Frame - Black, 38	FR-M94B-38	t	t	Black	500	375	739.041	1349.6	38	CM 	LB 	2.68	2	M 	H 	U 	12	5	2011-05-31 00:00:00	\N	\N	0c548577-3171-4ce2-b9a0-1ed526849de8	2014-02-08 10:01:36.827
748	HL Mountain Frame - Silver, 38	FR-M94S-38	t	t	Silver	500	375	747.2002	1364.5	38	CM 	LB 	2.68	2	M 	H 	U 	12	5	2011-05-31 00:00:00	\N	\N	f246acaa-a80b-40ec-9208-02edef885129	2014-02-08 10:01:36.827
749	Road-150 Red, 62	BK-R93R-62	t	t	Red	100	75	2171.2942	3578.27	62	CM 	LB 	15.00	4	R 	H 	U 	2	25	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	bc621e1f-2553-4fdc-b22e-5e44a9003569	2014-02-08 10:01:36.827
750	Road-150 Red, 44	BK-R93R-44	t	t	Red	100	75	2171.2942	3578.27	44	CM 	LB 	13.77	4	R 	H 	U 	2	25	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	c19e1136-5da4-4b40-8758-54a85d7ea494	2014-02-08 10:01:36.827
751	Road-150 Red, 48	BK-R93R-48	t	t	Red	100	75	2171.2942	3578.27	48	CM 	LB 	14.13	4	R 	H 	U 	2	25	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	d10b7cc1-455e-435b-a08f-ec5b1c5776e9	2014-02-08 10:01:36.827
752	Road-150 Red, 52	BK-R93R-52	t	t	Red	100	75	2171.2942	3578.27	52	CM 	LB 	14.42	4	R 	H 	U 	2	25	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	5e085ba0-3cd5-487f-85bb-79ed1c701f23	2014-02-08 10:01:36.827
753	Road-150 Red, 56	BK-R93R-56	t	t	Red	100	75	2171.2942	3578.27	56	CM 	LB 	14.68	4	R 	H 	U 	2	25	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	30819b88-f0d3-4e7a-8105-19f6fac2cefb	2014-02-08 10:01:36.827
754	Road-450 Red, 58	BK-R68R-58	t	t	Red	100	75	884.7083	1457.99	58	CM 	LB 	17.79	4	R 	M 	U 	2	28	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	40d5effa-c0c4-479f-af66-5f1bf8ed3bfb	2014-02-08 10:01:36.827
755	Road-450 Red, 60	BK-R68R-60	t	t	Red	100	75	884.7083	1457.99	60	CM 	LB 	17.90	4	R 	M 	U 	2	28	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	181a90cb-3678-490e-8418-78f73fb5343d	2014-02-08 10:01:36.827
756	Road-450 Red, 44	BK-R68R-44	t	t	Red	100	75	884.7083	1457.99	44	CM 	LB 	16.77	4	R 	M 	U 	2	28	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	f8b5e26a-3d33-4e39-b500-cc21a133062e	2014-02-08 10:01:36.827
757	Road-450 Red, 48	BK-R68R-48	t	t	Red	100	75	884.7083	1457.99	48	CM 	LB 	17.13	4	R 	M 	U 	2	28	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	c72c9978-0b04-46b3-9de6-948feca1c86e	2014-02-08 10:01:36.827
758	Road-450 Red, 52	BK-R68R-52	t	t	Red	100	75	884.7083	1457.99	52	CM 	LB 	17.42	4	R 	M 	U 	2	28	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	040a4b7d-4060-4507-aa92-7508b434797e	2014-02-08 10:01:36.827
759	Road-650 Red, 58	BK-R50R-58	t	t	Red	100	75	486.7066	782.99	58	CM 	LB 	19.79	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	6711d6bc-664f-4890-9f69-af1de321d055	2014-02-08 10:01:36.827
760	Road-650 Red, 60	BK-R50R-60	t	t	Red	100	75	486.7066	782.99	60	CM 	LB 	19.90	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	664867e5-4ab3-4783-96f9-42efde92f49b	2014-02-08 10:01:36.827
761	Road-650 Red, 62	BK-R50R-62	t	t	Red	100	75	486.7066	782.99	62	CM 	LB 	20.00	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	1da14e09-6d71-4e2a-9ee9-1bdfdfd8a109	2014-02-08 10:01:36.827
762	Road-650 Red, 44	BK-R50R-44	t	t	Red	100	75	486.7066	782.99	44	CM 	LB 	18.77	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	f247aaae-12e3-4048-a37b-cce4a8999e81	2014-02-08 10:01:36.827
763	Road-650 Red, 48	BK-R50R-48	t	t	Red	100	75	486.7066	782.99	48	CM 	LB 	19.13	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	3da5fa6e-9e0f-4896-ac10-948c27f4eb79	2014-02-08 10:01:36.827
764	Road-650 Red, 52	BK-R50R-52	t	t	Red	100	75	486.7066	782.99	52	CM 	LB 	19.42	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	07cfe1ea-8a37-4d2a-835f-bc8d37e564af	2014-02-08 10:01:36.827
765	Road-650 Black, 58	BK-R50B-58	t	t	Black	100	75	486.7066	782.99	58	CM 	LB 	19.79	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	74645b12-3ce9-49a6-bd96-2cd814b37420	2014-02-08 10:01:36.827
766	Road-650 Black, 60	BK-R50B-60	t	t	Black	100	75	486.7066	782.99	60	CM 	LB 	19.90	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	a2db196d-6640-49ea-a84f-2e87ca6f50c6	2014-02-08 10:01:36.827
767	Road-650 Black, 62	BK-R50B-62	t	t	Black	100	75	486.7066	782.99	62	CM 	LB 	20.00	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	c82a8309-63d3-4c0c-ad71-e91272397095	2014-02-08 10:01:36.827
768	Road-650 Black, 44	BK-R50B-44	t	t	Black	100	75	486.7066	782.99	44	CM 	LB 	18.77	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	11d563ac-115c-4f0d-a1e5-e946eee8b38b	2014-02-08 10:01:36.827
769	Road-650 Black, 48	BK-R50B-48	t	t	Black	100	75	486.7066	782.99	48	CM 	LB 	19.13	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	a7e2179e-137c-497e-a5e6-c9ea64935fb0	2014-02-08 10:01:36.827
770	Road-650 Black, 52	BK-R50B-52	t	t	Black	100	75	486.7066	782.99	52	CM 	LB 	19.42	4	R 	L 	U 	2	30	2011-05-31 00:00:00	2013-05-29 00:00:00	\N	136e2865-e0da-4624-963a-31349279ab1a	2014-02-08 10:01:36.827
771	Mountain-100 Silver, 38	BK-M82S-38	t	t	Silver	100	75	1912.1544	3399.99	38	CM 	LB 	20.35	4	M 	H 	U 	1	19	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	ca74b54e-fc30-4464-8b83-019bfd1b2dbb	2014-02-08 10:01:36.827
772	Mountain-100 Silver, 42	BK-M82S-42	t	t	Silver	100	75	1912.1544	3399.99	42	CM 	LB 	20.77	4	M 	H 	U 	1	19	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	bbfff5a5-4bdc-49a9-a5ad-7584adffe808	2014-02-08 10:01:36.827
773	Mountain-100 Silver, 44	BK-M82S-44	t	t	Silver	100	75	1912.1544	3399.99	44	CM 	LB 	21.13	4	M 	H 	U 	1	19	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	155fd77e-d6d6-43f0-8a5b-4a8305eb45cd	2014-02-08 10:01:36.827
774	Mountain-100 Silver, 48	BK-M82S-48	t	t	Silver	100	75	1912.1544	3399.99	48	CM 	LB 	21.42	4	M 	H 	U 	1	19	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	ba5551df-c9ee-4b43-b3ca-8c19d0f9384d	2014-02-08 10:01:36.827
775	Mountain-100 Black, 38	BK-M82B-38	t	t	Black	100	75	1898.0944	3374.99	38	CM 	LB 	20.35	4	M 	H 	U 	1	19	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	dea33347-fcd3-4346-aa0f-068cd6b3ad06	2014-02-08 10:01:36.827
776	Mountain-100 Black, 42	BK-M82B-42	t	t	Black	100	75	1898.0944	3374.99	42	CM 	LB 	20.77	4	M 	H 	U 	1	19	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	02935111-a546-4c6d-941f-be12d42c158e	2014-02-08 10:01:36.827
777	Mountain-100 Black, 44	BK-M82B-44	t	t	Black	100	75	1898.0944	3374.99	44	CM 	LB 	21.13	4	M 	H 	U 	1	19	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	7920bc3b-8fd4-4610-93d2-e693a66b6474	2014-02-08 10:01:36.827
778	Mountain-100 Black, 48	BK-M82B-48	t	t	Black	100	75	1898.0944	3374.99	48	CM 	LB 	21.42	4	M 	H 	U 	1	19	2011-05-31 00:00:00	2012-05-29 00:00:00	\N	1b486300-7e64-4c5d-a9ba-a8368e20c5a0	2014-02-08 10:01:36.827
779	Mountain-200 Silver, 38	BK-M68S-38	t	t	Silver	100	75	1265.6195	2319.99	38	CM 	LB 	23.35	4	M 	H 	U 	1	20	2012-05-30 00:00:00	\N	\N	3a45d835-abae-4806-ac03-c53abcd3b974	2014-02-08 10:01:36.827
780	Mountain-200 Silver, 42	BK-M68S-42	t	t	Silver	100	75	1265.6195	2319.99	42	CM 	LB 	23.77	4	M 	H 	U 	1	20	2012-05-30 00:00:00	\N	\N	ce4849b4-56e6-4b50-808b-9bde67cc4704	2014-02-08 10:01:36.827
781	Mountain-200 Silver, 46	BK-M68S-46	t	t	Silver	100	75	1265.6195	2319.99	46	CM 	LB 	24.13	4	M 	H 	U 	1	20	2012-05-30 00:00:00	\N	\N	20799030-420c-496a-9922-09189c2b457e	2014-02-08 10:01:36.827
782	Mountain-200 Black, 38	BK-M68B-38	t	t	Black	100	75	1251.9813	2294.99	38	CM 	LB 	23.35	4	M 	H 	U 	1	20	2012-05-30 00:00:00	\N	\N	82cb8f9b-b8bb-4841-98d3-bcdb807c4dd8	2014-02-08 10:01:36.827
783	Mountain-200 Black, 42	BK-M68B-42	t	t	Black	100	75	1251.9813	2294.99	42	CM 	LB 	23.77	4	M 	H 	U 	1	20	2012-05-30 00:00:00	\N	\N	2b0af5b9-7571-4621-b760-47df599f9650	2014-02-08 10:01:36.827
784	Mountain-200 Black, 46	BK-M68B-46	t	t	Black	100	75	1251.9813	2294.99	46	CM 	LB 	24.13	4	M 	H 	U 	1	20	2012-05-30 00:00:00	\N	\N	33f42284-e216-4b98-ba48-b4ee18a01fa0	2014-02-08 10:01:36.827
785	Mountain-300 Black, 38	BK-M47B-38	t	t	Black	100	75	598.4354	1079.99	38	CM 	LB 	25.35	4	M 	M 	U 	1	21	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	f06c2cbf-0901-4c08-80ed-fb4e87171b3b	2014-02-08 10:01:36.827
786	Mountain-300 Black, 40	BK-M47B-40	t	t	Black	100	75	598.4354	1079.99	40	CM 	LB 	25.77	4	M 	M 	U 	1	21	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	580d4322-be03-4c91-83d2-ee33ec6008ab	2014-02-08 10:01:36.827
787	Mountain-300 Black, 44	BK-M47B-44	t	t	Black	100	75	598.4354	1079.99	44	CM 	LB 	26.13	4	M 	M 	U 	1	21	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	07c2a548-0452-47b4-9dce-6edb0a30c85e	2014-02-08 10:01:36.827
788	Mountain-300 Black, 48	BK-M47B-48	t	t	Black	100	75	598.4354	1079.99	48	CM 	LB 	26.42	4	M 	M 	U 	1	21	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	16078dbe-388d-4c18-aa8f-0c8f48035468	2014-02-08 10:01:36.827
789	Road-250 Red, 44	BK-R89R-44	t	t	Red	100	75	1518.7864	2443.35	44	CM 	LB 	14.77	4	R 	H 	U 	2	26	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	0aa71ad6-afaf-43c6-9745-35d815b50a5b	2014-02-08 10:01:36.827
790	Road-250 Red, 48	BK-R89R-48	t	t	Red	100	75	1518.7864	2443.35	48	CM 	LB 	15.13	4	R 	H 	U 	2	26	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	115ddade-70e3-43f9-80dc-638daea271c4	2014-02-08 10:01:36.827
791	Road-250 Red, 52	BK-R89R-52	t	t	Red	100	75	1518.7864	2443.35	52	CM 	LB 	15.42	4	R 	H 	U 	2	26	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	c9fd1df4-9512-420a-b379-067108033b75	2014-02-08 10:01:36.827
792	Road-250 Red, 58	BK-R89R-58	t	t	Red	100	75	1554.9479	2443.35	58	CM 	LB 	15.79	4	R 	H 	U 	2	26	2012-05-30 00:00:00	\N	\N	df629c11-8d8b-4774-9d52-ecb64dc95212	2014-02-08 10:01:36.827
793	Road-250 Black, 44	BK-R89B-44	t	t	Black	100	75	1554.9479	2443.35	44	CM 	LB 	14.77	4	R 	H 	U 	2	26	2012-05-30 00:00:00	\N	\N	1ff419b5-52af-4f7e-aeae-4fec5e99de35	2014-02-08 10:01:36.827
794	Road-250 Black, 48	BK-R89B-48	t	t	Black	100	75	1554.9479	2443.35	48	CM 	LB 	15.13	4	R 	H 	U 	2	26	2012-05-30 00:00:00	\N	\N	9d165ddf-8f5d-41c7-9bb8-13f41a3d1f62	2014-02-08 10:01:36.827
795	Road-250 Black, 52	BK-R89B-52	t	t	Black	100	75	1554.9479	2443.35	52	CM 	LB 	15.42	4	R 	H 	U 	2	26	2012-05-30 00:00:00	\N	\N	74fe3957-cbc3-450a-ab92-849bd13530e2	2014-02-08 10:01:36.827
796	Road-250 Black, 58	BK-R89B-58	t	t	Black	100	75	1554.9479	2443.35	58	CM 	LB 	15.68	4	R 	H 	U 	2	26	2012-05-30 00:00:00	\N	\N	1c530fe8-a169-4adc-b3dc-b11a48245e63	2014-02-08 10:01:36.827
797	Road-550-W Yellow, 38	BK-R64Y-38	t	t	Yellow	100	75	713.0798	1120.49	38	CM 	LB 	17.35	4	R 	M 	W 	2	29	2012-05-30 00:00:00	\N	\N	aad81532-a572-49a5-83c3-dfa9e3b4fea6	2014-02-08 10:01:36.827
798	Road-550-W Yellow, 40	BK-R64Y-40	t	t	Yellow	100	75	713.0798	1120.49	40	CM 	LB 	17.77	4	R 	M 	W 	2	29	2012-05-30 00:00:00	\N	\N	a35a1c35-c128-4697-951e-4199062e78f3	2014-02-08 10:01:36.827
799	Road-550-W Yellow, 42	BK-R64Y-42	t	t	Yellow	100	75	713.0798	1120.49	42	CM 	LB 	18.13	4	R 	M 	W 	2	29	2012-05-30 00:00:00	\N	\N	a359ab09-16f2-4726-a60f-0dfdb1c9527e	2014-02-08 10:01:36.827
800	Road-550-W Yellow, 44	BK-R64Y-44	t	t	Yellow	100	75	713.0798	1120.49	44	CM 	LB 	18.42	4	R 	M 	W 	2	29	2012-05-30 00:00:00	\N	\N	0a7028fb-ff06-4d38-aaa1-b64816278165	2014-02-08 10:01:36.827
801	Road-550-W Yellow, 48	BK-R64Y-48	t	t	Yellow	100	75	713.0798	1120.49	48	CM 	LB 	18.68	4	R 	M 	W 	2	29	2012-05-30 00:00:00	\N	\N	c90cc877-804c-4ce7-afc3-4c8791a13dfb	2014-02-08 10:01:36.827
802	LL Fork	FK-1639	t	t	\N	500	375	65.8097	148.22	\N	\N	\N	\N	1	\N	L 	\N	10	104	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	fb8502be-07eb-4134-ab06-c3a9959a52ae	2014-02-08 10:01:36.827
803	ML Fork	FK-5136	t	t	\N	500	375	77.9176	175.49	\N	\N	\N	\N	1	\N	M 	\N	10	105	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	f5fa4e2f-b976-48a4-bf79-85632f697d2e	2014-02-08 10:01:36.827
804	HL Fork	FK-9939	t	t	\N	500	375	101.8936	229.49	\N	\N	\N	\N	1	\N	H 	\N	10	106	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	553229b3-1ad9-4a71-a21c-2af4332cfce9	2014-02-08 10:01:36.827
805	LL Headset	HS-0296	t	t	\N	500	375	15.1848	34.2	\N	\N	\N	\N	1	\N	L 	\N	11	59	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	bb6bd7b3-a34d-4d64-822e-781fa6838e19	2014-02-08 10:01:36.827
806	ML Headset	HS-2451	t	t	\N	500	375	45.4168	102.29	\N	\N	\N	\N	1	\N	M 	\N	11	60	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	23b5d52b-8c29-4059-b899-75c53b5ee2e6	2014-02-08 10:01:36.827
807	HL Headset	HS-3479	t	t	\N	500	375	55.3801	124.73	\N	\N	\N	\N	1	\N	H 	\N	11	61	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	12e4d5e8-79ed-4bcb-a532-6275d1a93417	2014-02-08 10:01:36.827
808	LL Mountain Handlebars	HB-M243	t	t	\N	500	375	19.7758	44.54	\N	\N	\N	\N	1	M 	L 	\N	4	52	2012-05-30 00:00:00	\N	\N	b59b7bf2-7afc-4a74-b063-f942f1e0da19	2014-02-08 10:01:36.827
809	ML Mountain Handlebars	HB-M763	t	t	\N	500	375	27.4925	61.92	\N	\N	\N	\N	1	M 	M 	\N	4	54	2012-05-30 00:00:00	\N	\N	ae6020df-d9c9-4d34-9795-1f80e6bbf5a5	2014-02-08 10:01:36.827
810	HL Mountain Handlebars	HB-M918	t	t	\N	500	375	53.3999	120.27	\N	\N	\N	\N	1	M 	H 	\N	4	55	2012-05-30 00:00:00	\N	\N	6aa0f921-0f09-4f99-8d3c-335946873553	2014-02-08 10:01:36.827
811	LL Road Handlebars	HB-R504	t	t	\N	500	375	19.7758	44.54	\N	\N	\N	\N	1	R 	L 	\N	4	56	2012-05-30 00:00:00	\N	\N	acdae407-b40e-435e-8e84-1bfc33013e81	2014-02-08 10:01:36.827
812	ML Road Handlebars	HB-R720	t	t	\N	500	375	27.4925	61.92	\N	\N	\N	\N	1	R 	M 	\N	4	57	2012-05-30 00:00:00	\N	\N	33fa1a03-38d6-405e-be9b-eea92f3d204f	2014-02-08 10:01:36.827
813	HL Road Handlebars	HB-R956	t	t	\N	500	375	53.3999	120.27	\N	\N	\N	\N	1	R 	H 	\N	4	58	2012-05-30 00:00:00	\N	\N	5c5327b9-ad2e-4c33-8d74-edf49e0c2dd8	2014-02-08 10:01:36.827
814	ML Mountain Frame - Black, 38	FR-M63B-38	t	t	Black	500	375	185.8193	348.76	38	CM 	LB 	2.73	2	M 	M 	U 	12	15	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	0d879312-a7d3-441d-9d23-b6550bab3814	2014-02-08 10:01:36.827
815	LL Mountain Front Wheel	FW-M423	t	t	Black	500	375	26.9708	60.745	\N	\N	\N	\N	1	M 	L 	\N	17	42	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	d7b1d161-182e-44f6-a9ff-9c1eba76613b	2014-02-08 10:01:36.827
816	ML Mountain Front Wheel	FW-M762	t	t	Black	500	375	92.8071	209.025	\N	\N	\N	\N	1	M 	M 	\N	17	45	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	5e3e5033-9a77-4dca-8b7f-dfed78efa08a	2014-02-08 10:01:36.827
817	HL Mountain Front Wheel	FW-M928	t	t	Black	500	375	133.2955	300.215	\N	\N	\N	\N	1	M 	H 	\N	17	46	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	3c8ffff6-a8dc-45a3-963b-a6284ced7596	2014-02-08 10:01:36.827
818	LL Road Front Wheel	FW-R623	t	t	Black	500	375	37.9909	85.565	\N	\N	G  	900.00	1	R 	L 	\N	17	49	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	9e66de78-decb-438a-b9a9-023c773c60a2	2014-02-08 10:01:36.827
819	ML Road Front Wheel	FW-R762	t	t	Black	500	375	110.2829	248.385	\N	\N	G  	850.00	1	R 	M 	\N	17	50	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	6ea94fbf-b9aa-43fc-84e8-91d508dde751	2014-02-08 10:01:36.827
820	HL Road Front Wheel	FW-R820	t	t	Black	500	375	146.5466	330.06	\N	\N	G  	650.00	1	R 	H 	\N	17	51	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	727a3cd5-8d40-4884-a7e4-dfd3ffdeb164	2014-02-08 10:01:36.827
821	Touring Front Wheel	FW-T905	t	t	Black	500	375	96.7964	218.01	\N	\N	\N	\N	1	T 	\N	\N	17	44	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	8d1cdb07-4fa1-4ac1-840f-a16c3dca5009	2014-02-08 10:01:36.827
822	ML Road Frame-W - Yellow, 38	FR-R72Y-38	t	t	Yellow	500	375	360.9428	594.83	38	CM 	LB 	2.18	2	R 	M 	W 	14	17	2012-05-30 00:00:00	\N	\N	22976fa7-0ad0-40f9-b4f9-ba10279ea1a3	2014-02-08 10:01:36.827
823	LL Mountain Rear Wheel	RW-M423	t	t	Black	500	375	38.9588	87.745	\N	\N	\N	\N	1	M 	L 	\N	17	123	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	e6c39f58-995f-4786-a309-df3812d8b30f	2014-02-08 10:01:36.827
824	ML Mountain Rear Wheel	RW-M762	t	t	Black	500	375	104.7951	236.025	\N	\N	\N	\N	1	M 	M 	\N	17	124	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	b2f7cf9b-a7bf-49ab-9cca-9f6e791cd693	2014-02-08 10:01:36.827
825	HL Mountain Rear Wheel	RW-M928	t	t	Black	500	375	145.2835	327.215	\N	\N	\N	\N	1	M 	H 	\N	17	125	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	35d02edc-1120-41fb-b5df-8655a93b3353	2014-02-08 10:01:36.827
826	LL Road Rear Wheel	RW-R623	t	t	Black	500	375	49.9789	112.565	\N	\N	G  	1050.00	1	R 	L 	\N	17	126	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	78d01117-8dcd-465f-9dc7-94a2cdc35582	2014-02-08 10:01:36.827
827	ML Road Rear Wheel	RW-R762	t	t	Black	500	375	122.2709	275.385	\N	\N	G  	1000.00	1	R 	M 	\N	17	77	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	cf739f9a-0af0-4810-b229-c431a31d7779	2014-02-08 10:01:36.827
828	HL Road Rear Wheel	RW-R820	t	t	Black	500	375	158.5346	357.06	\N	\N	G  	890.00	1	R 	H 	\N	17	78	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	8f262a37-43aa-4ad5-ae1f-8bd6967d8e9b	2014-02-08 10:01:36.827
829	Touring Rear Wheel	RW-T905	t	t	Black	500	375	108.7844	245.01	\N	\N	\N	\N	1	T 	\N	\N	17	43	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	30d2254d-e26d-4586-b4c5-e8ccb8a059b8	2014-02-08 10:01:36.827
830	ML Mountain Frame - Black, 40	FR-M63B-40	t	t	Black	500	375	185.8193	348.76	40	CM 	LB 	2.77	1	M 	M 	U 	12	14	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	aed1c9c4-c139-45d2-b38e-0a0a9f518665	2014-02-08 10:01:36.827
831	ML Mountain Frame - Black, 44	FR-M63B-44	t	t	Black	500	375	185.8193	348.76	44	CM 	LB 	2.81	1	M 	M 	U 	12	14	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	3f2135d4-ec5f-4e30-bde8-5444518f0637	2014-02-08 10:01:36.827
832	ML Mountain Frame - Black, 48	FR-M63B-48	t	t	Black	500	375	185.8193	348.76	48	CM 	LB 	2.85	1	M 	M 	U 	12	14	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	c2009b69-f15a-47ec-b710-1809d299318a	2014-02-08 10:01:36.827
833	ML Road Frame-W - Yellow, 40	FR-R72Y-40	t	t	Yellow	500	375	360.9428	594.83	40	CM 	LB 	2.22	1	R 	M 	W 	14	17	2012-05-30 00:00:00	\N	\N	22df26f2-60bc-493e-a14a-5500633e9f7e	2014-02-08 10:01:36.827
834	ML Road Frame-W - Yellow, 42	FR-R72Y-42	t	t	Yellow	500	375	360.9428	594.83	42	CM 	LB 	2.26	1	R 	M 	W 	14	17	2012-05-30 00:00:00	\N	\N	207b54da-5404-415d-8578-9a45082e3bf1	2014-02-08 10:01:36.827
835	ML Road Frame-W - Yellow, 44	FR-R72Y-44	t	t	Yellow	500	375	360.9428	594.83	44	CM 	LB 	2.30	1	R 	M 	W 	14	17	2012-05-30 00:00:00	\N	\N	a0fad492-ac24-4fcf-8d2a-d21d06386ae1	2014-02-08 10:01:36.827
836	ML Road Frame-W - Yellow, 48	FR-R72Y-48	t	t	Yellow	500	375	360.9428	594.83	48	CM 	LB 	2.34	1	R 	M 	W 	14	17	2012-05-30 00:00:00	\N	\N	8487bfe0-2138-471e-9c6d-fdb3a67e7d86	2014-02-08 10:01:36.827
837	HL Road Frame - Black, 62	FR-R92B-62	t	t	Black	500	375	868.6342	1431.5	62	CM 	LB 	2.30	1	R 	H 	U 	14	6	2012-05-30 00:00:00	\N	\N	5dce9c8c-fb94-46f8-b826-11658f6a3682	2014-02-08 10:01:36.827
838	HL Road Frame - Black, 44	FR-R92B-44	t	t	Black	500	375	868.6342	1431.5	44	CM 	LB 	2.12	1	R 	H 	U 	14	6	2012-05-30 00:00:00	\N	\N	e4902656-a4bc-4b08-9d47-4f3da0fd76c3	2014-02-08 10:01:36.827
839	HL Road Frame - Black, 48	FR-R92B-48	t	t	Black	500	375	868.6342	1431.5	48	CM 	LB 	2.16	1	R 	H 	U 	14	6	2012-05-30 00:00:00	\N	\N	557b603b-407b-41a4-ae34-4f7747866dba	2014-02-08 10:01:36.827
840	HL Road Frame - Black, 52	FR-R92B-52	t	t	Black	500	375	868.6342	1431.5	52	CM 	LB 	2.20	1	R 	H 	U 	14	6	2012-05-30 00:00:00	\N	\N	0ed082b3-fbba-43af-9149-8741b9fc78c8	2014-02-08 10:01:36.827
841	Men's Sports Shorts, S	SH-M897-S	f	t	Black	4	3	24.7459	59.99	S	\N	\N	\N	0	S 	\N	M 	22	13	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	34b08c1f-99d1-43c4-8ef7-2cd754b6665d	2014-02-08 10:01:36.827
842	Touring-Panniers, Large	PA-T100	f	t	Grey	4	3	51.5625	125	\N	\N	\N	\N	0	T 	\N	\N	35	120	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	56334fff-91d4-495e-bf98-933bc1010f23	2014-02-08 10:01:36.827
843	Cable Lock	LO-C100	f	t	\N	4	3	10.3125	25	\N	\N	\N	\N	0	S 	\N	\N	34	115	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	56ffd7b9-1014-4640-b1bd-b2649589b4d7	2014-02-08 10:01:36.827
844	Minipump	PU-0452	f	t	\N	4	3	8.2459	19.99	\N	\N	\N	\N	0	S 	\N	\N	36	116	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	aaf7a076-9ee3-46bf-a69f-414d847e858b	2014-02-08 10:01:36.827
845	Mountain Pump	PU-M044	f	t	\N	4	3	10.3084	24.99	\N	\N	\N	\N	0	M 	\N	\N	36	117	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	57169f80-fafb-4678-8f51-fe1f131d0c83	2014-02-08 10:01:36.827
846	Taillights - Battery-Powered	LT-T990	f	t	\N	4	3	5.7709	13.99	\N	\N	\N	\N	0	R 	\N	\N	33	108	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	3c617b87-50a5-434c-a0d3-22314b7027ee	2014-02-08 10:01:36.827
847	Headlights - Dual-Beam	LT-H902	f	t	\N	4	3	14.4334	34.99	\N	\N	\N	\N	0	R 	\N	\N	33	109	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	417db6cb-f38f-4b0d-87e7-e1ebf7456c3a	2014-02-08 10:01:36.827
848	Headlights - Weatherproof	LT-H903	f	t	\N	4	3	18.5584	44.99	\N	\N	\N	\N	0	R 	\N	\N	33	110	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	fc362c1a-4b9c-4d5f-a6d3-0775846c61f0	2014-02-08 10:01:36.827
849	Men's Sports Shorts, M	SH-M897-M	f	t	Black	4	3	24.7459	59.99	M	\N	\N	\N	0	S 	\N	M 	22	13	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	db37b435-74b9-43d3-b363-abbead107bc4	2014-02-08 10:01:36.827
850	Men's Sports Shorts, L	SH-M897-L	f	t	Black	4	3	24.7459	59.99	L	\N	\N	\N	0	S 	\N	M 	22	13	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	714184c5-669b-4cf1-a802-30e7b1ea7722	2014-02-08 10:01:36.827
851	Men's Sports Shorts, XL	SH-M897-X	f	t	Black	4	3	24.7459	59.99	XL	\N	\N	\N	0	S 	\N	M 	22	13	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	bd3ffe40-fe2e-44cb-a4e0-81786c3a751f	2014-02-08 10:01:36.827
852	Women's Tights, S	TG-W091-S	f	t	Black	4	3	30.9334	74.99	S	\N	\N	\N	0	S 	\N	W 	24	38	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	7de86c98-4f5b-4155-8572-c977f14ebaeb	2014-02-08 10:01:36.827
853	Women's Tights, M	TG-W091-M	f	t	Black	4	3	30.9334	74.99	M	\N	\N	\N	0	S 	\N	W 	24	38	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	4d8e186c-b8c9-4c64-b411-4995dd87e316	2014-02-08 10:01:36.827
854	Women's Tights, L	TG-W091-L	f	t	Black	4	3	30.9334	74.99	L	\N	\N	\N	0	S 	\N	W 	24	38	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	e378c2f3-54f6-4ea9-b049-e8bb32b5bdfd	2014-02-08 10:01:36.827
855	Men's Bib-Shorts, S	SB-M891-S	f	t	Multi	4	3	37.1209	89.99	S	\N	\N	\N	0	S 	\N	M 	18	12	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	9f60af1e-4c11-4e90-baea-48e834e8b4c2	2014-02-08 10:01:36.827
856	Men's Bib-Shorts, M	SB-M891-M	f	t	Multi	4	3	37.1209	89.99	M	\N	\N	\N	0	S 	\N	M 	18	12	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	e0cbec04-f4fc-450f-9780-f8ea7691febd	2014-02-08 10:01:36.827
857	Men's Bib-Shorts, L	SB-M891-L	f	t	Multi	4	3	37.1209	89.99	L	\N	\N	\N	0	S 	\N	M 	18	12	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	e1df75a4-9986-489e-a5de-ad3da824eb5e	2014-02-08 10:01:36.827
858	Half-Finger Gloves, S	GL-H102-S	f	t	Black	4	3	9.1593	24.49	S	\N	\N	\N	0	S 	\N	U 	20	4	2012-05-30 00:00:00	\N	\N	9e1db5c3-539d-4061-9433-d762dc195cd8	2014-02-08 10:01:36.827
859	Half-Finger Gloves, M	GL-H102-M	f	t	Black	4	3	9.1593	24.49	M	\N	\N	\N	0	S 	\N	U 	20	4	2012-05-30 00:00:00	\N	\N	9d458fd5-392d-4ab1-afef-6a5548e48858	2014-02-08 10:01:36.827
860	Half-Finger Gloves, L	GL-H102-L	f	t	Black	4	3	9.1593	24.49	L	\N	\N	\N	0	S 	\N	U 	20	4	2012-05-30 00:00:00	\N	\N	fa710215-925f-4959-81df-538e72a6a255	2014-02-08 10:01:36.827
861	Full-Finger Gloves, S	GL-F110-S	f	t	Black	4	3	15.6709	37.99	S	\N	\N	\N	0	M 	\N	U 	20	3	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	76fac097-1fb3-456b-8fb9-2c7a613771b4	2014-02-08 10:01:36.827
862	Full-Finger Gloves, M	GL-F110-M	f	t	Black	4	3	15.6709	37.99	M	\N	\N	\N	0	M 	\N	U 	20	3	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	1084221e-1890-443e-9d87-afcad6358355	2014-02-08 10:01:36.827
863	Full-Finger Gloves, L	GL-F110-L	f	t	Black	4	3	15.6709	37.99	L	\N	\N	\N	0	M 	\N	U 	20	3	2012-05-30 00:00:00	2013-05-29 00:00:00	\N	6116f9d4-8a1d-4022-a642-9c445c197203	2014-02-08 10:01:36.827
864	Classic Vest, S	VE-C304-S	f	t	Blue	4	3	23.749	63.5	S	\N	\N	\N	0	S 	\N	U 	25	1	2013-05-30 00:00:00	\N	\N	eb423ef3-409d-46fe-b35b-d69970820314	2014-02-08 10:01:36.827
865	Classic Vest, M	VE-C304-M	f	t	Blue	4	3	23.749	63.5	M	\N	\N	\N	0	S 	\N	U 	25	1	2013-05-30 00:00:00	\N	\N	2e52f96e-64a1-4069-911c-e3fd6e094a1e	2014-02-08 10:01:36.827
866	Classic Vest, L	VE-C304-L	f	t	Blue	4	3	23.749	63.5	L	\N	\N	\N	0	S 	\N	U 	25	1	2013-05-30 00:00:00	\N	\N	3211f5a8-b6c4-48bd-9aa4-d69cb40d97dd	2014-02-08 10:01:36.827
867	Women's Mountain Shorts, S	SH-W890-S	f	t	Black	4	3	26.1763	69.99	S	\N	\N	\N	0	M 	\N	W 	22	37	2013-05-30 00:00:00	\N	\N	22616fd2-b99f-4f7d-acf6-33dff66d42d2	2014-02-08 10:01:36.827
868	Women's Mountain Shorts, M	SH-W890-M	f	t	Black	4	3	26.1763	69.99	M	\N	\N	\N	0	M 	\N	W 	22	37	2013-05-30 00:00:00	\N	\N	968e3610-e583-42e8-8ab6-484a799b1774	2014-02-08 10:01:36.827
869	Women's Mountain Shorts, L	SH-W890-L	f	t	Black	4	3	26.1763	69.99	L	\N	\N	\N	0	M 	\N	W 	22	37	2013-05-30 00:00:00	\N	\N	1a66b244-5ca0-4153-b539-ae048d14faec	2014-02-08 10:01:36.827
870	Water Bottle - 30 oz.	WB-H098	f	t	\N	4	3	1.8663	4.99	\N	\N	\N	\N	0	S 	\N	\N	28	111	2013-05-30 00:00:00	\N	\N	834e8d1a-69a7-4c42-8b68-fa08d9ec9e5b	2014-02-08 10:01:36.827
871	Mountain Bottle Cage	BC-M005	f	t	\N	4	3	3.7363	9.99	\N	\N	\N	\N	0	M 	\N	\N	28	112	2013-05-30 00:00:00	\N	\N	684491de-63f8-4632-90e3-36773c4e63bd	2014-02-08 10:01:36.827
872	Road Bottle Cage	BC-R205	f	t	\N	4	3	3.3623	8.99	\N	\N	\N	\N	0	R 	\N	\N	28	113	2013-05-30 00:00:00	\N	\N	601b1fe8-d4d0-4cfb-9379-29481cc05291	2014-02-08 10:01:36.827
873	Patch Kit/8 Patches	PK-7098	f	t	\N	4	3	0.8565	2.29	\N	\N	\N	\N	0	S 	\N	\N	37	114	2013-05-30 00:00:00	\N	\N	36e638e4-68df-411b-930a-daad57221aa6	2014-02-08 10:01:36.827
874	Racing Socks, M	SO-R809-M	f	t	White	4	3	3.3623	8.99	M	\N	\N	\N	0	R 	\N	U 	23	24	2013-05-30 00:00:00	\N	\N	b9c7eb0a-1dd1-4a1d-b4c3-1dad83a8ea7e	2014-02-08 10:01:36.827
875	Racing Socks, L	SO-R809-L	f	t	White	4	3	3.3623	8.99	L	\N	\N	\N	0	R 	\N	U 	23	24	2013-05-30 00:00:00	\N	\N	c0a16305-74b7-4fae-b5c9-3e8bd0e44762	2014-02-08 10:01:36.827
876	Hitch Rack - 4-Bike	RA-H123	f	t	\N	4	3	44.88	120	\N	\N	\N	\N	0	S 	\N	\N	26	118	2013-05-30 00:00:00	\N	\N	7a0c4bbd-9679-4f59-9ebc-9daf3439a38a	2014-02-08 10:01:36.827
877	Bike Wash - Dissolver	CL-9009	f	t	\N	4	3	2.9733	7.95	\N	\N	\N	\N	0	S 	\N	\N	29	119	2013-05-30 00:00:00	\N	\N	3c40b5ad-e328-4715-88a7-ec3220f02acf	2014-02-08 10:01:36.827
878	Fender Set - Mountain	FE-6654	f	t	\N	4	3	8.2205	21.98	\N	\N	\N	\N	0	M 	\N	\N	30	121	2013-05-30 00:00:00	\N	\N	e6e76c7f-c145-4cad-a9e8-b1e4e845a2c0	2014-02-08 10:01:36.827
879	All-Purpose Bike Stand	ST-1401	f	t	\N	4	3	59.466	159	\N	\N	\N	\N	0	M 	\N	\N	27	122	2013-05-30 00:00:00	\N	\N	c7bb564b-a637-40f5-b21b-cbf7e4f713be	2014-02-08 10:01:36.827
880	Hydration Pack - 70 oz.	HY-1023-70	f	t	Silver	4	3	20.5663	54.99	70	\N	\N	\N	0	S 	\N	\N	32	107	2013-05-30 00:00:00	\N	\N	a99d90c0-05e2-4e44-ad90-c55c9f0784de	2014-02-08 10:01:36.827
881	Short-Sleeve Classic Jersey, S	SJ-0194-S	f	t	Yellow	4	3	41.5723	53.99	S	\N	\N	\N	0	S 	\N	U 	21	32	2013-05-30 00:00:00	\N	\N	05b2e20f-2399-4cb3-9b49-b28d6649c104	2014-02-08 10:01:36.827
882	Short-Sleeve Classic Jersey, M	SJ-0194-M	f	t	Yellow	4	3	41.5723	53.99	M	\N	\N	\N	0	S 	\N	U 	21	32	2013-05-30 00:00:00	\N	\N	bbbf003b-367d-4d71-af71-10f50b6234a0	2014-02-08 10:01:36.827
883	Short-Sleeve Classic Jersey, L	SJ-0194-L	f	t	Yellow	4	3	41.5723	53.99	L	\N	\N	\N	0	S 	\N	U 	21	32	2013-05-30 00:00:00	\N	\N	2d9f59b8-9f24-46eb-98ad-553e48bb9db9	2014-02-08 10:01:36.827
884	Short-Sleeve Classic Jersey, XL	SJ-0194-X	f	t	Yellow	4	3	41.5723	53.99	XL	\N	\N	\N	0	S 	\N	U 	21	32	2013-05-30 00:00:00	\N	\N	906d42f6-c21f-4d20-b528-02ffdb55fd1e	2014-02-08 10:01:36.827
885	HL Touring Frame - Yellow, 60	FR-T98Y-60	t	t	Yellow	500	375	601.7437	1003.91	60	CM 	LB 	3.08	1	T 	H 	U 	16	7	2013-05-30 00:00:00	\N	\N	c49679bd-96a9-4176-a7ed-5bc6d6444647	2014-02-08 10:01:36.827
886	LL Touring Frame - Yellow, 62	FR-T67Y-62	t	t	Yellow	500	375	199.8519	333.42	62	CM 	LB 	3.20	1	T 	L 	U 	16	10	2013-05-30 00:00:00	\N	\N	8d4d52a6-8abc-4c05-be4d-c067faf1a64e	2014-02-08 10:01:36.827
887	HL Touring Frame - Yellow, 46	FR-T98Y-46	t	t	Yellow	500	375	601.7437	1003.91	46	CM 	LB 	2.96	1	T 	H 	U 	16	7	2013-05-30 00:00:00	\N	\N	137675a7-34cd-4b7a-abe1-4e0eeb79b65d	2014-02-08 10:01:36.827
888	HL Touring Frame - Yellow, 50	FR-T98Y-50	t	t	Yellow	500	375	601.7437	1003.91	50	CM 	LB 	3.00	1	T 	H 	U 	16	7	2013-05-30 00:00:00	\N	\N	105ec6e5-30c5-4fe3-a08b-cb324c85323d	2014-02-08 10:01:36.827
889	HL Touring Frame - Yellow, 54	FR-T98Y-54	t	t	Yellow	500	375	601.7437	1003.91	54	CM 	LB 	3.04	1	T 	H 	U 	16	7	2013-05-30 00:00:00	\N	\N	12b1f317-c39b-48d0-b1a7-8018c60aea53	2014-02-08 10:01:36.827
890	HL Touring Frame - Blue, 46	FR-T98U-46	t	t	Blue	500	375	601.7437	1003.91	46	CM 	LB 	2.96	1	T 	H 	U 	16	7	2013-05-30 00:00:00	\N	\N	8bbd3437-a58b-41a0-9503-fc14b23e7678	2014-02-08 10:01:36.827
891	HL Touring Frame - Blue, 50	FR-T98U-50	t	t	Blue	500	375	601.7437	1003.91	50	CM 	LB 	3.00	1	T 	H 	U 	16	7	2013-05-30 00:00:00	\N	\N	c4244f0c-abce-451b-a895-83c0e6d1f448	2014-02-08 10:01:36.827
892	HL Touring Frame - Blue, 54	FR-T98U-54	t	t	Blue	500	375	601.7437	1003.91	54	CM 	LB 	3.04	1	T 	H 	U 	16	7	2013-05-30 00:00:00	\N	\N	e9aae947-6bc3-4909-8937-3e1cdcec8a8f	2014-02-08 10:01:36.827
893	HL Touring Frame - Blue, 60	FR-T98U-60	t	t	Blue	500	375	601.7437	1003.91	60	CM 	LB 	3.08	1	T 	H 	U 	16	7	2013-05-30 00:00:00	\N	\N	b01951a4-a581-4d10-9dc2-515da180f1b8	2014-02-08 10:01:36.827
894	Rear Derailleur	RD-2308	t	t	Silver	500	375	53.9282	121.46	\N	\N	G  	215.00	1	\N	\N	\N	9	127	2013-05-30 00:00:00	\N	\N	5ebfcf02-4e3e-443a-ad60-5aeef28dac76	2014-02-08 10:01:36.827
895	LL Touring Frame - Blue, 50	FR-T67U-50	t	t	Blue	500	375	199.8519	333.42	50	CM 	LB 	3.10	1	T 	L 	U 	16	10	2013-05-30 00:00:00	\N	\N	b78eccca-fa88-4071-9110-410585127e46	2014-02-08 10:01:36.827
896	LL Touring Frame - Blue, 54	FR-T67U-54	t	t	Blue	500	375	199.8519	333.42	54	CM 	LB 	3.14	1	T 	L 	U 	16	10	2013-05-30 00:00:00	\N	\N	0ff799c9-dd11-4b81-aaf7-65410017405b	2014-02-08 10:01:36.827
897	LL Touring Frame - Blue, 58	FR-T67U-58	t	t	Blue	500	375	199.8519	333.42	58	CM 	LB 	3.16	1	T 	L 	U 	16	10	2013-05-30 00:00:00	\N	\N	ccd4fa47-7194-4bd0-909b-1fa4bd7916a7	2014-02-08 10:01:36.827
898	LL Touring Frame - Blue, 62	FR-T67U-62	t	t	Blue	500	375	199.8519	333.42	62	CM 	LB 	3.20	1	T 	L 	U 	16	10	2013-05-30 00:00:00	\N	\N	08a211a5-dcd2-42d0-9276-64d92d4890a6	2014-02-08 10:01:36.827
899	LL Touring Frame - Yellow, 44	FR-T67Y-44	t	t	Yellow	500	375	199.8519	333.42	44	CM 	LB 	3.02	1	T 	L 	U 	16	10	2013-05-30 00:00:00	\N	\N	109cb7bc-6ec6-4a36-85c8-55b843b2ab12	2014-02-08 10:01:36.827
900	LL Touring Frame - Yellow, 50	FR-T67Y-50	t	t	Yellow	500	375	199.8519	333.42	50	CM 	LB 	3.10	1	T 	L 	U 	16	10	2013-05-30 00:00:00	\N	\N	285fd682-c647-49d1-b8f3-368a43c9cda0	2014-02-08 10:01:36.827
901	LL Touring Frame - Yellow, 54	FR-T67Y-54	t	t	Yellow	500	375	199.8519	333.42	54	CM 	LB 	3.14	1	T 	L 	U 	16	10	2013-05-30 00:00:00	\N	\N	2536e3b2-d4da-49e6-965a-f612c2c8914f	2014-02-08 10:01:36.827
902	LL Touring Frame - Yellow, 58	FR-T67Y-58	t	t	Yellow	500	375	199.8519	333.42	58	CM 	LB 	3.16	1	T 	L 	U 	16	10	2013-05-30 00:00:00	\N	\N	5d17ff1c-f50e-438f-a4e9-7c400fb762e7	2014-02-08 10:01:36.827
903	LL Touring Frame - Blue, 44	FR-T67U-44	t	t	Blue	500	375	199.8519	333.42	44	CM 	LB 	3.02	1	T 	L 	U 	16	10	2013-05-30 00:00:00	\N	\N	e9c17be7-f4dc-465e-ab73-c0198f37bfdd	2014-02-08 10:01:36.827
904	ML Mountain Frame-W - Silver, 40	FR-M63S-40	t	t	Silver	500	375	199.3757	364.09	40	CM 	LB 	2.77	1	M 	M 	W 	12	15	2013-05-30 00:00:00	\N	\N	a7dde43e-f7d5-4075-a0c1-c866ad7aa154	2014-02-08 10:01:36.827
905	ML Mountain Frame-W - Silver, 42	FR-M63S-42	t	t	Silver	500	375	199.3757	364.09	42	CM 	LB 	2.81	1	M 	M 	W 	12	15	2013-05-30 00:00:00	\N	\N	d4a2fcad-1e63-4ebd-863c-5a7c48d5b8d9	2014-02-08 10:01:36.827
906	ML Mountain Frame-W - Silver, 46	FR-M63S-46	t	t	Silver	500	375	199.3757	364.09	46	CM 	LB 	2.85	1	M 	M 	W 	12	15	2013-05-30 00:00:00	\N	\N	82025c63-7b28-412d-92c1-408e0e6ae646	2014-02-08 10:01:36.827
907	Rear Brakes	RB-9231	f	t	Silver	500	375	47.286	106.5	\N	\N	G  	317.00	1	\N	\N	\N	6	128	2013-05-30 00:00:00	\N	\N	5946f163-93f0-4141-b17e-55d9778cc274	2014-02-08 10:01:36.827
908	LL Mountain Seat/Saddle	SE-M236	f	t	\N	500	375	12.0413	27.12	\N	\N	\N	\N	1	M 	L 	\N	15	79	2013-05-30 00:00:00	\N	\N	4dab53c5-31e7-47d6-a5a0-940f8d4dad22	2014-02-08 10:01:36.827
909	ML Mountain Seat/Saddle	SE-M798	f	t	\N	500	375	17.3782	39.14	\N	\N	\N	\N	1	M 	M 	\N	15	80	2013-05-30 00:00:00	\N	\N	30222244-0fd8-4d28-8448-f2e658bf52bd	2014-02-08 10:01:36.827
910	HL Mountain Seat/Saddle	SE-M940	f	t	\N	500	375	23.3722	52.64	\N	\N	\N	\N	1	M 	H 	\N	15	81	2013-05-30 00:00:00	\N	\N	a96a5024-87de-488a-bf81-bc0c81f6cd18	2014-02-08 10:01:36.827
911	LL Road Seat/Saddle	SE-R581	f	t	\N	500	375	12.0413	27.12	\N	\N	\N	\N	1	R 	L 	\N	15	82	2013-05-30 00:00:00	\N	\N	31b9bc62-792b-4e7a-a24d-411dc76e0271	2014-02-08 10:01:36.827
912	ML Road Seat/Saddle	SE-R908	f	t	\N	500	375	17.3782	39.14	\N	\N	\N	\N	1	T 	M 	\N	15	83	2013-05-30 00:00:00	\N	\N	49845afe-a8cc-4354-a5d4-09d35bf7fb9e	2014-02-08 10:01:36.827
913	HL Road Seat/Saddle	SE-R995	f	t	\N	500	375	23.3722	52.64	\N	\N	\N	\N	1	R 	H 	\N	15	84	2013-05-30 00:00:00	\N	\N	2befe629-4b2a-41a1-a009-df13ead69105	2014-02-08 10:01:36.827
914	LL Touring Seat/Saddle	SE-T312	f	t	\N	500	375	12.0413	27.12	\N	\N	\N	\N	1	T 	L 	\N	15	66	2013-05-30 00:00:00	\N	\N	7874a1d6-7a5b-412f-a2eb-c2f457b9603d	2014-02-08 10:01:36.827
915	ML Touring Seat/Saddle	SE-T762	f	t	\N	500	375	17.3782	39.14	\N	\N	\N	\N	1	T 	M 	\N	15	65	2013-05-30 00:00:00	\N	\N	072acb72-7796-4bd0-9bbb-6efc29ac336c	2014-02-08 10:01:36.827
916	HL Touring Seat/Saddle	SE-T924	f	t	\N	500	375	23.3722	52.64	\N	\N	\N	\N	1	T 	H 	\N	15	67	2013-05-30 00:00:00	\N	\N	0e158724-934d-4a64-991f-94fec00bdea8	2014-02-08 10:01:36.827
917	LL Mountain Frame - Silver, 42	FR-M21S-42	t	t	Silver	500	375	144.5938	264.05	42	CM 	LB 	2.92	1	M 	L 	U 	12	8	2013-05-30 00:00:00	\N	\N	37bd4d2b-346b-4c6b-8f3f-85c084282529	2014-02-08 10:01:36.827
918	LL Mountain Frame - Silver, 44	FR-M21S-44	t	t	Silver	500	375	144.5938	264.05	44	CM 	LB 	2.96	1	M 	L 	U 	12	8	2013-05-30 00:00:00	\N	\N	393a4d00-7428-41f0-a48a-af26b00e9a9c	2014-02-08 10:01:36.827
919	LL Mountain Frame - Silver, 48	FR-M21S-48	t	t	Silver	500	375	144.5938	264.05	48	CM 	LB 	3.00	1	M 	L 	U 	12	8	2013-05-30 00:00:00	\N	\N	8dfef6f2-91a8-4884-8949-b2551218b37a	2014-02-08 10:01:36.827
920	LL Mountain Frame - Silver, 52	FR-M21S-52	t	t	Silver	500	375	144.5938	264.05	52	CM 	LB 	3.04	1	M 	L 	U 	12	8	2013-05-30 00:00:00	\N	\N	f230baac-5951-4eb1-b1e8-94c2ca2b37fa	2014-02-08 10:01:36.827
921	Mountain Tire Tube	TT-M928	f	t	\N	500	375	1.8663	4.99	\N	\N	\N	\N	0	M 	\N	\N	37	92	2013-05-30 00:00:00	\N	\N	01a8c3fc-ed52-458e-a634-d5b6e2accfed	2014-02-08 10:01:36.827
922	Road Tire Tube	TT-R982	f	t	\N	500	375	1.4923	3.99	\N	\N	\N	\N	0	R 	\N	\N	37	93	2013-05-30 00:00:00	\N	\N	ea442bd7-f69b-42d9-aa71-95e10b648f52	2014-02-08 10:01:36.827
923	Touring Tire Tube	TT-T092	f	t	\N	500	375	1.8663	4.99	\N	\N	\N	\N	0	T 	\N	\N	37	94	2013-05-30 00:00:00	\N	\N	179fec38-cab5-4a47-bcff-31cfc9e43a3c	2014-02-08 10:01:36.827
924	LL Mountain Frame - Black, 42	FR-M21B-42	t	t	Black	500	375	136.785	249.79	42	CM 	LB 	2.92	1	M 	L 	U 	12	8	2013-05-30 00:00:00	\N	\N	faabd7fb-cb35-4bad-8857-ec71468686ad	2014-02-08 10:01:36.827
925	LL Mountain Frame - Black, 44	FR-M21B-44	t	t	Black	500	375	136.785	249.79	44	CM 	LB 	2.96	1	M 	L 	U 	12	8	2013-05-30 00:00:00	\N	\N	47ab0300-7b55-4d35-a786-80190976b9b5	2014-02-08 10:01:36.827
926	LL Mountain Frame - Black, 48	FR-M21B-48	t	t	Black	500	375	136.785	249.79	48	CM 	LB 	3.00	1	M 	L 	U 	12	8	2013-05-30 00:00:00	\N	\N	408435aa-15c0-41e5-981f-32a8226af15f	2014-02-08 10:01:36.827
927	LL Mountain Frame - Black, 52	FR-M21B-52	t	t	Black	500	375	136.785	249.79	52	CM 	LB 	3.04	1	M 	L 	U 	12	8	2013-05-30 00:00:00	\N	\N	4800f4e6-99ea-4afd-a392-2cb05265d0d4	2014-02-08 10:01:36.827
928	LL Mountain Tire	TI-M267	f	t	\N	500	375	9.3463	24.99	\N	\N	\N	\N	0	M 	L 	\N	37	85	2013-05-30 00:00:00	\N	\N	76060a93-949c-48ea-9b31-a593d6c14983	2014-02-08 10:01:36.827
929	ML Mountain Tire	TI-M602	f	t	\N	500	375	11.2163	29.99	\N	\N	\N	\N	0	M 	M 	\N	37	86	2013-05-30 00:00:00	\N	\N	daff9e11-6254-432d-8c4f-f06e52687184	2014-02-08 10:01:36.827
930	HL Mountain Tire	TI-M823	f	t	\N	500	375	13.09	35	\N	\N	\N	\N	0	M 	H 	\N	37	87	2013-05-30 00:00:00	\N	\N	ddad25f5-0445-4b5c-8466-6446930ad8b8	2014-02-08 10:01:36.827
931	LL Road Tire	TI-R092	f	t	\N	500	375	8.0373	21.49	\N	\N	\N	\N	0	R 	L 	\N	37	88	2013-05-30 00:00:00	\N	\N	15b569a6-d172-42c2-a420-62ab5946cc80	2014-02-08 10:01:36.827
932	ML Road Tire	TI-R628	f	t	\N	500	375	9.3463	24.99	\N	\N	\N	\N	0	R 	M 	\N	37	89	2013-05-30 00:00:00	\N	\N	d1016cc5-c12b-4f05-915c-70fa062e4a64	2014-02-08 10:01:36.827
933	HL Road Tire	TI-R982	f	t	\N	500	375	12.1924	32.6	\N	\N	\N	\N	0	R 	H 	\N	37	90	2013-05-30 00:00:00	\N	\N	c86de56a-5048-4b89-b7c7-56bc75c9bcee	2014-02-08 10:01:36.827
934	Touring Tire	TI-T723	f	t	\N	500	375	10.8423	28.99	\N	\N	\N	\N	0	T 	\N	\N	37	91	2013-05-30 00:00:00	\N	\N	9d5ca300-5302-41e1-bca5-8ce5b93f26a5	2014-02-08 10:01:36.827
935	LL Mountain Pedal	PD-M282	f	t	Silver/Black	500	375	17.9776	40.49	\N	\N	G  	218.00	1	M 	L 	\N	13	62	2013-05-30 00:00:00	\N	\N	9fdd0c65-b2b0-4c6c-8704-3a9747be5174	2014-02-08 10:01:36.827
936	ML Mountain Pedal	PD-M340	f	t	Silver/Black	500	375	27.568	62.09	\N	\N	G  	215.00	1	M 	M 	\N	13	63	2013-05-30 00:00:00	\N	\N	274c86dc-439e-4469-9de8-7e9bd6455d0d	2014-02-08 10:01:36.827
937	HL Mountain Pedal	PD-M562	f	t	Silver/Black	500	375	35.9596	80.99	\N	\N	G  	185.00	1	M 	H 	\N	13	64	2013-05-30 00:00:00	\N	\N	a05464e8-6b4d-42b3-a4d6-8683136f4b66	2014-02-08 10:01:36.827
938	LL Road Pedal	PD-R347	f	t	Silver/Black	500	375	17.9776	40.49	\N	\N	G  	189.00	1	R 	L 	\N	13	68	2013-05-30 00:00:00	\N	\N	2c7dd8c3-4c55-475f-ba58-f4baca520d72	2014-02-08 10:01:36.827
939	ML Road Pedal	PD-R563	f	t	Silver/Black	500	375	27.568	62.09	\N	\N	G  	168.00	1	R 	M 	\N	13	69	2013-05-30 00:00:00	\N	\N	216ad46f-bc3f-4862-b0e9-2e261e5a6059	2014-02-08 10:01:36.827
940	HL Road Pedal	PD-R853	f	t	Silver/Black	500	375	35.9596	80.99	\N	\N	G  	149.00	1	R 	H 	\N	13	70	2013-05-30 00:00:00	\N	\N	44e96967-ab99-41ed-8b41-5bc70a5ca1a9	2014-02-08 10:03:55.51
941	Touring Pedal	PD-T852	f	t	Silver/Black	500	375	35.9596	80.99	\N	\N	\N	\N	1	T 	\N	\N	13	53	2013-05-30 00:00:00	\N	\N	6967c816-3ebb-45fa-8547-cef00e08573e	2014-02-08 10:01:36.827
942	ML Mountain Frame-W - Silver, 38	FR-M63S-38	t	t	Silver	500	375	199.3757	364.09	38	CM 	LB 	2.73	2	M 	M 	W 	12	15	2013-05-30 00:00:00	\N	\N	ba3646b0-1487-426e-ab4e-57d42e6f9233	2014-02-08 10:01:36.827
943	LL Mountain Frame - Black, 40	FR-M21B-40	t	t	Black	500	375	136.785	249.79	40	CM 	LB 	2.88	2	M 	L 	U 	12	8	2013-05-30 00:00:00	\N	\N	3050e4df-2bba-4c2b-bdcc-b4c89972db1c	2014-02-08 10:01:36.827
944	LL Mountain Frame - Silver, 40	FR-M21S-40	t	t	Silver	500	375	144.5938	264.05	40	CM 	LB 	2.88	2	M 	L 	U 	12	8	2013-05-30 00:00:00	\N	\N	756f862e-40cc-4dfc-b189-716d0dda5ff9	2014-02-08 10:01:36.827
945	Front Derailleur	FD-2342	t	t	Silver	500	375	40.6216	91.49	\N	\N	G  	88.00	1	\N	\N	\N	9	103	2013-05-30 00:00:00	\N	\N	448e9e7b-9548-4a4c-abb3-853686aa7517	2014-02-08 10:01:36.827
946	LL Touring Handlebars	HB-T721	t	t	\N	500	375	20.464	46.09	\N	\N	\N	\N	1	T 	L 	\N	4	47	2013-05-30 00:00:00	\N	\N	a2f1352e-45d0-42c4-aef3-60033073bb66	2014-02-08 10:01:36.827
947	HL Touring Handlebars	HB-T928	t	t	\N	500	375	40.6571	91.57	\N	\N	\N	\N	1	T 	H 	\N	4	48	2013-05-30 00:00:00	\N	\N	cb524e92-4fa8-4f6c-9993-60796856c654	2014-02-08 10:01:36.827
948	Front Brakes	FB-9873	f	t	Silver	500	375	47.286	106.5	\N	\N	G  	317.00	1	\N	\N	\N	6	102	2013-05-30 00:00:00	\N	\N	c1813164-1b4b-42d1-9007-4e5f9aee0e19	2014-02-08 10:01:36.827
949	LL Crankset	CS-4759	t	t	Black	500	375	77.9176	175.49	\N	\N	G  	600.00	1	\N	L 	\N	8	99	2013-05-30 00:00:00	\N	\N	41d47371-4374-46d3-8d61-b07616ec54f0	2014-02-08 10:01:36.827
950	ML Crankset	CS-6583	t	t	Black	500	375	113.8816	256.49	\N	\N	G  	635.00	1	\N	M 	\N	8	100	2013-05-30 00:00:00	\N	\N	d3a7a02c-a3d5-4a04-9454-0c4e43772b78	2014-02-08 10:01:36.827
951	HL Crankset	CS-9183	t	t	Black	500	375	179.8156	404.99	\N	\N	G  	575.00	1	\N	H 	\N	8	101	2013-05-30 00:00:00	\N	\N	2c4a8956-7b72-48fe-b028-699e117b1daa	2014-02-08 10:01:36.827
952	Chain	CH-0234	f	t	Silver	500	375	8.9866	20.24	\N	\N	\N	\N	1	\N	\N	\N	7	98	2013-05-30 00:00:00	\N	\N	5d27e2a5-27ec-4ccb-ba2c-fc980ffe6708	2014-02-08 10:01:36.827
953	Touring-2000 Blue, 60	BK-T44U-60	t	t	Blue	100	75	755.1508	1214.85	60	CM 	LB 	27.90	4	T 	M 	U 	3	35	2013-05-30 00:00:00	\N	\N	f1bb3957-8d27-47f3-91ec-c71822d11436	2014-02-08 10:01:36.827
954	Touring-1000 Yellow, 46	BK-T79Y-46	t	t	Yellow	100	75	1481.9379	2384.07	46	CM 	LB 	25.13	4	T 	H 	U 	3	34	2013-05-30 00:00:00	\N	\N	83b77413-8c8a-4af1-93e4-136edb7ff15f	2014-02-08 10:01:36.827
955	Touring-1000 Yellow, 50	BK-T79Y-50	t	t	Yellow	100	75	1481.9379	2384.07	50	CM 	LB 	25.42	4	T 	H 	U 	3	34	2013-05-30 00:00:00	\N	\N	5ec991ad-8761-4a61-a318-312df3a78604	2014-02-08 10:01:36.827
956	Touring-1000 Yellow, 54	BK-T79Y-54	t	t	Yellow	100	75	1481.9379	2384.07	54	CM 	LB 	25.68	4	T 	H 	U 	3	34	2013-05-30 00:00:00	\N	\N	1220b0f0-064d-46b7-8507-1fa758b77b9c	2014-02-08 10:01:36.827
957	Touring-1000 Yellow, 60	BK-T79Y-60	t	t	Yellow	100	75	1481.9379	2384.07	60	CM 	LB 	25.90	4	T 	H 	U 	3	34	2013-05-30 00:00:00	\N	\N	bcd1a5a9-6140-4dc9-9620-689dc7e4c155	2014-02-08 10:01:36.827
958	Touring-3000 Blue, 54	BK-T18U-54	t	t	Blue	100	75	461.4448	742.35	54	CM 	LB 	29.68	4	T 	L 	U 	3	36	2013-05-30 00:00:00	\N	\N	a3ee6897-52fe-42e4-92ec-7a91e7bb905a	2014-02-08 10:01:36.827
959	Touring-3000 Blue, 58	BK-T18U-58	t	t	Blue	100	75	461.4448	742.35	58	CM 	LB 	29.90	4	T 	L 	U 	3	36	2013-05-30 00:00:00	\N	\N	23d89cee-9f44-4f3e-b289-63de6ba2b737	2014-02-08 10:01:36.827
960	Touring-3000 Blue, 62	BK-T18U-62	t	t	Blue	100	75	461.4448	742.35	62	CM 	LB 	30.00	4	T 	L 	U 	3	36	2013-05-30 00:00:00	\N	\N	060192c9-bcd9-4260-b729-d6bcfadfb08e	2014-02-08 10:01:36.827
961	Touring-3000 Yellow, 44	BK-T18Y-44	t	t	Yellow	100	75	461.4448	742.35	44	CM 	LB 	28.77	4	T 	L 	U 	3	36	2013-05-30 00:00:00	\N	\N	5646c15a-68ad-4234-b328-254706cbccc5	2014-02-08 10:01:36.827
962	Touring-3000 Yellow, 50	BK-T18Y-50	t	t	Yellow	100	75	461.4448	742.35	50	CM 	LB 	29.13	4	T 	L 	U 	3	36	2013-05-30 00:00:00	\N	\N	df85e805-af87-4fab-a668-c80f2a5b8a69	2014-02-08 10:01:36.827
963	Touring-3000 Yellow, 54	BK-T18Y-54	t	t	Yellow	100	75	461.4448	742.35	54	CM 	LB 	29.42	4	T 	L 	U 	3	36	2013-05-30 00:00:00	\N	\N	192becd1-f465-4194-88a2-ee57fed3a3c5	2014-02-08 10:01:36.827
964	Touring-3000 Yellow, 58	BK-T18Y-58	t	t	Yellow	100	75	461.4448	742.35	58	CM 	LB 	29.79	4	T 	L 	U 	3	36	2013-05-30 00:00:00	\N	\N	bed79f64-a53d-44a3-ace8-2baa425a5a54	2014-02-08 10:01:36.827
965	Touring-3000 Yellow, 62	BK-T18Y-62	t	t	Yellow	100	75	461.4448	742.35	62	CM 	LB 	30.00	4	T 	L 	U 	3	36	2013-05-30 00:00:00	\N	\N	d28b3872-5173-40a4-b12f-655524386cc7	2014-02-08 10:01:36.827
966	Touring-1000 Blue, 46	BK-T79U-46	t	t	Blue	100	75	1481.9379	2384.07	46	CM 	LB 	25.13	4	T 	H 	U 	3	34	2013-05-30 00:00:00	\N	\N	86990d54-6efb-4c53-9974-6c3b0297e222	2014-02-08 10:01:36.827
967	Touring-1000 Blue, 50	BK-T79U-50	t	t	Blue	100	75	1481.9379	2384.07	50	CM 	LB 	25.42	4	T 	H 	U 	3	34	2013-05-30 00:00:00	\N	\N	68c0a818-2985-46eb-8255-0fb70919fa24	2014-02-08 10:01:36.827
968	Touring-1000 Blue, 54	BK-T79U-54	t	t	Blue	100	75	1481.9379	2384.07	54	CM 	LB 	25.68	4	T 	H 	U 	3	34	2013-05-30 00:00:00	\N	\N	12280a8c-7578-4367-ba71-214bcc1e4792	2014-02-08 10:01:36.827
969	Touring-1000 Blue, 60	BK-T79U-60	t	t	Blue	100	75	1481.9379	2384.07	60	CM 	LB 	25.90	4	T 	H 	U 	3	34	2013-05-30 00:00:00	\N	\N	dd70cf36-449a-43fd-839d-a84ee14c849a	2014-02-08 10:01:36.827
970	Touring-2000 Blue, 46	BK-T44U-46	t	t	Blue	100	75	755.1508	1214.85	46	CM 	LB 	27.13	4	T 	M 	U 	3	35	2013-05-30 00:00:00	\N	\N	c0009006-715f-4b76-a05a-1a0d3adfb49a	2014-02-08 10:01:36.827
971	Touring-2000 Blue, 50	BK-T44U-50	t	t	Blue	100	75	755.1508	1214.85	50	CM 	LB 	27.42	4	T 	M 	U 	3	35	2013-05-30 00:00:00	\N	\N	84abda8f-0007-4bca-9a61-b2dea58866c3	2014-02-08 10:01:36.827
972	Touring-2000 Blue, 54	BK-T44U-54	t	t	Blue	100	75	755.1508	1214.85	54	CM 	LB 	27.68	4	T 	M 	U 	3	35	2013-05-30 00:00:00	\N	\N	6dcfe2a3-3555-44e4-9116-6f6dbe448b8b	2014-02-08 10:01:36.827
973	Road-350-W Yellow, 40	BK-R79Y-40	t	t	Yellow	100	75	1082.51	1700.99	40	CM 	LB 	15.35	4	R 	M 	W 	2	27	2013-05-30 00:00:00	\N	\N	237b16d9-53f2-4fd4-befe-48209e57aec3	2014-02-08 10:01:36.827
974	Road-350-W Yellow, 42	BK-R79Y-42	t	t	Yellow	100	75	1082.51	1700.99	42	CM 	LB 	15.77	4	R 	M 	W 	2	27	2013-05-30 00:00:00	\N	\N	80bd3f8b-42c7-43d8-91f5-9fb6175287af	2014-02-08 10:01:36.827
975	Road-350-W Yellow, 44	BK-R79Y-44	t	t	Yellow	100	75	1082.51	1700.99	44	CM 	LB 	16.13	4	R 	M 	W 	2	27	2013-05-30 00:00:00	\N	\N	0c61e8af-003d-4e4b-b5b7-02f01a26be26	2014-02-08 10:01:36.827
976	Road-350-W Yellow, 48	BK-R79Y-48	t	t	Yellow	100	75	1082.51	1700.99	48	CM 	LB 	16.42	4	R 	M 	W 	2	27	2013-05-30 00:00:00	\N	\N	ec4284dc-85fa-44a8-89ec-77fc9b71720a	2014-02-08 10:01:36.827
977	Road-750 Black, 58	BK-R19B-58	t	t	Black	100	75	343.6496	539.99	58	CM 	LB 	20.79	4	R 	L 	U 	2	31	2013-05-30 00:00:00	\N	\N	87b81a1a-a5b5-43d2-a20d-0230800490b9	2014-02-08 10:01:36.827
978	Touring-3000 Blue, 44	BK-T18U-44	t	t	Blue	100	75	461.4448	742.35	44	CM 	LB 	28.77	4	T 	L 	U 	3	36	2013-05-30 00:00:00	\N	\N	4f638e15-2ed0-4193-90ce-47da580e01dd	2014-02-08 10:01:36.827
979	Touring-3000 Blue, 50	BK-T18U-50	t	t	Blue	100	75	461.4448	742.35	50	CM 	LB 	29.13	4	T 	L 	U 	3	36	2013-05-30 00:00:00	\N	\N	de305b62-88fc-465b-b23d-d8c0f7e6d361	2014-02-08 10:01:36.827
980	Mountain-400-W Silver, 38	BK-M38S-38	t	t	Silver	100	75	419.7784	769.49	38	CM 	LB 	26.35	4	M 	M 	W 	1	22	2013-05-30 00:00:00	\N	\N	7a927632-99a4-4f24-adce-0062d2d113d9	2014-02-08 10:01:36.827
981	Mountain-400-W Silver, 40	BK-M38S-40	t	t	Silver	100	75	419.7784	769.49	40	CM 	LB 	26.77	4	M 	M 	W 	1	22	2013-05-30 00:00:00	\N	\N	0a72791c-a984-4733-ae4e-2b4373cfd7cd	2014-02-08 10:01:36.827
982	Mountain-400-W Silver, 42	BK-M38S-42	t	t	Silver	100	75	419.7784	769.49	42	CM 	LB 	27.13	4	M 	M 	W 	1	22	2013-05-30 00:00:00	\N	\N	4ea4fe06-aaea-42d4-a9d9-69f6a9a4a042	2014-02-08 10:01:36.827
983	Mountain-400-W Silver, 46	BK-M38S-46	t	t	Silver	100	75	419.7784	769.49	46	CM 	LB 	27.42	4	M 	M 	W 	1	22	2013-05-30 00:00:00	\N	\N	0b0c8ee4-ff2d-438e-9cac-464783b86191	2014-02-08 10:01:36.827
984	Mountain-500 Silver, 40	BK-M18S-40	t	t	Silver	100	75	308.2179	564.99	40	CM 	LB 	27.35	4	M 	L 	U 	1	23	2013-05-30 00:00:00	\N	\N	b96c057b-6416-4851-8d59-bcb37c8e6e51	2014-02-08 10:01:36.827
985	Mountain-500 Silver, 42	BK-M18S-42	t	t	Silver	100	75	308.2179	564.99	42	CM 	LB 	27.77	4	M 	L 	U 	1	23	2013-05-30 00:00:00	\N	\N	b8d1b5d9-8a39-4097-a04a-56e95559b534	2014-02-08 10:01:36.827
986	Mountain-500 Silver, 44	BK-M18S-44	t	t	Silver	100	75	308.2179	564.99	44	CM 	LB 	28.13	4	M 	L 	U 	1	23	2013-05-30 00:00:00	\N	\N	e8cec794-e8e2-4312-96a7-4832e573d3fc	2014-02-08 10:01:36.827
987	Mountain-500 Silver, 48	BK-M18S-48	t	t	Silver	100	75	308.2179	564.99	48	CM 	LB 	28.42	4	M 	L 	U 	1	23	2013-05-30 00:00:00	\N	\N	77ef419f-481f-40b9-bdb9-7e6678e550e3	2014-02-08 10:01:36.827
988	Mountain-500 Silver, 52	BK-M18S-52	t	t	Silver	100	75	308.2179	564.99	52	CM 	LB 	28.68	4	M 	L 	U 	1	23	2013-05-30 00:00:00	\N	\N	cad60945-183e-4ab3-a70c-3f5bac6bf134	2014-02-08 10:01:36.827
989	Mountain-500 Black, 40	BK-M18B-40	t	t	Black	100	75	294.5797	539.99	40	CM 	LB 	27.35	4	M 	L 	U 	1	23	2013-05-30 00:00:00	\N	\N	28287157-3f06-487b-8531-bee8a37329e4	2014-02-08 10:01:36.827
990	Mountain-500 Black, 42	BK-M18B-42	t	t	Black	100	75	294.5797	539.99	42	CM 	LB 	27.77	4	M 	L 	U 	1	23	2013-05-30 00:00:00	\N	\N	f5752c9c-56ba-41a7-83fd-139da28c15fa	2014-02-08 10:01:36.827
991	Mountain-500 Black, 44	BK-M18B-44	t	t	Black	100	75	294.5797	539.99	44	CM 	LB 	28.13	4	M 	L 	U 	1	23	2013-05-30 00:00:00	\N	\N	c7852127-2fb8-4959-b5a3-de5a8d6445e4	2014-02-08 10:01:36.827
992	Mountain-500 Black, 48	BK-M18B-48	t	t	Black	100	75	294.5797	539.99	48	CM 	LB 	28.42	4	M 	L 	U 	1	23	2013-05-30 00:00:00	\N	\N	75752e26-a3b6-4264-9b06-f23a4fbdc5a7	2014-02-08 10:01:36.827
993	Mountain-500 Black, 52	BK-M18B-52	t	t	Black	100	75	294.5797	539.99	52	CM 	LB 	28.68	4	M 	L 	U 	1	23	2013-05-30 00:00:00	\N	\N	69ee3b55-e142-4e4f-aed8-af02978fbe87	2014-02-08 10:01:36.827
994	LL Bottom Bracket	BB-7421	t	t	\N	500	375	23.9716	53.99	\N	\N	G  	223.00	1	\N	L 	\N	5	95	2013-05-30 00:00:00	\N	\N	fa3c65cd-0a22-47e3-bdf6-53f1dc138c43	2014-02-08 10:01:36.827
995	ML Bottom Bracket	BB-8107	t	t	\N	500	375	44.9506	101.24	\N	\N	G  	168.00	1	\N	M 	\N	5	96	2013-05-30 00:00:00	\N	\N	71ab847f-d091-42d6-b735-7b0c2d82fc84	2014-02-08 10:01:36.827
996	HL Bottom Bracket	BB-9108	t	t	\N	500	375	53.9416	121.49	\N	\N	G  	170.00	1	\N	H 	\N	5	97	2013-05-30 00:00:00	\N	\N	230c47c5-08b2-4ce3-b706-69c0bdd62965	2014-02-08 10:01:36.827
997	Road-750 Black, 44	BK-R19B-44	t	t	Black	100	75	343.6496	539.99	44	CM 	LB 	19.77	4	R 	L 	U 	2	31	2013-05-30 00:00:00	\N	\N	44ce4802-409f-43ab-9b27-ca53421805be	2014-02-08 10:01:36.827
998	Road-750 Black, 48	BK-R19B-48	t	t	Black	100	75	343.6496	539.99	48	CM 	LB 	20.13	4	R 	L 	U 	2	31	2013-05-30 00:00:00	\N	\N	3de9a212-1d49-40b6-b10a-f564d981dbde	2014-02-08 10:01:36.827
999	Road-750 Black, 52	BK-R19B-52	t	t	Black	100	75	343.6496	539.99	52	CM 	LB 	20.42	4	R 	L 	U 	2	31	2013-05-30 00:00:00	\N	\N	ae638923-2b67-4679-b90e-abbab17dca31	2014-02-08 10:01:36.827
\.


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 324
-- Name: product_productid_seq; Type: SEQUENCE SET; Schema: production; Owner: sqladmin
--

SELECT pg_catalog.setval('production.product_productid_seq', 1, false);


--
-- TOC entry 4754 (class 2606 OID 18747)
-- Name: product PK_Product_ProductID; Type: CONSTRAINT; Schema: production; Owner: sqladmin
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "PK_Product_ProductID" PRIMARY KEY (productid);

ALTER TABLE production.product CLUSTER ON "PK_Product_ProductID";


--
-- TOC entry 4755 (class 2606 OID 19009)
-- Name: product FK_Product_ProductModel_ProductModelID; Type: FK CONSTRAINT; Schema: production; Owner: sqladmin
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_ProductModel_ProductModelID" FOREIGN KEY (productmodelid) REFERENCES production.productmodel(productmodelid);


--
-- TOC entry 4756 (class 2606 OID 19014)
-- Name: product FK_Product_ProductSubcategory_ProductSubcategoryID; Type: FK CONSTRAINT; Schema: production; Owner: sqladmin
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID" FOREIGN KEY (productsubcategoryid) REFERENCES production.productsubcategory(productsubcategoryid);


--
-- TOC entry 4757 (class 2606 OID 19019)
-- Name: product FK_Product_UnitMeasure_SizeUnitMeasureCode; Type: FK CONSTRAINT; Schema: production; Owner: sqladmin
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode" FOREIGN KEY (sizeunitmeasurecode) REFERENCES production.unitmeasure(unitmeasurecode);


--
-- TOC entry 4758 (class 2606 OID 19024)
-- Name: product FK_Product_UnitMeasure_WeightUnitMeasureCode; Type: FK CONSTRAINT; Schema: production; Owner: sqladmin
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode" FOREIGN KEY (weightunitmeasurecode) REFERENCES production.unitmeasure(unitmeasurecode);


-- Completed on 2021-05-30 11:04:14 UTC

--
-- PostgreSQL database dump complete
--

