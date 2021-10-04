--
-- PostgreSQL database dump
--

-- Dumped from database version 10.16
-- Dumped by pg_dump version 12.8 (Ubuntu 12.8-0ubuntu0.20.04.1)

-- Started on 2021-09-29 16:30:47 -03

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
-- TOC entry 6 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 7716 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

--
-- TOC entry 455 (class 1259 OID 302162)
-- Name: DIM_VAC_T_ESPERA_POSTGRES; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DIM_VAC_T_ESPERA_POSTGRES" (
    "FECHA" timestamp without time zone,
    "ESTRATEGIA" character varying(300),
    "TOTAL_EN_ESPERA" double precision
);


--
-- TOC entry 313 (class 1259 OID 92224)
-- Name: dataset_reporte_covid_sit_gob; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_reporte_covid_sit_gob (
    fecha date,
    tipo_reporte character varying(255),
    tipo_dato character varying(255),
    subtipo_dato character varying(255),
    valor numeric(14,6)
);


--
-- TOC entry 366 (class 1259 OID 102703)
-- Name: altas_residentes_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.altas_residentes_dia AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'altas_reportados_del_dia'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 252 (class 1259 OID 53153)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- TOC entry 251 (class 1259 OID 53151)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7717 (class 0 OID 0)
-- Dependencies: 251
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- TOC entry 254 (class 1259 OID 53165)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- TOC entry 253 (class 1259 OID 53163)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7718 (class 0 OID 0)
-- Dependencies: 253
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- TOC entry 250 (class 1259 OID 53144)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- TOC entry 249 (class 1259 OID 53142)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7719 (class 0 OID 0)
-- Dependencies: 249
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- TOC entry 256 (class 1259 OID 53173)
-- Name: auth_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


--
-- TOC entry 258 (class 1259 OID 53183)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- TOC entry 257 (class 1259 OID 53181)
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7720 (class 0 OID 0)
-- Dependencies: 257
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- TOC entry 255 (class 1259 OID 53171)
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7721 (class 0 OID 0)
-- Dependencies: 255
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- TOC entry 260 (class 1259 OID 53191)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- TOC entry 259 (class 1259 OID 53189)
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7722 (class 0 OID 0)
-- Dependencies: 259
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- TOC entry 263 (class 1259 OID 53282)
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


--
-- TOC entry 418 (class 1259 OID 296335)
-- Name: dataset_total_vacunas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_total_vacunas (
    fecha date,
    grupo_etario character varying,
    vacuna character varying,
    dosis_1 integer,
    dosis_2 integer,
    genero character varying,
    tipo_efector character varying
);


--
-- TOC entry 611 (class 1259 OID 1827947)
-- Name: barras_vacunas_aplicadas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.barras_vacunas_aplicadas AS
 WITH vacunas AS (
         SELECT 1 AS id,
            sum(dataset_total_vacunas.dosis_1) AS dosis_1,
            sum(dataset_total_vacunas.dosis_2) AS dosis_2,
                CASE
                    WHEN ((dataset_total_vacunas.vacuna)::text ~~ '%(CANSINO)%'::text) THEN 'Cansino'::character varying
                    WHEN ((dataset_total_vacunas.vacuna)::text ~~ '%(PFIZER)%'::text) THEN 'Pfizer'::character varying
                    ELSE dataset_total_vacunas.vacuna
                END AS vacuna
           FROM public.dataset_total_vacunas
          GROUP BY dataset_total_vacunas.vacuna
        )
 SELECT vacunas.id,
    vacunas.vacuna,
    (vacunas.vacuna)::text AS eje_x,
    vacunas.dosis_2 AS eje_y2,
    vacunas.dosis_1 AS eje_y
   FROM vacunas;


--
-- TOC entry 206 (class 1259 OID 34767)
-- Name: casos_covid19; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.casos_covid19 (
    numero_de_caso numeric(14,0) NOT NULL,
    fecha_apertura_snvs timestamp without time zone,
    fecha_toma_muestra timestamp without time zone,
    fecha_clasificacion timestamp without time zone,
    provincia character varying(255),
    barrio character varying(255),
    comuna character varying(255),
    genero character varying(255),
    edad numeric(5,0),
    "clasificación" character varying(255),
    fecha_fallecimiento timestamp without time zone,
    fallecido character varying(255),
    fecha_alta timestamp without time zone,
    tipo_contagio character varying(255),
    barrios_vulnerables_oficial character varying(255)
);


--
-- TOC entry 305 (class 1259 OID 87405)
-- Name: casos_covid19_test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.casos_covid19_test (
    numero_de_caso numeric(14,0),
    fecha_apertura_snvs timestamp(6) without time zone,
    fecha_toma_muestra timestamp(6) without time zone,
    fecha_clasificacion timestamp(6) without time zone,
    provincia character varying(255),
    barrio character varying(255),
    comuna character varying(255),
    genero character varying(255),
    edad numeric(5,0),
    "clasificación" character varying(255),
    fecha_fallecimiento timestamp(6) without time zone,
    fallecido character varying(255),
    fecha_alta timestamp(6) without time zone,
    tipo_contagio character varying(255),
    barrios_vulnerables_oficial character varying(255)
);


--
-- TOC entry 550 (class 1259 OID 348008)
-- Name: casos_positivos_infantil; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.casos_positivos_infantil AS
 SELECT 1 AS id,
    2 AS fecha,
    tbl.edad_2 AS eje_x,
    (tbl.eje_y)::integer AS eje_y,
    ((((tbl.eje_y2)::double precision / (tbl.eje_y)::real) * (100)::double precision))::integer AS eje_y2
   FROM ( SELECT dbplyr_064.edad_2,
            count(*) AS eje_y,
            count(
                CASE
                    WHEN ((dbplyr_064.fallecido)::text = 'si'::text) THEN dbplyr_064.fallecido
                    ELSE NULL::character varying
                END) AS eje_y2
           FROM ( SELECT casos_covid19.numero_de_caso,
                    casos_covid19.genero,
                    casos_covid19.edad,
                    casos_covid19.provincia,
                    casos_covid19.fecha_apertura_snvs,
                    casos_covid19."clasificación",
                    casos_covid19.fecha_clasificacion,
                    casos_covid19.fecha_toma_muestra,
                    casos_covid19.tipo_contagio,
                    casos_covid19.fecha_alta,
                    casos_covid19.fallecido,
                    casos_covid19.fecha_fallecimiento,
                    casos_covid19.barrio,
                    casos_covid19.comuna,
                        CASE
                            WHEN (casos_covid19.edad = (0)::numeric) THEN '0'::text
                            WHEN (casos_covid19.edad = (1)::numeric) THEN '1'::text
                            WHEN (casos_covid19.edad = (2)::numeric) THEN '2'::text
                            WHEN (casos_covid19.edad = (3)::numeric) THEN '3'::text
                            WHEN (casos_covid19.edad = (4)::numeric) THEN '4'::text
                            WHEN (casos_covid19.edad = (5)::numeric) THEN '5'::text
                            WHEN (casos_covid19.edad = (6)::numeric) THEN '6'::text
                            WHEN (casos_covid19.edad = (7)::numeric) THEN '7'::text
                            WHEN (casos_covid19.edad = (8)::numeric) THEN '8'::text
                            WHEN (casos_covid19.edad = (9)::numeric) THEN '9'::text
                            ELSE NULL::text
                        END AS edad_2
                   FROM public.casos_covid19) dbplyr_064
          WHERE ((((dbplyr_064."clasificación")::text = 'confirmado'::text) OR ((dbplyr_064."clasificación")::text = 'negativizado'::text)) AND ((dbplyr_064.provincia)::text = 'CABA'::text) AND (((dbplyr_064.edad_2)::numeric >= (0)::numeric) AND ((dbplyr_064.edad_2)::numeric <= (9)::numeric)))
          GROUP BY dbplyr_064.edad_2
          ORDER BY dbplyr_064.edad_2) tbl;


--
-- TOC entry 549 (class 1259 OID 345048)
-- Name: casos_positivos_jovenes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.casos_positivos_jovenes AS
 SELECT 1 AS id,
    2 AS fecha,
    tbl.edad_2 AS eje_x,
    (tbl.eje_y)::integer AS eje_y,
    ((((tbl.eje_y2)::double precision / (tbl.eje_y)::real) * (100)::double precision))::integer AS eje_y2
   FROM ( SELECT dbplyr_064.edad_2,
            count(*) AS eje_y,
            count(
                CASE
                    WHEN ((dbplyr_064.fallecido)::text = 'si'::text) THEN dbplyr_064.fallecido
                    ELSE NULL::character varying
                END) AS eje_y2
           FROM ( SELECT casos_covid19.numero_de_caso,
                    casos_covid19.genero,
                    casos_covid19.edad,
                    casos_covid19.provincia,
                    casos_covid19.fecha_apertura_snvs,
                    casos_covid19."clasificación",
                    casos_covid19.fecha_clasificacion,
                    casos_covid19.fecha_toma_muestra,
                    casos_covid19.tipo_contagio,
                    casos_covid19.fecha_alta,
                    casos_covid19.fallecido,
                    casos_covid19.fecha_fallecimiento,
                    casos_covid19.barrio,
                    casos_covid19.comuna,
                        CASE
                            WHEN (casos_covid19.edad = (10)::numeric) THEN '10'::text
                            WHEN (casos_covid19.edad = (11)::numeric) THEN '11'::text
                            WHEN (casos_covid19.edad = (12)::numeric) THEN '12'::text
                            WHEN (casos_covid19.edad = (13)::numeric) THEN '13'::text
                            WHEN (casos_covid19.edad = (14)::numeric) THEN '14'::text
                            WHEN (casos_covid19.edad = (15)::numeric) THEN '15'::text
                            WHEN (casos_covid19.edad = (16)::numeric) THEN '16'::text
                            WHEN (casos_covid19.edad = (17)::numeric) THEN '17'::text
                            WHEN (casos_covid19.edad = (18)::numeric) THEN '18'::text
                            WHEN (casos_covid19.edad = (19)::numeric) THEN '19'::text
                            ELSE NULL::text
                        END AS edad_2
                   FROM public.casos_covid19) dbplyr_064
          WHERE ((((dbplyr_064."clasificación")::text = 'confirmado'::text) OR ((dbplyr_064."clasificación")::text = 'negativizado'::text)) AND ((dbplyr_064.provincia)::text = 'CABA'::text) AND (((dbplyr_064.edad_2)::numeric >= (10)::numeric) AND ((dbplyr_064.edad_2)::numeric <= (19)::numeric)))
          GROUP BY dbplyr_064.edad_2
          ORDER BY dbplyr_064.edad_2) tbl;


--
-- TOC entry 521 (class 1259 OID 316424)
-- Name: componentes_colecciondeiconos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_colecciondeiconos (
    id integer NOT NULL,
    titulo character varying(255) NOT NULL
);


--
-- TOC entry 520 (class 1259 OID 316422)
-- Name: componentes_colecciondeiconos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_colecciondeiconos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7723 (class 0 OID 0)
-- Dependencies: 520
-- Name: componentes_colecciondeiconos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_colecciondeiconos_id_seq OWNED BY public.componentes_colecciondeiconos.id;


--
-- TOC entry 531 (class 1259 OID 320373)
-- Name: componentes_columnaconorden; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_columnaconorden (
    id integer NOT NULL,
    col_valor smallint NOT NULL,
    "order" smallint DEFAULT 0 NOT NULL,
    CONSTRAINT componentes_columnaconorden_col_valor_check CHECK ((col_valor >= 0)),
    CONSTRAINT componentes_columnaconorden_order_check CHECK (("order" >= 0))
);


--
-- TOC entry 530 (class 1259 OID 320371)
-- Name: componentes_columnaconorden_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_columnaconorden_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7724 (class 0 OID 0)
-- Dependencies: 530
-- Name: componentes_columnaconorden_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_columnaconorden_id_seq OWNED BY public.componentes_columnaconorden.id;


--
-- TOC entry 535 (class 1259 OID 320416)
-- Name: componentes_coordenadasparalelas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_coordenadasparalelas (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    id_indicador_bk character varying(256) NOT NULL,
    titulo character varying(255) NOT NULL,
    mostrar_titulo boolean NOT NULL,
    col_nombre smallint NOT NULL,
    view_asociada_id integer,
    paleta_color_id integer,
    CONSTRAINT componentes_coordenadasparalelas_col_nombre_check CHECK ((col_nombre >= 0))
);


--
-- TOC entry 537 (class 1259 OID 320428)
-- Name: componentes_coordenadasparalelas_ejes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_coordenadasparalelas_ejes (
    id integer NOT NULL,
    coordenadasparalelas_id integer NOT NULL,
    columnaconorden_id integer NOT NULL,
    sort_value integer NOT NULL
);


--
-- TOC entry 536 (class 1259 OID 320426)
-- Name: componentes_coordenadasparalelas_ejes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_coordenadasparalelas_ejes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7725 (class 0 OID 0)
-- Dependencies: 536
-- Name: componentes_coordenadasparalelas_ejes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_coordenadasparalelas_ejes_id_seq OWNED BY public.componentes_coordenadasparalelas_ejes.id;


--
-- TOC entry 534 (class 1259 OID 320414)
-- Name: componentes_coordenadasparalelas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_coordenadasparalelas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7726 (class 0 OID 0)
-- Dependencies: 534
-- Name: componentes_coordenadasparalelas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_coordenadasparalelas_id_seq OWNED BY public.componentes_coordenadasparalelas.id;


--
-- TOC entry 525 (class 1259 OID 316463)
-- Name: componentes_diagramadeburbujas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_diagramadeburbujas (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    id_indicador_bk character varying(256) NOT NULL,
    titulo character varying(255) NOT NULL,
    mostrar_titulo boolean NOT NULL,
    col_nombre smallint NOT NULL,
    col_x smallint NOT NULL,
    col_y smallint NOT NULL,
    paleta_color_id integer,
    view_asociada_id integer,
    col_valor smallint NOT NULL,
    CONSTRAINT componentes_diagramadeburbujas_col_nombre_check CHECK ((col_nombre >= 0)),
    CONSTRAINT componentes_diagramadeburbujas_col_valor_check CHECK ((col_valor >= 0)),
    CONSTRAINT componentes_diagramadeburbujas_col_x_check CHECK ((col_x >= 0)),
    CONSTRAINT componentes_diagramadeburbujas_col_y_check CHECK ((col_y >= 0))
);


--
-- TOC entry 524 (class 1259 OID 316461)
-- Name: componentes_diagramadeburbujas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_diagramadeburbujas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7727 (class 0 OID 0)
-- Dependencies: 524
-- Name: componentes_diagramadeburbujas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_diagramadeburbujas_id_seq OWNED BY public.componentes_diagramadeburbujas.id;


--
-- TOC entry 271 (class 1259 OID 53693)
-- Name: componentes_dona; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_dona (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    leyendas character varying(256) NOT NULL,
    id_indicador_bk character varying(256) NOT NULL,
    view_asociada_id integer
);


--
-- TOC entry 270 (class 1259 OID 53691)
-- Name: componentes_dona_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_dona_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7728 (class 0 OID 0)
-- Dependencies: 270
-- Name: componentes_dona_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_dona_id_seq OWNED BY public.componentes_dona.id;


--
-- TOC entry 267 (class 1259 OID 53631)
-- Name: componentes_grafico_cartesiano; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_grafico_cartesiano (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    label_x character varying(256) NOT NULL,
    label_y character varying(256) NOT NULL,
    tipo_grafico character varying(256) NOT NULL,
    color1 character varying(18) NOT NULL,
    color2 character varying(18) NOT NULL,
    color3 character varying(18) NOT NULL,
    leyendas character varying(256) NOT NULL,
    cant_distinto_color integer,
    color_columnas_revision character varying(18) NOT NULL,
    id_indicador_bk character varying(256) NOT NULL,
    view_asociada_id integer
);


--
-- TOC entry 266 (class 1259 OID 53629)
-- Name: componentes_grafico_cartesiano_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_grafico_cartesiano_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7729 (class 0 OID 0)
-- Dependencies: 266
-- Name: componentes_grafico_cartesiano_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_grafico_cartesiano_id_seq OWNED BY public.componentes_grafico_cartesiano.id;


--
-- TOC entry 523 (class 1259 OID 316432)
-- Name: componentes_icono; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_icono (
    id integer NOT NULL,
    titulo character varying(255) NOT NULL,
    nombre_svg character varying(255) NOT NULL,
    coleccion_id integer NOT NULL,
    archivo character varying(100)
);


--
-- TOC entry 522 (class 1259 OID 316430)
-- Name: componentes_icono_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_icono_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7730 (class 0 OID 0)
-- Dependencies: 522
-- Name: componentes_icono_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_icono_id_seq OWNED BY public.componentes_icono.id;


--
-- TOC entry 509 (class 1259 OID 311270)
-- Name: componentes_iconoconrelleno; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_iconoconrelleno (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    id_indicador_bk character varying(256) NOT NULL,
    titulo character varying(255) NOT NULL,
    mostrar_titulo boolean NOT NULL,
    icono_id integer,
    col_valor smallint NOT NULL,
    color_primario character varying(18) NOT NULL,
    color_secundario character varying(18) NOT NULL,
    view_asociada_id integer,
    col_fecha smallint,
    CONSTRAINT componentes_iconoconrelleno_col_fecha_check CHECK ((col_fecha >= 0)),
    CONSTRAINT componentes_iconoconrelleno_col_valor_check CHECK ((col_valor >= 0))
);


--
-- TOC entry 508 (class 1259 OID 311268)
-- Name: componentes_iconoconrelleno_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_iconoconrelleno_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7731 (class 0 OID 0)
-- Dependencies: 508
-- Name: componentes_iconoconrelleno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_iconoconrelleno_id_seq OWNED BY public.componentes_iconoconrelleno.id;


--
-- TOC entry 265 (class 1259 OID 53313)
-- Name: componentes_indicador; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_indicador (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    render character varying(256)
);


--
-- TOC entry 264 (class 1259 OID 53311)
-- Name: componentes_indicador_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_indicador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7732 (class 0 OID 0)
-- Dependencies: 264
-- Name: componentes_indicador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_indicador_id_seq OWNED BY public.componentes_indicador.id;


--
-- TOC entry 516 (class 1259 OID 313151)
-- Name: componentes_mapa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_mapa (
    id integer NOT NULL,
    titulo character varying(255) NOT NULL,
    geojson_data jsonb NOT NULL
);


--
-- TOC entry 515 (class 1259 OID 313149)
-- Name: componentes_mapa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_mapa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7733 (class 0 OID 0)
-- Dependencies: 515
-- Name: componentes_mapa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_mapa_id_seq OWNED BY public.componentes_mapa.id;


--
-- TOC entry 503 (class 1259 OID 311112)
-- Name: componentes_mapaconburbujas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_mapaconburbujas (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    id_indicador_bk character varying(256) NOT NULL,
    titulo character varying(255) NOT NULL,
    view_asociada_id integer,
    col_latitud smallint NOT NULL,
    col_longitud smallint NOT NULL,
    col_nombre smallint NOT NULL,
    col_valor smallint NOT NULL,
    color_burbuja character varying(18) NOT NULL,
    color_delimitacion character varying(18) NOT NULL,
    color_mapa character varying(18) NOT NULL,
    mostrar_titulo boolean NOT NULL,
    mapa_id integer,
    CONSTRAINT componentes_mapaconburbujas_col_latitud_check CHECK ((col_latitud >= 0)),
    CONSTRAINT componentes_mapaconburbujas_col_longitud_check CHECK ((col_longitud >= 0)),
    CONSTRAINT componentes_mapaconburbujas_col_nombre_check CHECK ((col_nombre >= 0)),
    CONSTRAINT componentes_mapaconburbujas_col_valor_check CHECK ((col_valor >= 0))
);


--
-- TOC entry 502 (class 1259 OID 311110)
-- Name: componentes_mapaconburbujas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_mapaconburbujas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7734 (class 0 OID 0)
-- Dependencies: 502
-- Name: componentes_mapaconburbujas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_mapaconburbujas_id_seq OWNED BY public.componentes_mapaconburbujas.id;


--
-- TOC entry 505 (class 1259 OID 311129)
-- Name: componentes_paletacolor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_paletacolor (
    id integer NOT NULL,
    color1 character varying(18) NOT NULL,
    color2 character varying(18) NOT NULL,
    color3 character varying(18) NOT NULL,
    color4 character varying(18) NOT NULL,
    color5 character varying(18) NOT NULL,
    color6 character varying(18) NOT NULL,
    color7 character varying(18) NOT NULL,
    color8 character varying(18) NOT NULL,
    color9 character varying(18) NOT NULL,
    color10 character varying(18) NOT NULL,
    titulo character varying(255) NOT NULL
);


--
-- TOC entry 504 (class 1259 OID 311127)
-- Name: componentes_paletacolor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_paletacolor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7735 (class 0 OID 0)
-- Dependencies: 504
-- Name: componentes_paletacolor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_paletacolor_id_seq OWNED BY public.componentes_paletacolor.id;


--
-- TOC entry 507 (class 1259 OID 311234)
-- Name: componentes_radar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_radar (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    id_indicador_bk character varying(256) NOT NULL,
    titulo character varying(255) NOT NULL,
    mostrar_titulo boolean NOT NULL,
    col_circunferencia smallint NOT NULL,
    col_valor smallint NOT NULL,
    paleta_color_id integer,
    view_asociada_id integer,
    col_nombre smallint NOT NULL,
    CONSTRAINT componentes_radar_col_circunferencia_check CHECK ((col_circunferencia >= 0)),
    CONSTRAINT componentes_radar_col_nombre_1c47fc0f_check CHECK ((col_nombre >= 0)),
    CONSTRAINT componentes_radar_col_valor_check CHECK ((col_valor >= 0))
);


--
-- TOC entry 506 (class 1259 OID 311232)
-- Name: componentes_radar_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_radar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7736 (class 0 OID 0)
-- Dependencies: 506
-- Name: componentes_radar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_radar_id_seq OWNED BY public.componentes_radar.id;


--
-- TOC entry 529 (class 1259 OID 320336)
-- Name: componentes_sunburst; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_sunburst (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    id_indicador_bk character varying(256) NOT NULL,
    titulo character varying(255) NOT NULL,
    mostrar_titulo boolean NOT NULL,
    col_nombre smallint NOT NULL,
    paleta_color_id integer,
    view_asociada_id integer,
    col_valor smallint NOT NULL,
    CONSTRAINT componentes_sunburst_col_nombre_check CHECK ((col_nombre >= 0)),
    CONSTRAINT componentes_sunburst_col_valor_check CHECK ((col_valor >= 0))
);


--
-- TOC entry 533 (class 1259 OID 320383)
-- Name: componentes_sunburst_anillos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_sunburst_anillos (
    id integer NOT NULL,
    sunburst_id integer NOT NULL,
    columnaconorden_id integer NOT NULL,
    sort_value integer NOT NULL
);


--
-- TOC entry 532 (class 1259 OID 320381)
-- Name: componentes_sunburst_anillos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_sunburst_anillos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7737 (class 0 OID 0)
-- Dependencies: 532
-- Name: componentes_sunburst_anillos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_sunburst_anillos_id_seq OWNED BY public.componentes_sunburst_anillos.id;


--
-- TOC entry 528 (class 1259 OID 320334)
-- Name: componentes_sunburst_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_sunburst_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7738 (class 0 OID 0)
-- Dependencies: 528
-- Name: componentes_sunburst_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_sunburst_id_seq OWNED BY public.componentes_sunburst.id;


--
-- TOC entry 269 (class 1259 OID 53642)
-- Name: componentes_tarjeta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_tarjeta (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    titulo character varying(256) NOT NULL,
    subtitulo character varying(256),
    muestra integer,
    link_datos character varying(200),
    grafico boolean NOT NULL,
    acumular boolean NOT NULL,
    color character varying(18) NOT NULL,
    comentarios text,
    id_indicador_bk character varying(256) NOT NULL,
    view_asociada_id integer
);


--
-- TOC entry 315 (class 1259 OID 93022)
-- Name: componentes_tarjeta_doble; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_tarjeta_doble (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    id_indicador_bk character varying(256) NOT NULL,
    titulo character varying(256) NOT NULL,
    subtitulo1 character varying(256) NOT NULL,
    subtitulo2 character varying(256) NOT NULL,
    color character varying(18) NOT NULL,
    link_datos character varying(200),
    view_asociada_id integer
);


--
-- TOC entry 314 (class 1259 OID 93020)
-- Name: componentes_tarjeta_doble_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_tarjeta_doble_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7739 (class 0 OID 0)
-- Dependencies: 314
-- Name: componentes_tarjeta_doble_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_tarjeta_doble_id_seq OWNED BY public.componentes_tarjeta_doble.id;


--
-- TOC entry 268 (class 1259 OID 53640)
-- Name: componentes_tarjeta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_tarjeta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7740 (class 0 OID 0)
-- Dependencies: 268
-- Name: componentes_tarjeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_tarjeta_id_seq OWNED BY public.componentes_tarjeta.id;


--
-- TOC entry 501 (class 1259 OID 311095)
-- Name: componentes_treemap; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_treemap (
    id integer NOT NULL,
    id_indicador character varying(256) NOT NULL,
    id_indicador_bk character varying(256) NOT NULL,
    titulo character varying(255) NOT NULL,
    view_asociada_id integer,
    paleta_color_id integer,
    mostrar_titulo boolean NOT NULL,
    col_nombre smallint NOT NULL,
    col_valor smallint NOT NULL,
    CONSTRAINT componentes_treemap_col_nombre_check CHECK ((col_nombre >= 0)),
    CONSTRAINT componentes_treemap_col_valor_check CHECK ((col_valor >= 0))
);


--
-- TOC entry 500 (class 1259 OID 311093)
-- Name: componentes_treemap_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_treemap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7741 (class 0 OID 0)
-- Dependencies: 500
-- Name: componentes_treemap_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_treemap_id_seq OWNED BY public.componentes_treemap.id;


--
-- TOC entry 540 (class 1259 OID 327021)
-- Name: componentes_treemap_jerarquias; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.componentes_treemap_jerarquias (
    id integer NOT NULL,
    treemap_id integer NOT NULL,
    columnaconorden_id integer NOT NULL,
    sort_value integer NOT NULL
);


--
-- TOC entry 539 (class 1259 OID 327019)
-- Name: componentes_treemap_jerarquias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.componentes_treemap_jerarquias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7742 (class 0 OID 0)
-- Dependencies: 539
-- Name: componentes_treemap_jerarquias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.componentes_treemap_jerarquias_id_seq OWNED BY public.componentes_treemap_jerarquias.id;


--
-- TOC entry 304 (class 1259 OID 87363)
-- Name: contactos_boti_tri_cov_19_test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contactos_boti_tri_cov_19_test (
    fecha date,
    hora integer,
    triage_cantidad integer
);


--
-- TOC entry 202 (class 1259 OID 32535)
-- Name: contactos_boti_triage_covid_19; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contactos_boti_triage_covid_19 (
    fecha date,
    hora integer,
    triage_cantidad integer
);


--
-- TOC entry 210 (class 1259 OID 50439)
-- Name: cov_log_trabajos_1_reg_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cov_log_trabajos_1_reg_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 201 (class 1259 OID 32523)
-- Name: llamados_107_covid; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.llamados_107_covid (
    fecha timestamp without time zone NOT NULL,
    covid_llamados numeric(12,0),
    casos_sospechosos numeric(12,0),
    casos_descartados_covid numeric(12,0),
    casos_trasladados numeric(12,0),
    casos_derivados numeric(12,0)
);


--
-- TOC entry 280 (class 1259 OID 58018)
-- Name: dataset_107_llamados_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_107_llamados_dia AS
 SELECT 1 AS id,
    (llamados_107_covid.fecha)::date AS fecha,
    to_char(((llamados_107_covid.fecha)::date)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (llamados_107_covid.covid_llamados)::integer AS eje_y
   FROM public.llamados_107_covid
  ORDER BY ((llamados_107_covid.fecha)::date);


--
-- TOC entry 281 (class 1259 OID 66818)
-- Name: dataset_107_llamados_dia_tarjeta; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_107_llamados_dia_tarjeta AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            (llamados_107_covid.fecha)::date AS fecha,
            to_char(((llamados_107_covid.fecha)::date)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (llamados_107_covid.covid_llamados)::integer AS eje_y
           FROM public.llamados_107_covid
          ORDER BY ((llamados_107_covid.fecha)::date) DESC
         LIMIT 15) t
  ORDER BY t.fecha;


--
-- TOC entry 208 (class 1259 OID 48460)
-- Name: dataset_covid_147; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_covid_147 (
    fecha timestamp without time zone,
    cantidad_voluntarios numeric(12,0),
    cantidad_adultos_mayores numeric(12,0),
    cantidad_contactos_147 numeric(12,0)
);


--
-- TOC entry 287 (class 1259 OID 83299)
-- Name: dataset_147_llamados_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_147_llamados_dia AS
 SELECT 1 AS id,
    (dataset_covid_147.fecha)::date AS fecha,
    to_char(dataset_covid_147.fecha, 'DD-MM'::text) AS eje_x,
    (dataset_covid_147.cantidad_contactos_147)::integer AS eje_y
   FROM public.dataset_covid_147
  ORDER BY ((dataset_covid_147.fecha)::date);


--
-- TOC entry 398 (class 1259 OID 270710)
-- Name: dataset_147_llamados_dia_tarjeta; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_147_llamados_dia_tarjeta AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            (dataset_covid_147.fecha)::date AS fecha,
            to_char(dataset_covid_147.fecha, 'DD-MM'::text) AS eje_x,
            (dataset_covid_147.cantidad_contactos_147)::integer AS eje_y
           FROM public.dataset_covid_147
          ORDER BY ((dataset_covid_147.fecha)::date) DESC
         LIMIT 15) t
  ORDER BY t.fecha;


--
-- TOC entry 401 (class 1259 OID 291337)
-- Name: dataset_testeo_turismo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_testeo_turismo (
    fecha_muestra date,
    tipo character varying(255),
    dispositivo character varying(255),
    genero character varying(50),
    grupo_etario character varying(300),
    n numeric(12,0)
);


--
-- TOC entry 413 (class 1259 OID 296066)
-- Name: dataset_acumulado_etareo_turista; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_acumulado_etareo_turista AS
 SELECT 1 AS id,
    2 AS fecha,
    tt.grupo_etario AS eje_x,
    (sum(tt.n))::integer AS eje_y,
    (round(((tabla2.cantidad_de_testeos * (100)::numeric) / sum(tt.n))))::integer AS eje_y2
   FROM (public.dataset_testeo_turismo tt
     JOIN ( SELECT dataset_testeo_turismo.grupo_etario,
            sum(dataset_testeo_turismo.n) AS cantidad_de_testeos
           FROM public.dataset_testeo_turismo
          GROUP BY dataset_testeo_turismo.grupo_etario, dataset_testeo_turismo.tipo
         HAVING ((dataset_testeo_turismo.tipo)::text = 'positivos'::text)) tabla2 ON (((tabla2.grupo_etario)::text = (tt.grupo_etario)::text)))
  GROUP BY tt.grupo_etario, tt.tipo, tabla2.cantidad_de_testeos
 HAVING ((tt.tipo)::text <> 'positivos'::text)
  ORDER BY tt.grupo_etario;


--
-- TOC entry 357 (class 1259 OID 97290)
-- Name: dataset_altas_acumulado_barrios_populares; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_altas_acumulado_barrios_populares AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'barrios_vulnerables'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'altas_acumuladas'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 371 (class 1259 OID 102737)
-- Name: dataset_altas_dia_barrios_populares; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_altas_dia_barrios_populares AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'barrios_vulnerables'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'altas_reportados_del_dia'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 351 (class 1259 OID 96452)
-- Name: dataset_altas_no_residentes_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_altas_no_residentes_acumulado AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_no_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'altas_acumuladas'::text))
  ORDER BY dataset_reporte_covid_sit_gob.fecha;


--
-- TOC entry 369 (class 1259 OID 102718)
-- Name: dataset_altas_no_residentes_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_altas_no_residentes_dia AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_no_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'altas_reportados_del_dia'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 342 (class 1259 OID 95427)
-- Name: dataset_altas_residentes_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_altas_residentes_acumulado AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'altas_acumuladas'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 212 (class 1259 OID 50452)
-- Name: dataset_botitriage_consultas_evolucion; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_botitriage_consultas_evolucion AS
 SELECT 1 AS id,
    contactos_boti_triage_covid_19.fecha,
    to_char((contactos_boti_triage_covid_19.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    sum(contactos_boti_triage_covid_19.triage_cantidad) AS eje_y
   FROM public.contactos_boti_triage_covid_19
  GROUP BY contactos_boti_triage_covid_19.fecha
  ORDER BY contactos_boti_triage_covid_19.fecha;


--
-- TOC entry 282 (class 1259 OID 66822)
-- Name: dataset_botitriage_consultas_evolucion_tarjeta; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_botitriage_consultas_evolucion_tarjeta AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            contactos_boti_triage_covid_19.fecha,
            to_char((contactos_boti_triage_covid_19.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            sum(contactos_boti_triage_covid_19.triage_cantidad) AS eje_y
           FROM public.contactos_boti_triage_covid_19
          GROUP BY contactos_boti_triage_covid_19.fecha
          ORDER BY contactos_boti_triage_covid_19.fecha DESC
         LIMIT 15) t
  ORDER BY t.fecha;


--
-- TOC entry 374 (class 1259 OID 108332)
-- Name: dataset_camas_sistema_publico_graves; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_camas_sistema_publico_graves AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'ocupacion_de_camas_sistema_publico'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'graves_total'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 375 (class 1259 OID 108339)
-- Name: dataset_camas_sistema_publico_leves; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_camas_sistema_publico_leves AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'ocupacion_de_camas_sistema_publico'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'leves_total_hoteles_hospitales'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 364 (class 1259 OID 102682)
-- Name: dataset_camas_sistema_publico_moderados; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_camas_sistema_publico_moderados AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'ocupacion_de_camas_sistema_publico'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'moderados'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 595 (class 1259 OID 470314)
-- Name: dataset_web_covid; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_web_covid (
    id_1 integer,
    id_2 integer,
    id_3 integer,
    cat_fech_1 date,
    cat_str_1 character varying(300),
    cat_str_2 character varying(300),
    valor_1 integer,
    valor_2 integer,
    valor_3 numeric(6,2),
    fecha_act date,
    fecha_ult_reg date
);


--
-- TOC entry 606 (class 1259 OID 483852)
-- Name: dataset_cant_testeos_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_cant_testeos_docentes AS
 WITH mayores AS (
         SELECT 1 AS id,
            'MÁS DE 10 VECES'::text AS cat_str_1,
            sum(dataset_web_covid.valor_2) AS valor_2,
            100 AS orden
           FROM public.dataset_web_covid
          WHERE ((dataset_web_covid.id_1 = 9) AND (dataset_web_covid.id_2 = 19) AND (dataset_web_covid.valor_1 > 10))
        )
 SELECT 1 AS id,
    dataset_web_covid.valor_1 AS orden,
    dataset_web_covid.cat_str_1 AS eje_x,
    dataset_web_covid.valor_2 AS eje_y
   FROM public.dataset_web_covid
  WHERE ((dataset_web_covid.id_1 = 9) AND (dataset_web_covid.id_2 = 19) AND (dataset_web_covid.valor_1 <= 10))
UNION
 SELECT 1 AS id,
    mayores.orden,
    mayores.cat_str_1 AS eje_x,
    mayores.valor_2 AS eje_y
   FROM mayores
  ORDER BY 2;


--
-- TOC entry 213 (class 1259 OID 50456)
-- Name: dataset_casos_sisa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_casos_sisa (
    id integer NOT NULL,
    id_caso character varying,
    sexo character varying,
    edad integer,
    provincia character varying,
    fecha_apertura_snvs character varying,
    clasificacion character varying,
    fecha_clasificacion character varying,
    fecha_toma_muestra character varying,
    tipo_contagio character varying,
    alta_medica character varying,
    fecha_alta_medica character varying,
    fallecido character varying,
    fecha_fallecimiento character varying,
    lon_centroide_manzana character varying,
    lat_centroide_manzana character varying,
    barrio character varying,
    comuna character varying,
    geom character varying
);


--
-- TOC entry 214 (class 1259 OID 50462)
-- Name: dataset_casos_sisa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dataset_casos_sisa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7743 (class 0 OID 0)
-- Dependencies: 214
-- Name: dataset_casos_sisa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dataset_casos_sisa_id_seq OWNED BY public.dataset_casos_sisa.id;


--
-- TOC entry 414 (class 1259 OID 296071)
-- Name: dataset_turnos_detalle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_turnos_detalle (
    nro_cita integer,
    genero character varying,
    sede character varying,
    servicio character varying,
    estado character varying,
    fecha_solicitud timestamp without time zone,
    fecha_cita timestamp without time zone,
    edad integer,
    componente character varying(300)
);


--
-- TOC entry 573 (class 1259 OID 403125)
-- Name: dataset_citas_costa_salguero; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_citas_costa_salguero AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Costa Salguero (Vehicular)'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 518 (class 1259 OID 316363)
-- Name: dataset_citas_hoy_club_movistar_arena; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_citas_hoy_club_movistar_arena AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Movistar Arena'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 561 (class 1259 OID 366808)
-- Name: dataset_citas_hoy_min_des_hum; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_citas_hoy_min_des_hum AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Ministerio de Desarrollo Humano y Hábitat'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 519 (class 1259 OID 316368)
-- Name: dataset_citas_hoy_monasterio; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_citas_hoy_monasterio AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Ministerio de Salud'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 562 (class 1259 OID 368509)
-- Name: dataset_citas_hoy_papa_francisco; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_citas_hoy_papa_francisco AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Local Papa Francisco'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 555 (class 1259 OID 360924)
-- Name: dataset_citas_hoy_por_sede; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_citas_hoy_por_sede AS
 SELECT 1 AS id,
    2 AS fecha,
    sin_pami.sede AS eje_x,
    (count(sin_pami.nro_cita))::integer AS eje_y
   FROM ( SELECT dataset_turnos_detalle.nro_cita,
            dataset_turnos_detalle.genero,
            dataset_turnos_detalle.sede,
            dataset_turnos_detalle.servicio,
            dataset_turnos_detalle.estado,
            dataset_turnos_detalle.fecha_solicitud,
            dataset_turnos_detalle.fecha_cita,
            dataset_turnos_detalle.edad
           FROM public.dataset_turnos_detalle
          WHERE (((dataset_turnos_detalle.fecha_cita)::date = CURRENT_DATE) AND ((dataset_turnos_detalle.servicio)::text !~~ '%PAMI'::text))) sin_pami
  GROUP BY sin_pami.sede
  ORDER BY sin_pami.sede;


--
-- TOC entry 571 (class 1259 OID 400386)
-- Name: dataset_citas_parque_estacion; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_citas_parque_estacion AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Parque de la Estación'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 572 (class 1259 OID 400390)
-- Name: dataset_citas_teatro_san_martin; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_citas_teatro_san_martin AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Teatro San Martín'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 215 (class 1259 OID 50464)
-- Name: dataset_contactosbotitriage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_contactosbotitriage (
    id integer NOT NULL,
    fecha character varying,
    hora character varying,
    triage_cantidad character varying
);


--
-- TOC entry 216 (class 1259 OID 50470)
-- Name: dataset_contactosbotitriage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dataset_contactosbotitriage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7744 (class 0 OID 0)
-- Dependencies: 216
-- Name: dataset_contactosbotitriage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dataset_contactosbotitriage_id_seq OWNED BY public.dataset_contactosbotitriage.id;


--
-- TOC entry 209 (class 1259 OID 49583)
-- Name: dataset_cov_log_trabajos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_cov_log_trabajos (
    n_trabajo numeric(10,0),
    n_odt numeric(10,0),
    solicitud numeric(10,0),
    fec_ejec timestamp without time zone,
    ejecutor character varying(255),
    fec_sinc timestamp without time zone,
    usu_sincroni character varying(255),
    resultado character varying(255),
    verificado character varying(255),
    seguimiento character varying(255),
    num_referencia character varying(255),
    tip_trabajo character varying(255),
    ubicacion character varying(255),
    latitud numeric(10,8),
    longitud numeric(10,8)
);


--
-- TOC entry 279 (class 1259 OID 57749)
-- Name: dataset_cov_log_trabajos_hml; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_cov_log_trabajos_hml (
    id integer NOT NULL,
    n_trabajo character varying,
    n_odt character varying,
    solicitud character varying,
    fec_ejec character varying,
    ejecutor character varying,
    fec_sinc character varying,
    usu_sincroni character varying,
    resultado character varying,
    verificado character varying,
    seguimiento character varying,
    num_referencia character varying,
    tip_trabajo character varying,
    ubicacion character varying,
    latitud character varying,
    longitud character varying
);


--
-- TOC entry 278 (class 1259 OID 57747)
-- Name: dataset_cov_log_trabajos_HML_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."dataset_cov_log_trabajos_HML_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7745 (class 0 OID 0)
-- Dependencies: 278
-- Name: dataset_cov_log_trabajos_HML_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."dataset_cov_log_trabajos_HML_id_seq" OWNED BY public.dataset_cov_log_trabajos_hml.id;


--
-- TOC entry 307 (class 1259 OID 87417)
-- Name: dataset_cov_log_trabajos_test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_cov_log_trabajos_test (
    n_trabajo numeric(10,0),
    n_odt numeric(10,0),
    solicitud numeric(10,0),
    fec_ejec timestamp(6) without time zone,
    ejecutor character varying(255),
    fec_sinc timestamp(6) without time zone,
    usu_sincroni character varying(255),
    resultado character varying(255),
    verificado character varying(255),
    seguimiento character varying(255),
    num_referencia character varying(255),
    tip_trabajo character varying(255),
    ubicacion character varying(255),
    latitud numeric(10,8),
    longitud numeric(10,8)
);


--
-- TOC entry 303 (class 1259 OID 87280)
-- Name: dataset_covid_147_test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_covid_147_test (
    fecha timestamp without time zone,
    cantidad_voluntarios numeric(12,0),
    cantidad_adultos_mayores numeric(12,0),
    cantidad_contactos_147 numeric(12,0)
);


--
-- TOC entry 592 (class 1259 OID 466407)
-- Name: dataset_covid_web; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_covid_web (
    "ID_1" double precision,
    "ID_2" double precision,
    "ID_3" double precision,
    "CAT_FECH_1" timestamp without time zone,
    "CAT_STR_1" character varying(300),
    "CAT_STR_2" character varying(300),
    "VALOR_1" double precision,
    "VALOR_2" double precision,
    "VALOR_3" double precision,
    "FECHA_ACT" timestamp without time zone,
    "FECHA_ULT_REG" timestamp without time zone
);


--
-- TOC entry 217 (class 1259 OID 50472)
-- Name: dataset_recursos_humanos_salud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_recursos_humanos_salud (
    id integer NOT NULL,
    perfil character varying,
    fecha character varying,
    designados character varying
);


--
-- TOC entry 294 (class 1259 OID 84335)
-- Name: dataset_designados_atencion_al_ciudadano; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_designados_atencion_al_ciudadano AS
 SELECT 1 AS id,
    to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text) AS fecha,
    dataset_recursos_humanos_salud.fecha AS eje_x,
    (dataset_recursos_humanos_salud.designados)::integer AS dato
   FROM public.dataset_recursos_humanos_salud
  WHERE ((dataset_recursos_humanos_salud.perfil)::text = 'Atencion al ciudadano'::text)
  ORDER BY (to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text)) DESC
 LIMIT 1;


--
-- TOC entry 295 (class 1259 OID 84340)
-- Name: dataset_designados_bioquimicos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_designados_bioquimicos AS
 SELECT 1 AS id,
    to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text) AS fecha,
    dataset_recursos_humanos_salud.fecha AS eje_x,
    (dataset_recursos_humanos_salud.designados)::integer AS dato
   FROM public.dataset_recursos_humanos_salud
  WHERE ((dataset_recursos_humanos_salud.perfil)::text = 'Bioquimicos'::text)
  ORDER BY (to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text)) DESC
 LIMIT 1;


--
-- TOC entry 293 (class 1259 OID 84324)
-- Name: dataset_designados_enfermeros; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_designados_enfermeros AS
 SELECT 1 AS id,
    to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text) AS fecha,
    dataset_recursos_humanos_salud.fecha AS eje_x,
    (dataset_recursos_humanos_salud.designados)::integer AS dato
   FROM public.dataset_recursos_humanos_salud
  WHERE ((dataset_recursos_humanos_salud.perfil)::text = 'Enfermeros'::text)
  ORDER BY (to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text)) DESC
 LIMIT 1;


--
-- TOC entry 291 (class 1259 OID 84316)
-- Name: dataset_designados_kinesiologos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_designados_kinesiologos AS
 SELECT 1 AS id,
    to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text) AS fecha,
    dataset_recursos_humanos_salud.fecha AS eje_x,
    (dataset_recursos_humanos_salud.designados)::integer AS dato
   FROM public.dataset_recursos_humanos_salud
  WHERE ((dataset_recursos_humanos_salud.perfil)::text = 'Kinesiologos'::text)
  ORDER BY (to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text)) DESC
 LIMIT 1;


--
-- TOC entry 290 (class 1259 OID 84305)
-- Name: dataset_designados_medicos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_designados_medicos AS
 SELECT 1 AS id,
    to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text) AS fecha,
    dataset_recursos_humanos_salud.fecha AS eje_x,
    (dataset_recursos_humanos_salud.designados)::integer AS dato
   FROM public.dataset_recursos_humanos_salud
  WHERE ((dataset_recursos_humanos_salud.perfil)::text = 'Medicos'::text)
  ORDER BY (to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text)) DESC
 LIMIT 1;


--
-- TOC entry 296 (class 1259 OID 84348)
-- Name: dataset_designados_relevadores_detectar; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_designados_relevadores_detectar AS
 SELECT 1 AS id,
    to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text) AS fecha,
    dataset_recursos_humanos_salud.fecha AS eje_x,
    (dataset_recursos_humanos_salud.designados)::integer AS dato
   FROM public.dataset_recursos_humanos_salud
  WHERE ((dataset_recursos_humanos_salud.perfil)::text = 'Relevadores Detectar'::text)
  ORDER BY (to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text)) DESC
 LIMIT 1;


--
-- TOC entry 277 (class 1259 OID 57646)
-- Name: dataset_designados_suplentes_guardia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_designados_suplentes_guardia AS
 SELECT 1 AS id,
    to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text) AS fecha,
    dataset_recursos_humanos_salud.fecha AS eje_x,
    (dataset_recursos_humanos_salud.designados)::integer AS dato
   FROM public.dataset_recursos_humanos_salud
  WHERE ((dataset_recursos_humanos_salud.perfil)::text = 'Profesionales médicos y de la Salud suplentes de guardia '::text)
  ORDER BY (to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text)) DESC
 LIMIT 1;


--
-- TOC entry 292 (class 1259 OID 84320)
-- Name: dataset_designados_tecnicos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_designados_tecnicos AS
 SELECT 1 AS id,
    to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text) AS fecha,
    dataset_recursos_humanos_salud.fecha AS eje_x,
    (dataset_recursos_humanos_salud.designados)::integer AS dato
   FROM public.dataset_recursos_humanos_salud
  WHERE ((dataset_recursos_humanos_salud.perfil)::text = 'Tecnicos de la salud'::text)
  ORDER BY (to_date((dataset_recursos_humanos_salud.fecha)::text, 'DD/MM/YYYY'::text)) DESC
 LIMIT 1;


--
-- TOC entry 334 (class 1259 OID 94516)
-- Name: dataset_detectar_1_11_14; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_1_11_14 AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_1-11-14'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_barrio_1-11-14'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 333 (class 1259 OID 94511)
-- Name: dataset_detectar_21_24; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_21_24 AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_21-24'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_barrio_21-24'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 323 (class 1259 OID 94431)
-- Name: dataset_detectar_almagro; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_almagro AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_almagro'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_almagro'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 328 (class 1259 OID 94488)
-- Name: dataset_detectar_balvanera; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_balvanera AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_balvanera'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_balvanera'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 324 (class 1259 OID 94435)
-- Name: dataset_detectar_barracas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_barracas AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_barracas'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_barracas'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 332 (class 1259 OID 94504)
-- Name: dataset_detectar_barrio_15; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_barrio_15 AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_15'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_barrio_15'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 331 (class 1259 OID 94500)
-- Name: dataset_detectar_barrio_20; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_barrio_20 AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_20'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_barrio_20'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 335 (class 1259 OID 94523)
-- Name: dataset_detectar_barrio_31; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_barrio_31 AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_31'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_barrio_31'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 330 (class 1259 OID 94496)
-- Name: dataset_detectar_barrio_carrillo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_barrio_carrillo AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_carrillo'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_barrio_carrillo'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 319 (class 1259 OID 94393)
-- Name: dataset_detectar_boedo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_boedo AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_boedo'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_boedo'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 321 (class 1259 OID 94401)
-- Name: dataset_detectar_caballito; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_caballito AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_caballito'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_caballito'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 322 (class 1259 OID 94409)
-- Name: dataset_detectar_chacarita; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_chacarita AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_chacarita'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_chacarita'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 325 (class 1259 OID 94439)
-- Name: dataset_detectar_constitucion; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_constitucion AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_constitucion'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_constitucion'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 327 (class 1259 OID 94450)
-- Name: dataset_detectar_flores; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_flores AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_flores'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_flores'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 326 (class 1259 OID 94443)
-- Name: dataset_detectar_la_boca; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_la_boca AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_la_boca'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_la_boca'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 394 (class 1259 OID 125251)
-- Name: dataset_detectar_la_paternal; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_la_paternal AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_la_paternal'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_la_paternal'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 318 (class 1259 OID 94382)
-- Name: dataset_detectar_mataderos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_mataderos AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_mataderos'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_mataderos'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 399 (class 1259 OID 270714)
-- Name: dataset_detectar_palermo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_palermo AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_barrio_palermo'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_palermo'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 320 (class 1259 OID 94397)
-- Name: dataset_detectar_parque_chacabuco; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_parque_chacabuco AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_parque_chacabuco'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_parque_chacabuco'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 317 (class 1259 OID 94375)
-- Name: dataset_detectar_recoleta; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_recoleta AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_recoleta'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_recoleta'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 329 (class 1259 OID 94492)
-- Name: dataset_detectar_rodrigo_bueno; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_rodrigo_bueno AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_rodrigo_bueno'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_rodrigo_bueno'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 373 (class 1259 OID 105393)
-- Name: dataset_detectar_san_cristobal; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_san_cristobal AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_san_cristobal'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_san_cristobal'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 395 (class 1259 OID 130876)
-- Name: dataset_detectar_san_telmo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_san_telmo AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_san_telmo'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_san_telmo'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 341 (class 1259 OID 95158)
-- Name: dataset_detectar_soldati_lugano_pompeya; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_soldati_lugano_pompeya AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_villa_riachuelo_-_lugano'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_villa_riachuelo_-_lugano'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 353 (class 1259 OID 97223)
-- Name: dataset_detectar_soldati_pompeya; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_detectar_soldati_pompeya AS
 SELECT 1 AS id,
    ha.fecha,
    (hd.valor)::integer AS valor1,
    (ha.valor)::integer AS valor2
   FROM (public.dataset_reporte_covid_sit_gob hd
     LEFT JOIN public.dataset_reporte_covid_sit_gob ha ON ((hd.fecha = ha.fecha)))
  WHERE (((hd.subtipo_dato)::text = 'hisopados_soldati'::text) AND ((ha.subtipo_dato)::text = 'casos_confirmados_soldati'::text))
  ORDER BY ha.fecha DESC
 LIMIT 1;


--
-- TOC entry 538 (class 1259 OID 324308)
-- Name: dataset_empadronados_docentes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_empadronados_docentes (
    sid numeric(12,0),
    submitted timestamp(6) without time zone,
    completed timestamp(6) without time zone,
    modified timestamp(6) without time zone,
    nombre character varying(1024),
    apellido character varying(1024),
    tipo_docu character varying(1024),
    nro_documento character varying(1024),
    genero character varying(1024),
    situacion character varying(1024),
    cod_area character varying(1024),
    celular character varying(1024),
    telefono character varying(1024),
    mail character varying(1024),
    confirmacion_mail character varying(1024),
    provincia character varying(1024),
    municipio character varying(1024),
    localidad character varying(1024),
    calle character varying(1024),
    altura character varying(1024),
    piso character varying(1024),
    dpto character varying(1024),
    cod_postal character varying(1024),
    nro_escula character varying(1024),
    nom_establecimiento character varying(1024),
    distrito_escolar character varying(1024),
    tipo_gestion character varying(1024),
    calle_escuela character varying(1024),
    altura_escula character varying(1024),
    gradi character varying(1024),
    modalidad character varying(1024),
    funcion character varying(1024),
    fec_nacimiento character varying(1024),
    conf_nro_documento character varying(1024)
);


--
-- TOC entry 541 (class 1259 OID 328898)
-- Name: dataset_docentes_empadronados_por_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_docentes_empadronados_por_dia AS
 SELECT 1 AS id,
    (dataset_empadronados_docentes.submitted)::date AS fecha,
    to_char(dataset_empadronados_docentes.submitted, 'DD-MM'::text) AS eje_x,
    (count(*))::integer AS eje_y
   FROM public.dataset_empadronados_docentes
  GROUP BY ((dataset_empadronados_docentes.submitted)::date), (to_char(dataset_empadronados_docentes.submitted, 'DD-MM'::text))
  ORDER BY ((dataset_empadronados_docentes.submitted)::date);


--
-- TOC entry 543 (class 1259 OID 331825)
-- Name: dataset_empadronados_bukuala; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_empadronados_bukuala (
    id numeric(12,0),
    tipo_formulario character varying(128),
    tipo_documento character varying(64),
    documento character varying(32),
    submitted timestamp(6) without time zone,
    completed timestamp(6) without time zone,
    modified timestamp(6) without time zone,
    genero character varying(32),
    nombre character varying(128),
    apellido character varying(128),
    edad numeric(12,0),
    fec_nacimiento timestamp(6) without time zone,
    barrio character varying(128),
    calle character varying(256),
    altura_piso character varying(512),
    comuna character varying(128),
    cobertura_med character varying(255),
    mail character varying(128),
    telefono character varying(128),
    celular character varying(128),
    nombre_acomp character varying(128),
    apellido_acomp character varying(128),
    telefono_acomp character varying(128),
    mail_acomp character varying(128),
    relacion_acomp character varying(64),
    prepaga character varying(125)
);


--
-- TOC entry 527 (class 1259 OID 318234)
-- Name: dataset_empadronados_drupal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_empadronados_drupal (
    sid numeric(12,0),
    submitted timestamp(6) without time zone,
    completed timestamp(6) without time zone,
    modified timestamp(6) without time zone,
    genero character varying(255),
    nombre character varying(255),
    edad character varying(255),
    fec_nacimiento character varying(255),
    barrio character varying(255),
    calle character varying(255),
    cobertura_med character varying(255),
    lista_cobertura_med character varying(255),
    mail character varying(255),
    telefono character varying(255),
    celular character varying(255),
    nombre_acomp character varying(255),
    telefono_acomp character varying(255),
    celular_acomp character varying(255),
    mail_acomp character varying(255),
    relacion_acomp character varying(255),
    situacion character varying(255),
    apellido_acomp character varying(255),
    dni character varying(255),
    apellido character varying(255),
    comuna character varying(255),
    altura character varying(255),
    piso character varying(255)
);


--
-- TOC entry 542 (class 1259 OID 330036)
-- Name: dataset_empadronados_pers_salud; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_empadronados_pers_salud (
    sid numeric(12,0),
    submitted timestamp(6) without time zone,
    completed timestamp(6) without time zone,
    modified timestamp(6) without time zone,
    apellido character varying(1024),
    apellido_2 character varying(1024),
    genero character varying(1024),
    tipo_docu character varying(1024),
    fec_nacimiento character varying(1024),
    mail character varying(1024),
    celular character varying(1024),
    domicilio character varying(1024),
    profesion character varying(1024),
    nro_documento character varying(1024),
    situacion character varying(1024),
    institucion character varying(1024),
    nombre character varying(1024),
    nombre_2 character varying(1024),
    matricula character varying(1024)
);


--
-- TOC entry 554 (class 1259 OID 354960)
-- Name: dataset_inscriptos_det_bukeala; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_inscriptos_det_bukeala (
    fecha_creacion date,
    tipo_doc character varying(300),
    num_doc character varying(30),
    genero character varying(9),
    apellido_nombres character varying(255),
    fecha_nacimiento date,
    servicio character varying(255),
    email character varying(255),
    tel_cel character varying(255),
    tel_fij character varying(255),
    orden integer
);


--
-- TOC entry 576 (class 1259 OID 410021)
-- Name: dataset_empadronados_riesgo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_empadronados_riesgo AS
 WITH bukeala_num AS (
         SELECT count(*) AS buk_sum,
            max(bukeala.fecha_creacion) AS fecha
           FROM ( SELECT count(*) AS bukeala_count,
                    max(dataset_inscriptos_det_bukeala.fecha_creacion) AS fecha_creacion
                   FROM public.dataset_inscriptos_det_bukeala
                  WHERE ((dataset_inscriptos_det_bukeala.servicio)::text ~~ 'RIESGOS%'::text)
                  GROUP BY dataset_inscriptos_det_bukeala.tipo_doc, dataset_inscriptos_det_bukeala.num_doc) bukeala
        )
 SELECT 1 AS id,
    bukeala_num.fecha,
    to_char((bukeala_num.fecha)::timestamp with time zone, 'DD-MM'::text) AS to_char,
    bukeala_num.buk_sum AS total_emp
   FROM bukeala_num;


--
-- TOC entry 356 (class 1259 OID 97286)
-- Name: dataset_fallecidos_acumulado_barrios_populares; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_fallecidos_acumulado_barrios_populares AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'barrios_vulnerables'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'fallecidos_acumulados'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 349 (class 1259 OID 96441)
-- Name: dataset_fallecidos_acumulados_residentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_fallecidos_acumulados_residentes AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'fallecidos_acumulados'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 372 (class 1259 OID 102741)
-- Name: dataset_fallecidos_dia_barrios_populares; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_fallecidos_dia_barrios_populares AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'barrios_vulnerables'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'fallecidos_reportados_del_dia'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 352 (class 1259 OID 96456)
-- Name: dataset_fallecidos_no_residentes_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_fallecidos_no_residentes_acumulado AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_no_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'fallecidos_acumulados'::text))
  ORDER BY dataset_reporte_covid_sit_gob.fecha;


--
-- TOC entry 396 (class 1259 OID 167209)
-- Name: dataset_fallecidos_no_residentes_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_fallecidos_no_residentes_dia AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_no_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'fallecidos_reportados_del_dia'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 301 (class 1259 OID 86279)
-- Name: dataset_flujo_vehicular; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_flujo_vehicular (
    codigo_locacion character varying(255),
    hora timestamp without time zone,
    cantidad numeric(12,0),
    sentido character varying(255),
    latitud character varying(255),
    longitud character varying(255)
);


--
-- TOC entry 218 (class 1259 OID 50508)
-- Name: dataset_movilidad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_movilidad (
    id integer NOT NULL,
    fecha character varying,
    ntrx_colectivo character varying,
    ntrx_subte character varying,
    ntrx_tren character varying,
    ntrx_total character varying,
    cantidad_egreso character varying,
    cantidad_ingreso character varying,
    cantidad_interna character varying
);


--
-- TOC entry 362 (class 1259 OID 101823)
-- Name: dataset_flujo_egreso_variacion_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_flujo_egreso_variacion_dia AS
 WITH fecha AS (
         SELECT date_part('dow'::text, max((dataset_flujo_vehicular.hora)::date)) AS date_part
           FROM public.dataset_flujo_vehicular
        )
 SELECT 1 AS id,
    ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
           FROM public.dataset_flujo_vehicular) AS fecha,
        CASE
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (0)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Egreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (1)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Egreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (2)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Egreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (3)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Egreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (4)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Egreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (5)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Egreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (6)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Egreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_egreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            ELSE NULL::text
        END AS dato;


--
-- TOC entry 363 (class 1259 OID 101828)
-- Name: dataset_flujo_ingreso_variacion_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_flujo_ingreso_variacion_dia AS
 WITH fecha AS (
         SELECT date_part('dow'::text, max((dataset_flujo_vehicular.hora)::date)) AS date_part
           FROM public.dataset_flujo_vehicular
        )
 SELECT 1 AS id,
    ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
           FROM public.dataset_flujo_vehicular) AS fecha,
        CASE
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (0)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Ingreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (1)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Ingreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (2)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Ingreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (3)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Ingreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (4)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Ingreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (5)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Ingreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (6)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Ingreso'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_ingreso)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            ELSE NULL::text
        END AS dato;


--
-- TOC entry 392 (class 1259 OID 109390)
-- Name: dataset_flujo_interna_variacion_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_flujo_interna_variacion_dia AS
 WITH fecha AS (
         SELECT date_part('dow'::text, max((dataset_flujo_vehicular.hora)::date)) AS date_part
           FROM public.dataset_flujo_vehicular
        )
 SELECT 1 AS id,
    ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
           FROM public.dataset_flujo_vehicular) AS fecha,
        CASE
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (0)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Interna'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_interna)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_interna)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (1)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Interna'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_interna)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_interna)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (2)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Interna'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_interna)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_interna)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (3)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Interna'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_interna)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_interna)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (4)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Interna'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_interna)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_interna)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (5)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Interna'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_interna)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_interna)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (6)::double precision) THEN replace(concat(((((((( SELECT (sum(d.cantidad))::integer AS sum
               FROM public.dataset_flujo_vehicular d
              WHERE (((d.sentido)::text = 'Interna'::text) AND ((d.hora)::date = ( SELECT max((dataset_flujo_vehicular.hora)::date) AS max
                       FROM public.dataset_flujo_vehicular)))
              GROUP BY ((d.hora)::date)))::numeric - (( SELECT (dataset_movilidad.cantidad_interna)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) / (( SELECT (dataset_movilidad.cantidad_interna)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            ELSE NULL::text
        END AS dato;


--
-- TOC entry 379 (class 1259 OID 108512)
-- Name: dataset_hisopados_por_habitante; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_hisopados_por_habitante AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'personas_hisopadas'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'tasa_personas_hisopadas_c_100_000_hab'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 382 (class 1259 OID 108524)
-- Name: dataset_hisopados_positivos_acumulado_no_residentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_hisopados_positivos_acumulado_no_residentes AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    replace(concat((round(dataset_reporte_covid_sit_gob.valor, 1))::text, '%'), '.'::text, ','::text) AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'personas_hisopadas'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = '%_positividad_personas_hisopadas_acumulada_no_caba'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 564 (class 1259 OID 373790)
-- Name: dataset_hisopados_positivos_dia_no_residentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_hisopados_positivos_dia_no_residentes AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    replace(concat((round(dataset_reporte_covid_sit_gob.valor, 1))::text, '%'), '.'::text, ','::text) AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'personas_hisopadas'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = '%_positividad_personas_hisopadas_reportados_del_dia_no_caba'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 383 (class 1259 OID 108535)
-- Name: dataset_hisopados_totales_acumulado_no_residentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_hisopados_totales_acumulado_no_residentes AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'personas_hisopadas'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'personas_hisopadas_acumulados_no_caba'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 388 (class 1259 OID 108591)
-- Name: dataset_hisopados_totales_dia_acumulado_doble; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_hisopados_totales_dia_acumulado_doble AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'personas_hisopadas'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'personas_hisopadas_acumulados_caba'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 354 (class 1259 OID 97254)
-- Name: dataset_hisopados_totales_dia_no_residentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_hisopados_totales_dia_no_residentes AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'personas_hisopadas'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'personas_hisopadas_reportados_del_dia_no_caba'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 204 (class 1259 OID 33061)
-- Name: distanciamiento_covid19; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.distanciamiento_covid19 (
    fecha timestamp without time zone,
    id_hotel character varying(255),
    origen character varying(255),
    genero character varying(255),
    cantidad_ingresos numeric(12,0),
    cantidad_egresos numeric(12,0)
);


--
-- TOC entry 286 (class 1259 OID 67511)
-- Name: dataset_hospedados_acumulados; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_hospedados_acumulados AS
 SELECT 1 AS id,
    (distanciamiento_covid19.fecha)::date AS fecha,
    ((( SELECT sum(distanciamiento_covid19_1.cantidad_ingresos) AS sum
           FROM public.distanciamiento_covid19 distanciamiento_covid19_1) - ( SELECT sum(distanciamiento_covid19_1.cantidad_egresos) AS sum
           FROM public.distanciamiento_covid19 distanciamiento_covid19_1)))::integer AS dato
   FROM public.distanciamiento_covid19
  ORDER BY distanciamiento_covid19.fecha DESC
 LIMIT 1;


--
-- TOC entry 289 (class 1259 OID 84265)
-- Name: dataset_hospedados_egresos_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_hospedados_egresos_dia AS
 SELECT 1 AS id,
    ( SELECT max((distanciamiento_covid19_1.fecha)::date) AS max
           FROM public.distanciamiento_covid19 distanciamiento_covid19_1
          GROUP BY ((distanciamiento_covid19_1.fecha)::date)
          ORDER BY ((distanciamiento_covid19_1.fecha)::date) DESC
         LIMIT 1) AS fecha,
    to_char((( SELECT max((distanciamiento_covid19_1.fecha)::date) AS max
           FROM public.distanciamiento_covid19 distanciamiento_covid19_1
          GROUP BY ((distanciamiento_covid19_1.fecha)::date)
          ORDER BY ((distanciamiento_covid19_1.fecha)::date) DESC
         LIMIT 1))::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    sum((distanciamiento_covid19.cantidad_egresos)::integer) AS eje_y
   FROM public.distanciamiento_covid19
  WHERE (distanciamiento_covid19.fecha > (( SELECT max((distanciamiento_covid19_1.fecha)::date) AS max
           FROM public.distanciamiento_covid19 distanciamiento_covid19_1
          GROUP BY ((distanciamiento_covid19_1.fecha)::date)
          ORDER BY ((distanciamiento_covid19_1.fecha)::date) DESC
         LIMIT 1) - '7 days'::interval day));


--
-- TOC entry 575 (class 1259 OID 405430)
-- Name: dataset_hospedados_flujo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_hospedados_flujo AS
 SELECT 1 AS id,
    (distanciamiento_covid19.fecha)::date AS fecha,
    to_char(((distanciamiento_covid19.fecha)::date)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    sum((distanciamiento_covid19.cantidad_ingresos)::integer) AS eje_y,
    sum((distanciamiento_covid19.cantidad_egresos)::integer) AS eje_y2
   FROM public.distanciamiento_covid19
  GROUP BY ((distanciamiento_covid19.fecha)::date)
  ORDER BY ((distanciamiento_covid19.fecha)::date)
 LIMIT 1;


--
-- TOC entry 288 (class 1259 OID 84255)
-- Name: dataset_hospedados_ingresos_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_hospedados_ingresos_dia AS
 SELECT 1 AS id,
    ( SELECT max((distanciamiento_covid19_1.fecha)::date) AS max
           FROM public.distanciamiento_covid19 distanciamiento_covid19_1
          GROUP BY ((distanciamiento_covid19_1.fecha)::date)
          ORDER BY ((distanciamiento_covid19_1.fecha)::date) DESC
         LIMIT 1) AS fecha,
    to_char((( SELECT max((distanciamiento_covid19_1.fecha)::date) AS max
           FROM public.distanciamiento_covid19 distanciamiento_covid19_1
          GROUP BY ((distanciamiento_covid19_1.fecha)::date)
          ORDER BY ((distanciamiento_covid19_1.fecha)::date) DESC
         LIMIT 1))::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    sum((distanciamiento_covid19.cantidad_ingresos)::integer) AS eje_y
   FROM public.distanciamiento_covid19
  WHERE (distanciamiento_covid19.fecha > (( SELECT max((distanciamiento_covid19_1.fecha)::date) AS max
           FROM public.distanciamiento_covid19 distanciamiento_covid19_1
          GROUP BY ((distanciamiento_covid19_1.fecha)::date)
          ORDER BY ((distanciamiento_covid19_1.fecha)::date) DESC
         LIMIT 1) - '7 days'::interval day));


--
-- TOC entry 312 (class 1259 OID 92078)
-- Name: dataset_indicadores_covid19; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_indicadores_covid19 (
    fecha timestamp(6) without time zone,
    positivos_acumulado numeric(14,0),
    positivos_dia numeric(14,0),
    positivos_residentes_acumulado numeric(14,0),
    positivos_residentes_dia numeric(14,0),
    altas_acumulado numeric(14,0),
    altas_dia numeric(14,0),
    fallecidos_acumulado numeric(14,0),
    fallecidos_dia numeric(14,0),
    hisopados_totales_acumulado numeric(14,0),
    hisopados_totales_dia numeric(14,0),
    hisopados_positivos_acumulado numeric(14,6),
    hisopados_positivos_dia numeric(14,6),
    positivos_dia_barrios_populares numeric(14,0),
    altas_dia_barrios_populares numeric(14,0),
    fallecidos_dia_barrios_populares numeric(14,0),
    positivos_acumulado_barrios_populares numeric(14,0),
    altas_acumulado_barrios_populares numeric(14,0),
    fallecidos_acumulado_barrios_populares numeric(14,0),
    letalidad_barrio_popular numeric(14,6),
    letalidad numeric(14,6),
    hisopados_acumulados_2 numeric(14,0),
    fallecidos_acumulados_residentes numeric(14,0),
    hisopados_acum_dos_dias numeric(14,0),
    confirmados_acum_dos_dias numeric(14,0),
    positivos_residentes_acumulados_menos_60 numeric(14,0),
    fallecidos_acumulado_res_60 numeric(14,0),
    tasa_fallecidos_60 numeric(14,6),
    tasa_positivos_menos_60 numeric(14,6),
    positivos_no_residentes_acumulado numeric(14,0),
    positivos_no_residentes_dia numeric(14,0),
    altas_residentes_acumulado numeric(14,0),
    altas_no_residentes_acumulado numeric(14,0),
    altas_residentes_dia numeric(14,0),
    altas_no_residentes_dia numeric(14,0),
    fallecidos_no_residentes_acu numeric(14,0),
    fallecidos_residentes_dia numeric(14,0),
    fallecidos_no_residentes_dia numeric(14,0),
    hisopados_totales_no_res_acu numeric(14,0),
    hisopados_totales_no_res_dia numeric(14,0),
    hisopados_totales_no_res_acu_2 numeric(14,0),
    hisopados_positivos_no_residentes numeric(14,6),
    confirmados_no_residentes_acum_d numeric(14,0),
    hisopados_no_residentes_acum_dos numeric(14,0),
    hisopados_positivos_no_res_dia_2 numeric(14,6)
);


--
-- TOC entry 419 (class 1259 OID 297001)
-- Name: dataset_indicadores_vacunacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_indicadores_vacunacion (
    etapa text,
    subpriorizacion character varying,
    dosis_recibidas integer,
    tipos_vacunas character varying,
    status character varying,
    dosis_aplica_entrega character varying,
    fecha date
);


--
-- TOC entry 526 (class 1259 OID 316676)
-- Name: dataset_indicadores_vacunacion_2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_indicadores_vacunacion_2 (
    dosis_recibidas integer,
    status character varying(255),
    fecha date
);


--
-- TOC entry 211 (class 1259 OID 50441)
-- Name: dataset_llamados_107_covid; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_llamados_107_covid (
    fecha timestamp without time zone NOT NULL,
    covid_llamados numeric(12,0),
    casos_sospechosos numeric(12,0),
    casos_descartados_covid numeric(12,0),
    casos_trasladados numeric(12,0),
    casos_derivados numeric(12,0)
);


--
-- TOC entry 283 (class 1259 OID 67239)
-- Name: dataset_log_ufu_obra_social_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_log_ufu_obra_social_acumulado AS
 SELECT 1 AS id,
    (dataset_cov_log_trabajos.fec_ejec)::date AS fecha,
    ( SELECT count(*) AS count
           FROM public.dataset_cov_log_trabajos dataset_cov_log_trabajos_1
          WHERE ((((dataset_cov_log_trabajos_1.tip_trabajo)::text = 'Derivación Obra Social v1'::text) AND ((dataset_cov_log_trabajos_1.resultado)::text = 'Ambulancia'::text)) OR (((dataset_cov_log_trabajos_1.tip_trabajo)::text = 'Derivación Obra Social'::text) AND ((dataset_cov_log_trabajos_1.resultado)::text = 'Ambulancia'::text)) OR (((dataset_cov_log_trabajos_1.tip_trabajo)::text = 'Derivación Obra Social'::text) AND ((dataset_cov_log_trabajos_1.resultado)::text = 'TUFU - Obra Social'::text)))) AS dato
   FROM public.dataset_cov_log_trabajos
  ORDER BY ((dataset_cov_log_trabajos.fec_ejec)::date) DESC
 LIMIT 1;


--
-- TOC entry 284 (class 1259 OID 67292)
-- Name: dataset_logistica_cesac_ufu_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_logistica_cesac_ufu_acumulado AS
 SELECT 1 AS id,
    (dataset_cov_log_trabajos.fec_ejec)::date AS fecha,
    (( SELECT count(*) AS count
           FROM public.dataset_cov_log_trabajos dataset_cov_log_trabajos_1
          WHERE ((dataset_cov_log_trabajos_1.tip_trabajo)::text = 'Despacho CESAC'::text)))::integer AS dato
   FROM public.dataset_cov_log_trabajos
  WHERE ((dataset_cov_log_trabajos.tip_trabajo)::text = 'Despacho CESAC'::text)
  ORDER BY ((dataset_cov_log_trabajos.fec_ejec)::date) DESC
 LIMIT 1;


--
-- TOC entry 377 (class 1259 OID 108354)
-- Name: dataset_p_camas_ocupacion_graves; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_p_camas_ocupacion_graves AS
 SELECT 1 AS id,
    ( SELECT dataset_reporte_covid_sit_gob.fecha
           FROM public.dataset_reporte_covid_sit_gob
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1) AS fecha,
    concat((round(((( SELECT dataset_reporte_covid_sit_gob.valor
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'ocupacion_de_camas_sistema_publico'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'graves_total'::text))
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1) / ( SELECT dataset_reporte_covid_sit_gob.valor
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'total_de_camas_sistema_publico'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'graves'::text))
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1)) * (100)::numeric), 2))::text, '%') AS dato;


--
-- TOC entry 376 (class 1259 OID 108349)
-- Name: dataset_p_camas_ocupacion_leves; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_p_camas_ocupacion_leves AS
 SELECT 1 AS id,
    ( SELECT dataset_reporte_covid_sit_gob.fecha
           FROM public.dataset_reporte_covid_sit_gob
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1) AS fecha,
    concat((round(((( SELECT dataset_reporte_covid_sit_gob.valor
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'ocupacion_de_camas_sistema_publico'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'leves_total_hoteles_hospitales'::text))
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1) / ( SELECT dataset_reporte_covid_sit_gob.valor
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'total_de_camas_sistema_publico'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'leves_hoteles_hospitales'::text))
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1)) * (100)::numeric), 2))::text, '%') AS dato;


--
-- TOC entry 390 (class 1259 OID 108687)
-- Name: dataset_p_camas_ocupacion_moderadas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_p_camas_ocupacion_moderadas AS
 SELECT 1 AS id,
    ( SELECT dataset_reporte_covid_sit_gob.fecha
           FROM public.dataset_reporte_covid_sit_gob
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1) AS fecha,
    concat((round(((( SELECT dataset_reporte_covid_sit_gob.valor
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'ocupacion_de_camas_sistema_publico'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'moderados'::text))
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1) / ( SELECT dataset_reporte_covid_sit_gob.valor
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'total_de_camas_sistema_publico'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'moderados'::text))
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1)) * (100)::numeric), 2))::text, '%') AS dato;


--
-- TOC entry 347 (class 1259 OID 96186)
-- Name: dataset_pcr_realizados_pos_reportados_dia_centros_salud; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_pcr_realizados_pos_reportados_dia_centros_salud AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'tr_en_centros_de_salud_hospitales_cesacs_cemar_e_irep'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'pcr_realizados_positivos_reportados_del_dia'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, ((dataset_reporte_covid_sit_gob.valor)::integer)
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 336 (class 1259 OID 94534)
-- Name: dataset_pcr_realizados_pos_reportados_dia_geriatricos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_pcr_realizados_pos_reportados_dia_geriatricos AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'tr_en_geriatricos'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'pcr_realizados_positivos_reportados_del_dia'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, ((dataset_reporte_covid_sit_gob.valor)::integer)
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 346 (class 1259 OID 96182)
-- Name: dataset_pcr_realizados_positivos_centros_salud; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_pcr_realizados_positivos_centros_salud AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'tr_en_centros_de_salud_hospitales_cesacs_cemar_e_irep'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'pcr_realizados_positivos'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, ((dataset_reporte_covid_sit_gob.valor)::integer)
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 337 (class 1259 OID 94538)
-- Name: dataset_pcr_realizados_positivos_geriatricos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_pcr_realizados_positivos_geriatricos AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'tr_en_geriatricos'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'pcr_realizados_positivos'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, ((dataset_reporte_covid_sit_gob.valor)::integer)
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 416 (class 1259 OID 296138)
-- Name: dataset_positivo_turista_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivo_turista_acumulado AS
 SELECT 1 AS id,
    t3.fecha,
    to_char((t3.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    concat((round(((t1.positivos_totales * (100)::numeric) / t2.testeos_totales)))::integer, '%') AS eje_y
   FROM ((( SELECT sum(dtt.n) AS positivos_totales,
            4 AS id
           FROM public.dataset_testeo_turismo dtt
          WHERE ((dtt.tipo)::text = 'positivos'::text)) t1
     JOIN ( SELECT sum(tt.n) AS testeos_totales,
            4 AS id
           FROM public.dataset_testeo_turismo tt
          WHERE ((tt.tipo)::text = 'testeos'::text)) t2 ON ((t1.id = t2.id)))
     JOIN ( SELECT df.fecha_muestra AS fecha,
            4 AS id
           FROM public.dataset_testeo_turismo df
          ORDER BY df.fecha_muestra DESC
         LIMIT 1) t3 ON ((t3.id = t2.id)));


--
-- TOC entry 415 (class 1259 OID 296110)
-- Name: dataset_positivo_turista_diario; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivo_turista_diario AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    concat((round((((t.eje_y * 100))::numeric / tot.testeos_total_por_dia)))::integer, '%') AS eje_y2
   FROM (( SELECT 1 AS id,
            tt.fecha_muestra AS fecha,
            to_char((tt.fecha_muestra)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (sum(tt.n))::integer AS eje_y
           FROM public.dataset_testeo_turismo tt
          WHERE ((tt.tipo)::text = 'positivos'::text)
          GROUP BY tt.fecha_muestra
          ORDER BY tt.fecha_muestra DESC
         LIMIT 30) t
     JOIN ( SELECT to_char((dtt.fecha_muestra)::timestamp with time zone, 'DD-MM'::text) AS fecha,
            sum(dtt.n) AS testeos_total_por_dia
           FROM public.dataset_testeo_turismo dtt
          GROUP BY dtt.fecha_muestra, dtt.tipo
         HAVING ((dtt.tipo)::text <> 'positivos'::text)
          ORDER BY (to_char((dtt.fecha_muestra)::timestamp with time zone, 'DD-MM'::text))) tot ON ((tot.fecha = t.eje_x)))
  ORDER BY t.fecha;


--
-- TOC entry 405 (class 1259 OID 295452)
-- Name: dataset_positivo_turista_diario_barra; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivo_turista_diario_barra AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    to_char((dataset_testeo_turismo.fecha_muestra)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (sum(dataset_testeo_turismo.n))::integer AS eje_y
   FROM public.dataset_testeo_turismo
  WHERE ((dataset_testeo_turismo.tipo)::text = 'positivos'::text)
  GROUP BY dataset_testeo_turismo.fecha_muestra
  ORDER BY dataset_testeo_turismo.fecha_muestra;


--
-- TOC entry 448 (class 1259 OID 298452)
-- Name: dataset_positivo_turista_fecha_testeo_edad; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivo_turista_fecha_testeo_edad AS
 SELECT 1 AS id,
    tercer_grupo.fecha,
    to_char((tercer_grupo.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (primer_grupo.eje_y)::integer AS eje_y,
    (segundo_grupo.eje_y)::integer AS eje_y2,
    (tercer_grupo.eje_y)::integer AS eje_y3
   FROM ((( SELECT tabla1.fecha,
            tabla1.eje_x,
            (round(COALESCE(NULLIF((((tabla2.eje_y * 100))::numeric / (tabla1.eje_y)::numeric), NULL::numeric), '0'::numeric), 0))::character varying AS eje_y
           FROM (( SELECT dataset_testeo_turismo.fecha_muestra AS fecha,
                    dataset_testeo_turismo.fecha_muestra AS eje_x,
                    sum((dataset_testeo_turismo.n)::integer) AS eje_y
                   FROM public.dataset_testeo_turismo
                  WHERE ((((dataset_testeo_turismo.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '0-19'::text)) OR (((dataset_testeo_turismo.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '20-29'::text)))
                  GROUP BY dataset_testeo_turismo.fecha_muestra
                  ORDER BY dataset_testeo_turismo.fecha_muestra) tabla1
             LEFT JOIN ( SELECT dataset_testeo_turismo.fecha_muestra AS fecha,
                    dataset_testeo_turismo.fecha_muestra AS eje_x,
                    sum((dataset_testeo_turismo.n)::integer) AS eje_y
                   FROM public.dataset_testeo_turismo
                  WHERE ((((dataset_testeo_turismo.tipo)::text = 'positivos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '0-19'::text)) OR (((dataset_testeo_turismo.tipo)::text = 'positivos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '20-29'::text)))
                  GROUP BY dataset_testeo_turismo.fecha_muestra
                  ORDER BY dataset_testeo_turismo.fecha_muestra) tabla2 ON ((tabla1.fecha = tabla2.fecha)))) primer_grupo
     JOIN ( SELECT tabla1.fecha,
            tabla1.eje_x,
            (round(COALESCE(NULLIF((((tabla2.eje_y * 100))::numeric / (tabla1.eje_y)::numeric), NULL::numeric), '0'::numeric), 0))::character varying AS eje_y
           FROM (( SELECT dataset_testeo_turismo.fecha_muestra AS fecha,
                    dataset_testeo_turismo.fecha_muestra AS eje_x,
                    sum((dataset_testeo_turismo.n)::integer) AS eje_y
                   FROM public.dataset_testeo_turismo
                  WHERE ((((dataset_testeo_turismo.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '30-39'::text)) OR (((dataset_testeo_turismo.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '40-49'::text)) OR (((dataset_testeo_turismo.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '50-59'::text)))
                  GROUP BY dataset_testeo_turismo.fecha_muestra
                  ORDER BY dataset_testeo_turismo.fecha_muestra) tabla1
             LEFT JOIN ( SELECT dataset_testeo_turismo.fecha_muestra AS fecha,
                    dataset_testeo_turismo.fecha_muestra AS eje_x,
                    sum((dataset_testeo_turismo.n)::integer) AS eje_y
                   FROM public.dataset_testeo_turismo
                  WHERE ((((dataset_testeo_turismo.tipo)::text = 'positivos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '30-39'::text)) OR (((dataset_testeo_turismo.tipo)::text = 'positivos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '40-49'::text)) OR (((dataset_testeo_turismo.tipo)::text = 'positivos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '50-59'::text)))
                  GROUP BY dataset_testeo_turismo.fecha_muestra
                  ORDER BY dataset_testeo_turismo.fecha_muestra) tabla2 ON ((tabla1.fecha = tabla2.fecha)))) segundo_grupo ON ((segundo_grupo.fecha = primer_grupo.fecha)))
     JOIN ( SELECT tabla1.fecha,
            tabla1.eje_x,
            (round(COALESCE(NULLIF((((tabla2.eje_y * 100))::numeric / (tabla1.eje_y)::numeric), NULL::numeric), '0'::numeric), 0))::character varying AS eje_y
           FROM (( SELECT dataset_testeo_turismo.fecha_muestra AS fecha,
                    dataset_testeo_turismo.fecha_muestra AS eje_x,
                    sum((dataset_testeo_turismo.n)::integer) AS eje_y
                   FROM public.dataset_testeo_turismo
                  WHERE ((((dataset_testeo_turismo.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '60-69'::text)) OR (((dataset_testeo_turismo.tipo)::text = 'positivos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '70-79'::text)) OR (((dataset_testeo_turismo.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '80 y más'::text)))
                  GROUP BY dataset_testeo_turismo.fecha_muestra
                  ORDER BY dataset_testeo_turismo.fecha_muestra) tabla1
             LEFT JOIN ( SELECT dataset_testeo_turismo.fecha_muestra AS fecha,
                    dataset_testeo_turismo.fecha_muestra AS eje_x,
                    sum((dataset_testeo_turismo.n)::integer) AS eje_y
                   FROM public.dataset_testeo_turismo
                  WHERE ((((dataset_testeo_turismo.tipo)::text = 'positivos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '60-69'::text)) OR (((dataset_testeo_turismo.tipo)::text = 'positivos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '70-79'::text)) OR (((dataset_testeo_turismo.tipo)::text = 'positivos'::text) AND ((dataset_testeo_turismo.grupo_etario)::text = '80 y más'::text)))
                  GROUP BY dataset_testeo_turismo.fecha_muestra
                  ORDER BY dataset_testeo_turismo.fecha_muestra) tabla2 ON ((tabla1.fecha = tabla2.fecha)))) tercer_grupo ON ((primer_grupo.fecha = tercer_grupo.fecha)))
  ORDER BY tercer_grupo.fecha;


--
-- TOC entry 402 (class 1259 OID 295416)
-- Name: dataset_positivo_turista_genero; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivo_turista_genero AS
 SELECT 1 AS id,
    2 AS fecha,
        CASE
            WHEN ((dataset_testeo_turismo.genero)::text = 'F'::text) THEN 'femenino'::text
            WHEN ((dataset_testeo_turismo.genero)::text = 'M'::text) THEN 'masculino'::text
            ELSE NULL::text
        END AS eje_x,
    (sum(dataset_testeo_turismo.n))::integer AS eje_y
   FROM public.dataset_testeo_turismo
  WHERE ((dataset_testeo_turismo.tipo)::text = 'positivos'::text)
  GROUP BY dataset_testeo_turismo.genero
  ORDER BY dataset_testeo_turismo.genero;


--
-- TOC entry 355 (class 1259 OID 97282)
-- Name: dataset_positivos_acumulado_barrios_populares; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivos_acumulado_barrios_populares AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'barrios_vulnerables'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'casos_confirmados_acumulados'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 370 (class 1259 OID 102730)
-- Name: dataset_positivos_dia_barrios_populares; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivos_dia_barrios_populares AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'barrios_vulnerables'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'casos_confirmados_reportados_del_dia'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 600 (class 1259 OID 474248)
-- Name: dataset_positivos_dia_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivos_dia_docentes AS
 SELECT 1 AS id,
    dataset_web_covid.cat_fech_1 AS fecha,
    to_char((dataset_web_covid.cat_fech_1)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    dataset_web_covid.valor_2 AS eje_y
   FROM public.dataset_web_covid
  WHERE ((dataset_web_covid.id_1 = 9) AND (dataset_web_covid.id_2 = 51))
  ORDER BY dataset_web_covid.cat_fech_1;


--
-- TOC entry 350 (class 1259 OID 96445)
-- Name: dataset_positivos_no_residentes_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivos_no_residentes_acumulado AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_no_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'casos_confirmados_acumulados'::text))
  ORDER BY dataset_reporte_covid_sit_gob.fecha;


--
-- TOC entry 368 (class 1259 OID 102714)
-- Name: dataset_positivos_no_residentes_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivos_no_residentes_dia AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_no_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'casos_confirmados_reportados_del_dia'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 348 (class 1259 OID 96437)
-- Name: dataset_positivos_residentes_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivos_residentes_acumulado AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'casos_confirmados_acumulados'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 365 (class 1259 OID 102696)
-- Name: dataset_positivos_residentes_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivos_residentes_dia AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'casos_confirmados_reportados_del_dia'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 601 (class 1259 OID 474515)
-- Name: dataset_positivos_total_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_positivos_total_docentes AS
 SELECT 1 AS id,
    dataset_web_covid.fecha_act AS fecha,
    dataset_web_covid.valor_2
   FROM public.dataset_web_covid
  WHERE ((dataset_web_covid.id_1 = 9) AND (dataset_web_covid.id_2 = 28));


--
-- TOC entry 223 (class 1259 OID 50575)
-- Name: dataset_recursos_humanos_salud_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dataset_recursos_humanos_salud_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7746 (class 0 OID 0)
-- Dependencies: 223
-- Name: dataset_recursos_humanos_salud_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dataset_recursos_humanos_salud_id_seq OWNED BY public.dataset_recursos_humanos_salud.id;


--
-- TOC entry 221 (class 1259 OID 50541)
-- Name: dataset_repatriados_pais_procedencia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_repatriados_pais_procedencia (
    id integer NOT NULL,
    procedencia character varying,
    tipo_vehiculo character varying,
    n_personas character varying,
    n_vehiculos character varying
);


--
-- TOC entry 222 (class 1259 OID 50547)
-- Name: dataset_repatriados_pais; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_repatriados_pais AS
 SELECT 1 AS id,
    '2020-05-13'::date AS fecha,
    dataset_repatriados_pais_procedencia.procedencia AS eje_x,
    sum((dataset_repatriados_pais_procedencia.n_personas)::integer) AS eje_y
   FROM public.dataset_repatriados_pais_procedencia
  GROUP BY dataset_repatriados_pais_procedencia.procedencia
  ORDER BY (sum((dataset_repatriados_pais_procedencia.n_personas)::integer)) DESC;


--
-- TOC entry 224 (class 1259 OID 50577)
-- Name: dataset_repatriados_pais_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_repatriados_pais_acumulado AS
 SELECT 1 AS id,
    dataset_repatriados_pais.fecha,
    dataset_repatriados_pais.eje_x,
    (sum(dataset_repatriados_pais.eje_y) OVER (ORDER BY dataset_repatriados_pais.eje_x))::integer AS eje_y
   FROM public.dataset_repatriados_pais;


--
-- TOC entry 225 (class 1259 OID 50581)
-- Name: dataset_repatriados_pais_procedencia_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dataset_repatriados_pais_procedencia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7747 (class 0 OID 0)
-- Dependencies: 225
-- Name: dataset_repatriados_pais_procedencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dataset_repatriados_pais_procedencia_id_seq OWNED BY public.dataset_repatriados_pais_procedencia.id;


--
-- TOC entry 297 (class 1259 OID 84609)
-- Name: dataset_sisa_fallecidos_genero; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_fallecidos_genero AS
 SELECT 1 AS id,
    2 AS fecha,
    casos_covid19.genero AS eje_x,
    count(casos_covid19.numero_de_caso) AS eje_y
   FROM public.casos_covid19
  WHERE ((((casos_covid19."clasificación")::text = 'confirmado'::text) OR ((casos_covid19."clasificación")::text = 'negativizado'::text)) AND ((casos_covid19.fallecido)::text = 'si'::text) AND ((casos_covid19.provincia)::text = 'CABA'::text))
  GROUP BY casos_covid19.genero
  ORDER BY casos_covid19.genero;


--
-- TOC entry 587 (class 1259 OID 456455)
-- Name: dataset_sisa_hisopados_confirmados; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_hisopados_confirmados AS
 SELECT 1 AS id,
    to_date((casos_covid19.fecha_toma_muestra)::text, 'YYYY-MM-DD'::text) AS fecha,
    to_char((to_date((casos_covid19.fecha_toma_muestra)::text, 'YYYY-MM-DD'::text))::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (count(casos_covid19.numero_de_caso))::integer AS eje_y
   FROM public.casos_covid19
  WHERE ((((casos_covid19."clasificación")::text = 'confirmado'::text) OR ((casos_covid19."clasificación")::text = 'negativizado'::text)) AND ((casos_covid19.provincia)::text = 'CABA'::text) AND (casos_covid19.fecha_toma_muestra <= (( SELECT max(casos_covid19_1.fecha_toma_muestra) AS max
           FROM public.casos_covid19 casos_covid19_1) - '3 days'::interval day)) AND ((casos_covid19.fecha_toma_muestra)::text <> 'NA'::text) AND (casos_covid19.fecha_toma_muestra > '2020-03-03 00:00:00'::timestamp without time zone))
  GROUP BY casos_covid19.fecha_toma_muestra
  ORDER BY casos_covid19.fecha_toma_muestra;


--
-- TOC entry 311 (class 1259 OID 89342)
-- Name: dataset_sisa_hisopados_confirmados_bp; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_hisopados_confirmados_bp AS
 SELECT 1 AS id,
    to_date((casos_covid19.fecha_toma_muestra)::text, 'YYYY-MM-DD'::text) AS fecha,
    to_char((to_date((casos_covid19.fecha_toma_muestra)::text, 'YYYY-MM-DD'::text))::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (count(casos_covid19.numero_de_caso))::integer AS eje_y
   FROM public.casos_covid19
  WHERE ((((casos_covid19."clasificación")::text = 'confirmado'::text) OR ((casos_covid19."clasificación")::text = 'negativizado'::text)) AND ((casos_covid19.barrios_vulnerables_oficial)::text = 'si'::text) AND (casos_covid19.fecha_toma_muestra IS NOT NULL) AND (casos_covid19.fecha_toma_muestra <= (( SELECT max(casos_covid19_1.fecha_toma_muestra) AS max
           FROM public.casos_covid19 casos_covid19_1) - '3 days'::interval day)))
  GROUP BY casos_covid19.fecha_toma_muestra
  ORDER BY casos_covid19.fecha_toma_muestra;


--
-- TOC entry 381 (class 1259 OID 108520)
-- Name: dataset_sisa_hisopados_positivos_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_hisopados_positivos_acumulado AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    replace(concat((round(dataset_reporte_covid_sit_gob.valor, 1))::text, '%'), '.'::text, ','::text) AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'personas_hisopadas'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = '%_positividad_personas_hisopadas_acumulada_caba'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 380 (class 1259 OID 108516)
-- Name: dataset_sisa_hisopados_positivos_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_hisopados_positivos_dia AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    replace(concat((round(dataset_reporte_covid_sit_gob.valor, 1))::text, '%'), '.'::text, ','::text) AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'personas_hisopadas'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = '%_positividad_personas_hisopadas_reportados_del_dia_caba'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 386 (class 1259 OID 108577)
-- Name: dataset_sisa_hisopados_totales_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_hisopados_totales_acumulado AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'personas_hisopadas'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'personas_hisopadas_acumulados_caba'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 387 (class 1259 OID 108581)
-- Name: dataset_sisa_hisopados_totales_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_hisopados_totales_dia AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'personas_hisopadas'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'personas_hisopadas_reportados_del_dia_caba'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 385 (class 1259 OID 108553)
-- Name: dataset_sisa_letalidad; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_letalidad AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    replace(concat((round(dataset_reporte_covid_sit_gob.valor, 1))::text, '%'), '.'::text, ','::text) AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = '%_letalidad_acumulada'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 302 (class 1259 OID 86429)
-- Name: dataset_sisa_letalidad_rango_etario; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_letalidad_rango_etario AS
 SELECT 1 AS id,
    2 AS fecha,
    tbl.edad_2 AS eje_x,
    (tbl.eje_y)::integer AS eje_y,
    ((((tbl.eje_y2)::double precision / (tbl.eje_y)::real) * (100)::double precision))::integer AS eje_y2
   FROM ( SELECT dbplyr_064.edad_2,
            count(*) AS eje_y,
            count(
                CASE
                    WHEN ((dbplyr_064.fallecido)::text = 'si'::text) THEN dbplyr_064.fallecido
                    ELSE NULL::character varying
                END) AS eje_y2
           FROM ( SELECT casos_covid19.numero_de_caso,
                    casos_covid19.genero,
                    casos_covid19.edad,
                    casos_covid19.provincia,
                    casos_covid19.fecha_apertura_snvs,
                    casos_covid19."clasificación",
                    casos_covid19.fecha_clasificacion,
                    casos_covid19.fecha_toma_muestra,
                    casos_covid19.tipo_contagio,
                    casos_covid19.fecha_alta,
                    casos_covid19.fallecido,
                    casos_covid19.fecha_fallecimiento,
                    casos_covid19.barrio,
                    casos_covid19.comuna,
                        CASE
                            WHEN (casos_covid19.edad < 10.0) THEN '0-09'::text
                            WHEN (casos_covid19.edad < 20.0) THEN '10-19'::text
                            WHEN (casos_covid19.edad < 30.0) THEN '20-29'::text
                            WHEN (casos_covid19.edad < 40.0) THEN '30-39'::text
                            WHEN (casos_covid19.edad < 50.0) THEN '40-49'::text
                            WHEN (casos_covid19.edad < 60.0) THEN '50-59'::text
                            WHEN (casos_covid19.edad < 70.0) THEN '60-69'::text
                            WHEN (casos_covid19.edad < 80.0) THEN '70-79'::text
                            ELSE '80+'::text
                        END AS edad_2
                   FROM public.casos_covid19) dbplyr_064
          WHERE ((((dbplyr_064."clasificación")::text = 'confirmado'::text) OR ((dbplyr_064."clasificación")::text = 'negativizado'::text)) AND ((dbplyr_064.provincia)::text = 'CABA'::text))
          GROUP BY dbplyr_064.edad_2
          ORDER BY dbplyr_064.edad_2) tbl;


--
-- TOC entry 207 (class 1259 OID 34993)
-- Name: indicadores_covid19; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.indicadores_covid19 (
    fecha timestamp without time zone,
    positivos_acumulado numeric(14,0),
    positivos_dia numeric(14,0),
    positivos_residentes_acumulado numeric(14,0),
    positivos_residentes_dia numeric(14,0),
    altas_acumulado numeric(14,0),
    altas_dia numeric(14,0),
    fallecidos_acumulado numeric(14,0),
    fallecidos_dia numeric(14,0),
    hisopados_totales_acumulado numeric(14,0),
    hisopados_totales_dia numeric(14,0),
    hisopados_positivos_acumulado numeric(14,6),
    hisopados_positivos_dia numeric(14,6),
    positivos_dia_barrios_populares numeric(14,0),
    altas_dia_barrios_populares numeric(14,0),
    fallecidos_dia_barrios_populares numeric(14,0),
    positivos_acumulado_barrios_populares numeric(14,0),
    altas_acumulado_barrios_populares numeric(14,0),
    fallecidos_acumulado_barrios_populares numeric(14,0),
    letalidad_barrio_popular numeric(14,6),
    letalidad numeric(14,6),
    hisopados_acumulados_2 numeric(14,0),
    fallecidos_acumulados_residentes numeric(14,0),
    hisopados_acum_dos_dias numeric(14,0),
    confirmados_acum_dos_dias numeric(14,0),
    positivos_residentes_acumulados_menos_60 numeric(14,0),
    fallecidos_acumulado_res_60 numeric(14,0),
    tasa_fallecidos_60 numeric(14,6),
    tasa_positivos_menos_60 numeric(14,6),
    positivos_no_residentes_acumulado numeric(14,0),
    positivos_no_residentes_dia numeric(14,0),
    altas_residentes_acumulado numeric(14,0),
    altas_no_residentes_acumulado numeric(14,0),
    altas_residentes_dia numeric(14,0),
    altas_no_residentes_dia numeric(14,0),
    fallecidos_no_residentes_acumulado numeric(14,0),
    fallecidos_residentes_dia numeric(14,0),
    fallecidos_no_residentes_dia numeric(14,0),
    hisopados_totales_no_residentes_acumulado numeric(14,0),
    hisopados_totales_no_residentes_dia numeric(14,0),
    hisopados_totales_no_residentes_acumulado_2 numeric(14,0),
    hisopados_positivos_no_residentes numeric(14,6),
    confirmados_no_residentes_acum_dos_dias numeric(14,0),
    hisopados_no_residentes_acum_dos_dias numeric(14,0),
    hisopados_positivos_no_residentes_dia_2 numeric(14,6)
);


--
-- TOC entry 275 (class 1259 OID 54028)
-- Name: dataset_sisa_positivos_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_positivos_acumulado AS
 SELECT 1 AS id,
    (indicadores_covid19.fecha)::date AS fecha,
    to_char(indicadores_covid19.fecha, 'DD-MM'::text) AS eje_x,
    (indicadores_covid19.positivos_acumulado)::integer AS eje_y
   FROM public.indicadores_covid19
  ORDER BY indicadores_covid19.fecha;


--
-- TOC entry 298 (class 1259 OID 84617)
-- Name: dataset_sisa_positivos_genero; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_positivos_genero AS
 SELECT 1 AS id,
    2 AS fecha,
    casos_covid19.genero AS eje_x,
    count(casos_covid19.numero_de_caso) AS eje_y
   FROM public.casos_covid19
  WHERE ((((casos_covid19."clasificación")::text = 'confirmado'::text) OR ((casos_covid19."clasificación")::text = 'negativizado'::text)) AND ((casos_covid19.genero)::text <> 'NA'::text) AND ((casos_covid19.provincia)::text = 'CABA'::text))
  GROUP BY casos_covid19.genero
  ORDER BY casos_covid19.genero;


--
-- TOC entry 378 (class 1259 OID 108508)
-- Name: dataset_sisa_promedio_fallecidos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_promedio_fallecidos AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    round(dataset_reporte_covid_sit_gob.valor, 1) AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_por_grupo_etario'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'edad_promedio_de_fallecidos'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 276 (class 1259 OID 55246)
-- Name: dataset_sisa_total_por_rango_etario; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sisa_total_por_rango_etario AS
 SELECT 1 AS id,
    2 AS fecha,
    t.edad AS eje_x,
    count(*) AS eje_y
   FROM ( SELECT
                CASE
                    WHEN ((dataset_casos_sisa.edad >= 0) AND (dataset_casos_sisa.edad <= 9)) THEN '0-09'::text
                    WHEN ((dataset_casos_sisa.edad >= 10) AND (dataset_casos_sisa.edad <= 19)) THEN '10-19'::text
                    WHEN ((dataset_casos_sisa.edad >= 20) AND (dataset_casos_sisa.edad <= 29)) THEN '20-29'::text
                    WHEN ((dataset_casos_sisa.edad >= 30) AND (dataset_casos_sisa.edad <= 39)) THEN '30-39'::text
                    WHEN ((dataset_casos_sisa.edad >= 40) AND (dataset_casos_sisa.edad <= 49)) THEN '40-49'::text
                    WHEN ((dataset_casos_sisa.edad >= 50) AND (dataset_casos_sisa.edad <= 59)) THEN '50-59'::text
                    WHEN ((dataset_casos_sisa.edad >= 60) AND (dataset_casos_sisa.edad <= 69)) THEN '60-69'::text
                    WHEN ((dataset_casos_sisa.edad >= 70) AND (dataset_casos_sisa.edad <= 79)) THEN '70-79'::text
                    ELSE '80+'::text
                END AS edad
           FROM public.dataset_casos_sisa) t
  GROUP BY t.edad
  ORDER BY t.edad;


--
-- TOC entry 300 (class 1259 OID 86273)
-- Name: dataset_viajes_sube; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_viajes_sube (
    tipo_transporte character varying(255),
    dia timestamp without time zone,
    parcial character varying(255),
    cantidad numeric(12,0)
);


--
-- TOC entry 361 (class 1259 OID 101722)
-- Name: dataset_sube_colectivo_variacion_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sube_colectivo_variacion_dia AS
 WITH fecha AS (
         SELECT date_part('dow'::text, max((dataset_viajes_sube.dia - '2 days'::interval day))) AS date_part
           FROM public.dataset_viajes_sube
        )
 SELECT 1 AS id,
    ( SELECT (max((dataset_viajes_sube.dia - '2 days'::interval day)))::date AS max
           FROM public.dataset_viajes_sube) AS fecha,
        CASE
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (0)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Colectivo'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (1)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Colectivo'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (2)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Colectivo'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (3)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Colectivo'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (4)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Colectivo'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (5)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Colectivo'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (6)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Colectivo'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_colectivo)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            ELSE NULL::text
        END AS dato;


--
-- TOC entry 359 (class 1259 OID 101709)
-- Name: dataset_sube_ffcc_variacion_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sube_ffcc_variacion_dia AS
 WITH fecha AS (
         SELECT date_part('dow'::text, max((dataset_viajes_sube.dia - '2 days'::interval day))) AS date_part
           FROM public.dataset_viajes_sube
        )
 SELECT 1 AS id,
    ( SELECT (max((dataset_viajes_sube.dia - '2 days'::interval day)))::date AS max
           FROM public.dataset_viajes_sube) AS fecha,
        CASE
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (0)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_tren)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_tren)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (1)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_tren)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_tren)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (2)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_tren)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_tren)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (3)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_tren)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_tren)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (4)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_tren)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_tren)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (5)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_tren)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_tren)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (6)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_tren)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_tren)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            ELSE NULL::text
        END AS dato;


--
-- TOC entry 360 (class 1259 OID 101714)
-- Name: dataset_sube_subte_variacion_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_sube_subte_variacion_dia AS
 WITH fecha AS (
         SELECT date_part('dow'::text, max((dataset_viajes_sube.dia - '2 days'::interval day))) AS date_part
           FROM public.dataset_viajes_sube
        )
 SELECT 1 AS id,
    ( SELECT (max((dataset_viajes_sube.dia - '2 days'::interval day)))::date AS max
           FROM public.dataset_viajes_sube) AS fecha,
        CASE
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (0)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_subte)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_subte)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-15'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (1)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_subte)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_subte)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-09'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (2)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_subte)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_subte)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-10'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (3)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_subte)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_subte)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-11'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (4)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_subte)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_subte)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-12'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (5)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_subte)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_subte)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-13'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            WHEN (( SELECT fecha.date_part
               FROM fecha) = (6)::double precision) THEN replace(concat(((((((( SELECT (d.cantidad)::integer AS sum
               FROM public.dataset_viajes_sube d
              WHERE (((d.tipo_transporte)::text = 'Tren'::text) AND (d.dia = (( SELECT max(dataset_viajes_sube_1.dia) AS max
                       FROM public.dataset_viajes_sube dataset_viajes_sube_1) - '2 days'::interval day)))
              ORDER BY d.dia DESC
             LIMIT 1))::numeric - (( SELECT (dataset_movilidad.ntrx_subte)::integer AS valor
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) / (( SELECT (dataset_movilidad.ntrx_subte)::integer AS avg
               FROM public.dataset_movilidad
              WHERE (to_date((dataset_movilidad.fecha)::text, 'DD/MM/YYYY'::text) = '2020-03-14'::date)))::numeric) * (100)::numeric))::integer)::text, '%'), '.'::text, ','::text)
            ELSE NULL::text
        END AS dato;


--
-- TOC entry 219 (class 1259 OID 50514)
-- Name: dataset_sube_ultimo_mes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_sube_ultimo_mes (
    id integer NOT NULL,
    tipo_transporte character varying,
    dia character varying,
    parcial character varying,
    cantidad character varying
);


--
-- TOC entry 226 (class 1259 OID 50626)
-- Name: dataset_sube_ultimo_mes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dataset_sube_ultimo_mes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7748 (class 0 OID 0)
-- Dependencies: 226
-- Name: dataset_sube_ultimo_mes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dataset_sube_ultimo_mes_id_seq OWNED BY public.dataset_sube_ultimo_mes.id;


--
-- TOC entry 384 (class 1259 OID 108549)
-- Name: dataset_tasa_fallecidos_60; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_tasa_fallecidos_60 AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    replace(concat((round(dataset_reporte_covid_sit_gob.valor, 1))::text, '%'), '.'::text, ','::text) AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_por_grupo_etario'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = '%_fallecidos_positivos_mayores_a_60_anos'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 605 (class 1259 OID 482883)
-- Name: dataset_tasa_positividad_antigenos_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_tasa_positividad_antigenos_docentes AS
 SELECT 1 AS id,
    dataset_web_covid.fecha_act AS fecha,
    dataset_web_covid.cat_str_1 AS eje_y
   FROM public.dataset_web_covid
  WHERE ((dataset_web_covid.id_1 = 9) AND (dataset_web_covid.id_2 = 15));


--
-- TOC entry 603 (class 1259 OID 481797)
-- Name: dataset_tasa_positividad_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_tasa_positividad_docentes AS
 SELECT 1 AS id,
    dataset_web_covid.fecha_act AS fecha,
    dataset_web_covid.cat_str_1 AS eje_y
   FROM public.dataset_web_covid
  WHERE ((dataset_web_covid.id_1 = 9) AND (dataset_web_covid.id_2 = 11));


--
-- TOC entry 604 (class 1259 OID 481805)
-- Name: dataset_tasa_positividad_pcr_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_tasa_positividad_pcr_docentes AS
 SELECT 1 AS id,
    dataset_web_covid.fecha_act AS fecha,
    dataset_web_covid.cat_str_1 AS eje_y
   FROM public.dataset_web_covid
  WHERE ((dataset_web_covid.id_1 = 9) AND (dataset_web_covid.id_2 = 13));


--
-- TOC entry 517 (class 1259 OID 313437)
-- Name: dataset_tasa_positivos_menos_60; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_tasa_positivos_menos_60 AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    round(dataset_reporte_covid_sit_gob.valor, 1) AS eje_y
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_por_grupo_etario'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = '%_positivos_entre_0_y_59_anos'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 227 (class 1259 OID 50633)
-- Name: dataset_test_promedio; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_test_promedio AS
 SELECT 1 AS id,
    to_date('20200622'::text, 'YYYYMMDD'::text) AS fecha,
    '15%'::text AS dato;


--
-- TOC entry 397 (class 1259 OID 270546)
-- Name: dataset_test_vista; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_test_vista AS
 SELECT 1 AS id,
    ( SELECT dataset_reporte_covid_sit_gob.fecha
           FROM public.dataset_reporte_covid_sit_gob
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1) AS fecha,
    concat((round(((( SELECT dataset_reporte_covid_sit_gob.valor
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'ocupacion_de_camas_sistema_publico'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'moderados'::text))
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1) / ( SELECT dataset_reporte_covid_sit_gob.valor
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'total_de_camas_sistema_publico'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'moderados'::text))
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 1)) * (100)::numeric), 2))::text, '%') AS dato;


--
-- TOC entry 570 (class 1259 OID 400379)
-- Name: dataset_testeo_turismo_carretera; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turismo_carretera AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Asociación Corredores Turismo Carretera'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 404 (class 1259 OID 295441)
-- Name: dataset_testeo_turista_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_acumulado AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    to_char((dataset_testeo_turismo.fecha_muestra)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE ((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text)) AS eje_y
   FROM public.dataset_testeo_turismo
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 494 (class 1259 OID 303314)
-- Name: dataset_testeo_turista_acumulado_callao_usam; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_acumulado_callao_usam AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    to_char((dataset_testeo_turismo.fecha_muestra)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'Callao | USAM'::text))) AS sum
   FROM public.dataset_testeo_turismo
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 450 (class 1259 OID 298607)
-- Name: dataset_testeo_turista_acumulado_cec; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_acumulado_cec AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    to_char((dataset_testeo_turismo.fecha_muestra)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'CEC'::text))) AS sum
   FROM public.dataset_testeo_turismo
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 492 (class 1259 OID 303304)
-- Name: dataset_testeo_turista_acumulado_costa_salguero; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_acumulado_costa_salguero AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    to_char((dataset_testeo_turismo.fecha_muestra)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'Costa Salguero'::text))) AS sum
   FROM public.dataset_testeo_turismo
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 493 (class 1259 OID 303309)
-- Name: dataset_testeo_turista_acumulado_edificio_munich; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_acumulado_edificio_munich AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    to_char((dataset_testeo_turismo.fecha_muestra)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'Edificio Munich'::text))) AS sum
   FROM public.dataset_testeo_turismo
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 449 (class 1259 OID 298599)
-- Name: dataset_testeo_turista_acumulado_san_lorenzo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_acumulado_san_lorenzo AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    to_char((dataset_testeo_turismo.fecha_muestra)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'Club San Lorenzo'::text))) AS sum
   FROM public.dataset_testeo_turismo
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 560 (class 1259 OID 366546)
-- Name: dataset_testeo_turista_aeroparque; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_aeroparque AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    (sum(dataset_testeo_turismo.n))::integer AS valor1,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'Aeroparque'::text))) AS valor2
   FROM public.dataset_testeo_turismo
  WHERE (((dataset_testeo_turismo.dispositivo)::text = 'Aeroparque'::text) AND ((dataset_testeo_turismo.tipo)::text = 'testeos'::text))
  GROUP BY dataset_testeo_turismo.fecha_muestra
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 411 (class 1259 OID 295503)
-- Name: dataset_testeo_turista_callao_usam; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_callao_usam AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    (sum(dataset_testeo_turismo.n))::integer AS valor1,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'Callao | USAM'::text))) AS valor2
   FROM public.dataset_testeo_turismo
  WHERE (((dataset_testeo_turismo.dispositivo)::text = 'Callao | USAM'::text) AND ((dataset_testeo_turismo.tipo)::text = 'testeos'::text))
  GROUP BY dataset_testeo_turismo.fecha_muestra
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 408 (class 1259 OID 295489)
-- Name: dataset_testeo_turista_costa_salguero; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_costa_salguero AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    (sum(dataset_testeo_turismo.n))::integer AS valor1,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'Costa Salguero'::text))) AS valor2
   FROM public.dataset_testeo_turismo
  WHERE (((dataset_testeo_turismo.dispositivo)::text = 'Costa Salguero'::text) AND ((dataset_testeo_turismo.tipo)::text = 'testeos'::text))
  GROUP BY dataset_testeo_turismo.fecha_muestra
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 409 (class 1259 OID 295494)
-- Name: dataset_testeo_turista_dellepiane; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_dellepiane AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    (sum(dataset_testeo_turismo.n))::integer AS valor1,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'Terminal Dellepiane'::text))) AS valor2
   FROM public.dataset_testeo_turismo
  WHERE (((dataset_testeo_turismo.dispositivo)::text = 'Terminal Dellepiane'::text) AND ((dataset_testeo_turismo.tipo)::text = 'testeos'::text))
  GROUP BY dataset_testeo_turismo.fecha_muestra
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 403 (class 1259 OID 295433)
-- Name: dataset_testeo_turista_diario; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_diario AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_testeo_turismo.fecha_muestra AS fecha,
            to_char((dataset_testeo_turismo.fecha_muestra)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (sum(dataset_testeo_turismo.n))::integer AS eje_y
           FROM public.dataset_testeo_turismo
          WHERE ((dataset_testeo_turismo.tipo)::text = 'testeos'::text)
          GROUP BY dataset_testeo_turismo.fecha_muestra
          ORDER BY dataset_testeo_turismo.fecha_muestra DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 406 (class 1259 OID 295480)
-- Name: dataset_testeo_turista_edificio_munich; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_edificio_munich AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    (sum(dataset_testeo_turismo.n))::integer AS valor1,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'Edificio Munich'::text))) AS valor2
   FROM public.dataset_testeo_turismo
  WHERE (((dataset_testeo_turismo.dispositivo)::text = 'Edificio Munich'::text) AND ((dataset_testeo_turismo.tipo)::text = 'testeos'::text))
  GROUP BY dataset_testeo_turismo.fecha_muestra
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 410 (class 1259 OID 295499)
-- Name: dataset_testeo_turista_ezeiza; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_ezeiza AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    (sum(dataset_testeo_turismo.n))::integer AS valor1,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'Ezeiza'::text))) AS valor2
   FROM public.dataset_testeo_turismo
  WHERE (((dataset_testeo_turismo.dispositivo)::text = 'Ezeiza'::text) AND ((dataset_testeo_turismo.tipo)::text = 'testeos'::text))
  GROUP BY dataset_testeo_turismo.fecha_muestra
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 412 (class 1259 OID 295511)
-- Name: dataset_testeo_turista_figueroa_alcorta; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_figueroa_alcorta AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    (sum(dataset_testeo_turismo.n))::integer AS valor1,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'CEC'::text))) AS valor2
   FROM public.dataset_testeo_turismo
  WHERE (((dataset_testeo_turismo.dispositivo)::text = 'CEC'::text) AND ((dataset_testeo_turismo.tipo)::text = 'testeos'::text))
  GROUP BY dataset_testeo_turismo.fecha_muestra
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 567 (class 1259 OID 393440)
-- Name: dataset_testeo_turista_genero; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_genero AS
 SELECT 1 AS id,
    2 AS fecha,
    gender.eje_x,
    gender.eje_y
   FROM ( SELECT
                CASE
                    WHEN ((dataset_testeo_turismo.genero)::text = 'F'::text) THEN 'femenino'::text
                    WHEN ((dataset_testeo_turismo.genero)::text = 'M'::text) THEN 'masculino'::text
                    ELSE NULL::text
                END AS eje_x,
            (sum(dataset_testeo_turismo.n))::integer AS eje_y
           FROM public.dataset_testeo_turismo
          WHERE ((dataset_testeo_turismo.tipo)::text = 'testeos'::text)
          GROUP BY dataset_testeo_turismo.genero
          ORDER BY dataset_testeo_turismo.genero) gender
  WHERE (gender.eje_x IS NOT NULL);


--
-- TOC entry 407 (class 1259 OID 295485)
-- Name: dataset_testeo_turista_la_rural; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeo_turista_la_rural AS
 SELECT 1 AS id,
    dataset_testeo_turismo.fecha_muestra AS fecha,
    (sum(dataset_testeo_turismo.n))::integer AS valor1,
    ( SELECT (sum(dataset_testeo_turismo_1.n))::integer AS sum
           FROM public.dataset_testeo_turismo dataset_testeo_turismo_1
          WHERE (((dataset_testeo_turismo_1.tipo)::text = 'testeos'::text) AND ((dataset_testeo_turismo_1.dispositivo)::text = 'La Rural'::text))) AS valor2
   FROM public.dataset_testeo_turismo
  WHERE (((dataset_testeo_turismo.dispositivo)::text = 'La Rural'::text) AND ((dataset_testeo_turismo.tipo)::text = 'testeos'::text))
  GROUP BY dataset_testeo_turismo.fecha_muestra
  ORDER BY dataset_testeo_turismo.fecha_muestra DESC
 LIMIT 1;


--
-- TOC entry 563 (class 1259 OID 373660)
-- Name: reporte_covid_sit_gob_total; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reporte_covid_sit_gob_total (
    fecha date,
    tipo_reporte character varying(255),
    tipo_dato character varying(255),
    subtipo_dato character varying(255),
    valor numeric,
    diferencia integer
);


--
-- TOC entry 585 (class 1259 OID 422981)
-- Name: dataset_testeos_dia_anterior; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeos_dia_anterior AS
 SELECT 1 AS id,
    reporte_covid_sit_gob_total.fecha,
    (sum(reporte_covid_sit_gob_total.diferencia))::integer AS sum
   FROM public.reporte_covid_sit_gob_total
  GROUP BY reporte_covid_sit_gob_total.fecha;


--
-- TOC entry 596 (class 1259 OID 472564)
-- Name: dataset_testeos_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeos_docentes AS
 SELECT 1 AS id,
    dataset_web_covid.fecha_act AS fecha,
    dataset_web_covid.valor_1
   FROM public.dataset_web_covid
  WHERE ((dataset_web_covid.id_1 = 9) AND (dataset_web_covid.id_2 = 5));


--
-- TOC entry 584 (class 1259 OID 422945)
-- Name: dataset_testeos_totales; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_testeos_totales AS
 SELECT 1 AS id,
    reporte_covid_sit_gob_total.fecha,
    (sum(reporte_covid_sit_gob_total.valor))::integer AS sum
   FROM public.reporte_covid_sit_gob_total
  GROUP BY reporte_covid_sit_gob_total.fecha;


--
-- TOC entry 597 (class 1259 OID 472763)
-- Name: dataset_total_antigenos_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_total_antigenos_docentes AS
 SELECT 1 AS id,
    dataset_web_covid.fecha_act AS fecha,
    dataset_web_covid.valor_1
   FROM public.dataset_web_covid
  WHERE ((dataset_web_covid.id_1 = 9) AND (dataset_web_covid.id_2 = 10));


--
-- TOC entry 598 (class 1259 OID 473511)
-- Name: dataset_total_pcd_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_total_pcd_docentes AS
 SELECT 1 AS id,
    dataset_web_covid.fecha_act AS fecha,
    dataset_web_covid.valor_1
   FROM public.dataset_web_covid
  WHERE ((dataset_web_covid.id_1 = 9) AND (dataset_web_covid.id_2 = 9));


--
-- TOC entry 343 (class 1259 OID 96163)
-- Name: dataset_tr_realizados_acumulados_centros_salud; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_tr_realizados_acumulados_centros_salud AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'tr_en_centros_de_salud_hospitales_cesacs_cemar_e_irep'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'tr_realizados_acumulados'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, ((dataset_reporte_covid_sit_gob.valor)::integer)
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 340 (class 1259 OID 94554)
-- Name: dataset_tr_realizados_acumulados_geriatricos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_tr_realizados_acumulados_geriatricos AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'tr_en_geriatricos'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'tr_realizados_acumulados'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, ((dataset_reporte_covid_sit_gob.valor)::integer)
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 344 (class 1259 OID 96170)
-- Name: dataset_tr_realizados_acumulados_positivos_centros_salud; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_tr_realizados_acumulados_positivos_centros_salud AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'tr_en_centros_de_salud_hospitales_cesacs_cemar_e_irep'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'tr_realizados_acumulados_positivos'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, ((dataset_reporte_covid_sit_gob.valor)::integer)
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 339 (class 1259 OID 94550)
-- Name: dataset_tr_realizados_acumulados_positivos_geriatricos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_tr_realizados_acumulados_positivos_geriatricos AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'tr_en_geriatricos'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'tr_realizados_acumulados_positivos'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, ((dataset_reporte_covid_sit_gob.valor)::integer)
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 345 (class 1259 OID 96178)
-- Name: dataset_tr_realizados_pos_rep_dia_centros_salud; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_tr_realizados_pos_rep_dia_centros_salud AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'tr_en_centros_de_salud_hospitales_cesacs_cemar_e_irep'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'tr_realizados_positivos_reportados_del_dia'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, ((dataset_reporte_covid_sit_gob.valor)::integer)
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 338 (class 1259 OID 94542)
-- Name: dataset_tr_realizados_pos_reportados_dia_geriatricos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_tr_realizados_pos_reportados_dia_geriatricos AS
 SELECT 1 AS id,
    dataset_reporte_covid_sit_gob.fecha,
    (dataset_reporte_covid_sit_gob.valor)::integer AS dato
   FROM public.dataset_reporte_covid_sit_gob
  WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'tr_en_geriatricos'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'tr_realizados_positivos_reportados_del_dia'::text))
  GROUP BY dataset_reporte_covid_sit_gob.fecha, ((dataset_reporte_covid_sit_gob.valor)::integer)
  ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
 LIMIT 1;


--
-- TOC entry 580 (class 1259 OID 417122)
-- Name: dataset_turno_agrupado_por_dia_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turno_agrupado_por_dia_docentes AS
 SELECT 1 AS id,
    dosis.fecha,
    dosis.eje_x,
    (sum(dosis.eje_y))::integer AS eje_y,
    (sum(dosis.eje_y2))::integer AS eje_y2
   FROM ( SELECT (dataset_turnos_detalle.fecha_cita)::date AS fecha,
            to_char(dataset_turnos_detalle.fecha_cita, 'DD-MM'::text) AS eje_x,
                CASE
                    WHEN ((dataset_turnos_detalle.componente)::text = 'Primera Dosis'::text) THEN sum(1)
                    ELSE sum(0)
                END AS eje_y,
                CASE
                    WHEN ((dataset_turnos_detalle.componente)::text = 'Segunda Dosis'::text) THEN sum(1)
                    ELSE sum(0)
                END AS eje_y2
           FROM public.dataset_turnos_detalle
          WHERE (((dataset_turnos_detalle.servicio)::text ~~ 'Docentes y No Docentes'::text) OR ((dataset_turnos_detalle.servicio)::text ~~ 'Personal estratégico Desarrollo Humano'::text) OR ((dataset_turnos_detalle.servicio)::text ~~ 'Personal estratégico Seguridad'::text))
          GROUP BY ((dataset_turnos_detalle.fecha_cita)::date), (to_char(dataset_turnos_detalle.fecha_cita, 'DD-MM'::text)), dataset_turnos_detalle.componente) dosis
  GROUP BY 1::integer, dosis.fecha, dosis.eje_x
  ORDER BY dosis.fecha;


--
-- TOC entry 579 (class 1259 OID 417068)
-- Name: dataset_turno_agrupado_por_dia_salud; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turno_agrupado_por_dia_salud AS
 SELECT 1 AS id,
    dosis.fecha,
    dosis.eje_x,
    (sum(dosis.eje_y))::integer AS eje_y,
    (sum(dosis.eje_y2))::integer AS eje_y2
   FROM ( SELECT (dataset_turnos_detalle.fecha_cita)::date AS fecha,
            to_char(dataset_turnos_detalle.fecha_cita, 'DD-MM'::text) AS eje_x,
                CASE
                    WHEN ((dataset_turnos_detalle.componente)::text = 'Primera Dosis'::text) THEN sum(1)
                    ELSE sum(0)
                END AS eje_y,
                CASE
                    WHEN ((dataset_turnos_detalle.componente)::text = 'Segunda Dosis'::text) THEN sum(1)
                    ELSE sum(0)
                END AS eje_y2
           FROM public.dataset_turnos_detalle
          WHERE ((dataset_turnos_detalle.servicio)::text ~~ '%Salud%'::text)
          GROUP BY ((dataset_turnos_detalle.fecha_cita)::date), (to_char(dataset_turnos_detalle.fecha_cita, 'DD-MM'::text)), dataset_turnos_detalle.componente) dosis
  GROUP BY 1::integer, dosis.fecha, dosis.eje_x
  ORDER BY dosis.fecha;


--
-- TOC entry 565 (class 1259 OID 389422)
-- Name: dataset_turno_agrupado_por_sexo_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turno_agrupado_por_sexo_docentes AS
 SELECT 1 AS id,
    2 AS fecha,
        CASE
            WHEN ((dataset_turnos_detalle.genero)::text = 'FEMENINO'::text) THEN 'femenino'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'MASCULINO'::text) THEN 'masculino'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'OTROS'::text) THEN 'otros'::text
            ELSE NULL::text
        END AS eje_x,
    (count(dataset_turnos_detalle.nro_cita))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE (((dataset_turnos_detalle.servicio)::text ~~ 'Docentes y No Docentes'::text) OR ((dataset_turnos_detalle.servicio)::text ~~ 'Personal estratégico Desarrollo Humano'::text) OR ((dataset_turnos_detalle.servicio)::text ~~ 'Personal estratégico Seguridad'::text))
  GROUP BY dataset_turnos_detalle.genero
  ORDER BY dataset_turnos_detalle.genero;


--
-- TOC entry 557 (class 1259 OID 361942)
-- Name: dataset_turno_agrupado_por_sexo_mayores_80; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turno_agrupado_por_sexo_mayores_80 AS
 SELECT 1 AS id,
    2 AS fecha,
        CASE
            WHEN ((dataset_turnos_detalle.genero)::text = 'FEMENINO'::text) THEN 'femenino'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'MASCULINO'::text) THEN 'masculino'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'OTROS'::text) THEN 'otros'::text
            ELSE NULL::text
        END AS eje_x,
    (count(dataset_turnos_detalle.nro_cita))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE ((dataset_turnos_detalle.servicio)::text ~~ '%Adultos Mayores de %'::text)
  GROUP BY dataset_turnos_detalle.genero
  ORDER BY dataset_turnos_detalle.genero;


--
-- TOC entry 499 (class 1259 OID 310145)
-- Name: dataset_turno_agrupado_por_sexo_salud; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turno_agrupado_por_sexo_salud AS
 SELECT 1 AS id,
    2 AS fecha,
        CASE
            WHEN ((dataset_turnos_detalle.genero)::text = 'FEMENINO'::text) THEN 'femenino'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'MASCULINO'::text) THEN 'masculino'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'OTROS'::text) THEN 'otros'::text
            ELSE NULL::text
        END AS eje_x,
    (count(dataset_turnos_detalle.nro_cita))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE ((dataset_turnos_detalle.servicio)::text ~~ '%Salud%'::text)
  GROUP BY dataset_turnos_detalle.genero
  ORDER BY dataset_turnos_detalle.genero;


--
-- TOC entry 558 (class 1259 OID 364759)
-- Name: dataset_turno_asignado_mayores_80; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turno_asignado_mayores_80 AS
 SELECT 1 AS id,
    dataset_turnos_detalle.fecha_solicitud AS fecha,
    to_char(dataset_turnos_detalle.fecha_solicitud, 'DD-MM'::text) AS eje_x,
    ( SELECT (count(dataset_turnos_detalle_1.nro_cita))::integer AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.servicio)::text ~~ '%Adultos Mayores de%'::text)) AS eje_y
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 566 (class 1259 OID 389433)
-- Name: dataset_turno_docentes_por_edad; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turno_docentes_por_edad AS
 SELECT 1 AS id,
    2 AS fecha,
    dataset_turnos_detalle.edad AS eje_x,
    (count(dataset_turnos_detalle.nro_cita))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE ((((dataset_turnos_detalle.servicio)::text ~~ 'Docentes y No Docentes'::text) AND (dataset_turnos_detalle.edad IS NOT NULL) AND (dataset_turnos_detalle.edad >= 18) AND (dataset_turnos_detalle.edad <= 105)) OR (((dataset_turnos_detalle.servicio)::text ~~ 'Personal estratégico Desarrollo Humano'::text) AND (dataset_turnos_detalle.edad IS NOT NULL) AND (dataset_turnos_detalle.edad >= 18) AND (dataset_turnos_detalle.edad <= 105)) OR (((dataset_turnos_detalle.servicio)::text ~~ 'Personal estratégico Seguridad'::text) AND (dataset_turnos_detalle.edad IS NOT NULL) AND (dataset_turnos_detalle.edad >= 18) AND (dataset_turnos_detalle.edad <= 105)))
  GROUP BY dataset_turnos_detalle.edad
  ORDER BY dataset_turnos_detalle.edad;


--
-- TOC entry 559 (class 1259 OID 364772)
-- Name: dataset_turno_por_edad; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turno_por_edad AS
 SELECT 1 AS id,
    2 AS fecha,
    dataset_turnos_detalle.edad AS eje_x,
    (count(dataset_turnos_detalle.nro_cita))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE (((dataset_turnos_detalle.servicio)::text ~~ '%Adultos Mayores de %'::text) AND (dataset_turnos_detalle.edad IS NOT NULL) AND (dataset_turnos_detalle.edad >= 60) AND (dataset_turnos_detalle.edad < 105))
  GROUP BY dataset_turnos_detalle.edad
  ORDER BY dataset_turnos_detalle.edad;


--
-- TOC entry 556 (class 1259 OID 361918)
-- Name: dataset_turnos_concurridos_y_citas_adultos_mayores_80_anios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turnos_concurridos_y_citas_adultos_mayores_80_anios AS
 SELECT 1 AS id,
    tabla1.fecha_cita AS fecha,
    to_char((tabla1.fecha_cita)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (COALESCE(NULLIF(tabla1.cantidad, NULL::numeric), '0'::numeric))::integer AS eje_y
   FROM ( SELECT tcp.fecha_cita,
            sum(tcp.cantidad) AS cantidad
           FROM ( SELECT (dtd.fecha_cita)::date AS fecha_cita,
                    count(*) AS cantidad,
                    dtd.estado
                   FROM public.dataset_turnos_detalle dtd
                  WHERE ((dtd.servicio)::text ~~ '%Adultos Mayores de%'::text)
                  GROUP BY dtd.fecha_cita, dtd.estado, dtd.servicio) tcp
          GROUP BY tcp.fecha_cita) tabla1
  ORDER BY tabla1.fecha_cita;


--
-- TOC entry 497 (class 1259 OID 305681)
-- Name: dataset_turnos_concurridos_y_citas_del_personal_de_salud; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turnos_concurridos_y_citas_del_personal_de_salud AS
 SELECT 1 AS id,
    tabla1.fecha_cita AS fecha,
    to_char((tabla1.fecha_cita)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (COALESCE(NULLIF(tabla1.cantidad, NULL::numeric), '0'::numeric))::integer AS eje_y
   FROM ( SELECT tcp.fecha_cita,
            sum(tcp.cantidad) AS cantidad
           FROM ( SELECT (dtd.fecha_cita)::date AS fecha_cita,
                    count(*) AS cantidad,
                    dtd.estado
                   FROM public.dataset_turnos_detalle dtd
                  WHERE ((dtd.servicio)::text !~~ '%Mayores 80 años%'::text)
                  GROUP BY dtd.fecha_cita, dtd.estado, dtd.servicio) tcp
          GROUP BY tcp.fecha_cita) tabla1
  ORDER BY tabla1.fecha_cita;


--
-- TOC entry 553 (class 1259 OID 350757)
-- Name: dataset_turnos_concurridos_y_citas_totales; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turnos_concurridos_y_citas_totales AS
 SELECT 1 AS id,
    tabla1.fecha_cita AS fecha,
    to_char((tabla1.fecha_cita)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (COALESCE(NULLIF(tabla1.cantidad, NULL::numeric), '0'::numeric))::integer AS eje_y
   FROM ( SELECT tcp.fecha_cita,
            sum(tcp.cantidad) AS cantidad
           FROM ( SELECT (dtd.fecha_cita)::date AS fecha_cita,
                    count(*) AS cantidad,
                    dtd.estado
                   FROM public.dataset_turnos_detalle dtd
                  WHERE ((dtd.servicio)::text !~~ '%PAMI'::text)
                  GROUP BY dtd.fecha_cita, dtd.estado, dtd.servicio) tcp
          GROUP BY tcp.fecha_cita) tabla1
  ORDER BY tabla1.fecha_cita;


--
-- TOC entry 552 (class 1259 OID 350744)
-- Name: dataset_turnos_genero_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turnos_genero_total AS
 SELECT 1 AS id,
    2 AS fecha,
        CASE
            WHEN ((dataset_turnos_detalle.genero)::text = 'FEMENINO'::text) THEN 'femenino'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'OTROS'::text) THEN 'otro'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'MASCULINO'::text) THEN 'masculino'::text
            ELSE NULL::text
        END AS eje_x,
    (count(dataset_turnos_detalle.genero))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE ((dataset_turnos_detalle.servicio)::text !~~ '%PAMI'::text)
  GROUP BY dataset_turnos_detalle.genero
  ORDER BY dataset_turnos_detalle.genero;


--
-- TOC entry 417 (class 1259 OID 296329)
-- Name: dataset_turnos_lista_espera; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_turnos_lista_espera (
    fecha date,
    n integer,
    estrategia character varying
);


--
-- TOC entry 544 (class 1259 OID 336594)
-- Name: dataset_turnos_lista_espera_edu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_turnos_lista_espera_edu (
    fecha date,
    estrategia character varying(255),
    cantidad integer
);


--
-- TOC entry 588 (class 1259 OID 463251)
-- Name: dataset_turnos_pob_gral; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turnos_pob_gral AS
 SELECT 1 AS id,
    dataset_turnos_detalle.fecha_solicitud AS fecha,
    to_char(dataset_turnos_detalle.fecha_solicitud, 'DD-MM'::text) AS eje_x,
    ( SELECT (count(dataset_turnos_detalle_1.nro_cita))::integer AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.servicio)::text = 'Adultos Mayores de 18 años'::text) OR ((dataset_turnos_detalle_1.servicio)::text = 'Menores de 18 años'::text))) AS eje_y
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 589 (class 1259 OID 463256)
-- Name: dataset_turnos_pob_gral_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turnos_pob_gral_dia AS
 SELECT 1 AS id,
    dosis.fecha,
    dosis.eje_x,
    (sum(dosis.eje_y))::integer AS eje_y,
    (sum(dosis.eje_y2))::integer AS eje_y2
   FROM ( SELECT (dataset_turnos_detalle.fecha_cita)::date AS fecha,
            to_char(dataset_turnos_detalle.fecha_cita, 'DD-MM'::text) AS eje_x,
                CASE
                    WHEN ((dataset_turnos_detalle.componente)::text = 'Primera Dosis'::text) THEN sum(1)
                    ELSE sum(0)
                END AS eje_y,
                CASE
                    WHEN ((dataset_turnos_detalle.componente)::text = 'Segunda Dosis'::text) THEN sum(1)
                    ELSE sum(0)
                END AS eje_y2
           FROM public.dataset_turnos_detalle
          WHERE (((dataset_turnos_detalle.servicio)::text = 'Adultos Mayores de 18 años'::text) OR ((dataset_turnos_detalle.servicio)::text = 'Menores de 18 años'::text))
          GROUP BY ((dataset_turnos_detalle.fecha_cita)::date), (to_char(dataset_turnos_detalle.fecha_cita, 'DD-MM'::text)), dataset_turnos_detalle.componente) dosis
  GROUP BY 1::integer, dosis.fecha, dosis.eje_x
  ORDER BY dosis.fecha;


--
-- TOC entry 590 (class 1259 OID 463267)
-- Name: dataset_turnos_pob_gral_edad; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turnos_pob_gral_edad AS
 SELECT 1 AS id,
    2 AS fecha,
    dataset_turnos_detalle.edad AS eje_x,
    (count(dataset_turnos_detalle.nro_cita))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE ((((dataset_turnos_detalle.servicio)::text ~~ 'Adultos Menores de 60 años sin condiciones de riesgo'::text) AND (dataset_turnos_detalle.edad IS NOT NULL) AND (dataset_turnos_detalle.edad >= 18) AND (dataset_turnos_detalle.edad <= 105)) OR (((dataset_turnos_detalle.servicio)::text ~~ 'Adultos Menores de 60 años sin condiciones de riesgo'::text) AND (dataset_turnos_detalle.edad IS NOT NULL) AND (dataset_turnos_detalle.edad >= 18) AND (dataset_turnos_detalle.edad <= 105)) OR (((dataset_turnos_detalle.servicio)::text = 'Adultos Mayores de 18 años'::text) AND (dataset_turnos_detalle.edad IS NOT NULL) AND (dataset_turnos_detalle.edad >= 18) AND (dataset_turnos_detalle.edad <= 105)) OR (((dataset_turnos_detalle.servicio)::text = 'Menores de 18 años'::text) AND (dataset_turnos_detalle.edad IS NOT NULL) AND (dataset_turnos_detalle.edad <= 105)))
  GROUP BY dataset_turnos_detalle.edad
  ORDER BY dataset_turnos_detalle.edad;


--
-- TOC entry 591 (class 1259 OID 463275)
-- Name: dataset_turnos_pob_gral_genero; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turnos_pob_gral_genero AS
 SELECT 1 AS id,
    2 AS fecha,
        CASE
            WHEN ((dataset_turnos_detalle.genero)::text = 'FEMENINO'::text) THEN 'femenino'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'MASCULINO'::text) THEN 'masculino'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'OTROS'::text) THEN 'otros'::text
            ELSE NULL::text
        END AS eje_x,
    (count(dataset_turnos_detalle.nro_cita))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE (((dataset_turnos_detalle.servicio)::text = 'Adultos Mayores de 18 años'::text) OR ((dataset_turnos_detalle.servicio)::text = 'Menores de 18 años'::text))
  GROUP BY dataset_turnos_detalle.genero
  ORDER BY dataset_turnos_detalle.genero;


--
-- TOC entry 574 (class 1259 OID 404147)
-- Name: dataset_turnos_por_estrategico; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_turnos_por_estrategico AS
 SELECT 1 AS id,
    dataset_turnos_detalle.servicio AS eje_x,
    (count(dataset_turnos_detalle.*))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE (((dataset_turnos_detalle.servicio)::text ~~ 'Personal estratégico%'::text) OR ((dataset_turnos_detalle.servicio)::text ~~ 'Docentes%'::text))
  GROUP BY dataset_turnos_detalle.servicio
  ORDER BY dataset_turnos_detalle.servicio;


--
-- TOC entry 285 (class 1259 OID 67296)
-- Name: dataset_ufu_hotel_acumulado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_ufu_hotel_acumulado AS
 SELECT 1 AS id,
    (dataset_cov_log_trabajos.fec_ejec)::date AS fecha,
    (( SELECT count(*) AS count
           FROM public.dataset_cov_log_trabajos dataset_cov_log_trabajos_1
          WHERE ((((dataset_cov_log_trabajos_1.tip_trabajo)::text = 'Despacho Taxi'::text) AND ((dataset_cov_log_trabajos_1.resultado)::text = 'Despachado'::text)) OR (((dataset_cov_log_trabajos_1.tip_trabajo)::text = 'Despacho Ambulancia'::text) AND ((dataset_cov_log_trabajos_1.resultado)::text = 'Despachado'::text)) OR (((dataset_cov_log_trabajos_1.tip_trabajo)::text = 'Despacho Taxi'::text) AND ((dataset_cov_log_trabajos_1.resultado)::text = 'Despachado Multiple'::text)) OR (((dataset_cov_log_trabajos_1.tip_trabajo)::text = 'Derivación Obra Social'::text) AND ((dataset_cov_log_trabajos_1.resultado)::text = 'TUFU - Hotel'::text)))))::integer AS dato
   FROM public.dataset_cov_log_trabajos
  ORDER BY ((dataset_cov_log_trabajos.fec_ejec)::date) DESC
 LIMIT 1;


--
-- TOC entry 203 (class 1259 OID 32542)
-- Name: ufus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ufus (
    id_ufus_nominal numeric(12,0),
    ufu character varying(255),
    fecha_ingreso_ufu timestamp without time zone,
    canti_genero_f numeric(12,0),
    canti_genero_m numeric(12,0),
    canti_domi_caba numeric(12,0),
    canti_domi_no_caba numeric(12,0),
    canti_domi_no_aplica numeric(12,0),
    canti_personas_ufu numeric(12,0),
    canti_consultas_covid numeric(12,0),
    canti_consultas_no_covid numeric(12,0),
    canti_consultas_atendidas numeric(12,0),
    canti_consultas_descartadas numeric(12,0),
    rango_etario_0_9 numeric(12,0),
    rango_etario_10_19 numeric(12,0),
    rango_etario_20_29 numeric(12,0),
    rango_etario_30_39 numeric(12,0),
    rango_etario_40_49 numeric(12,0),
    rango_etario_50_59 numeric(12,0),
    rango_etario_60_69 numeric(12,0),
    rango_etario_70_mas numeric(12,0),
    rango_etario_sin_datos numeric(12,0),
    canti_test_positivos numeric(12,0),
    canti_test_negativos numeric(12,0),
    canti_test_pendientes numeric(12,0),
    canti_test_realizados numeric(12,0)
);


--
-- TOC entry 299 (class 1259 OID 85247)
-- Name: dataset_ufus_atencion_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_ufus_atencion_dia AS
 SELECT 1 AS id,
    (ufus.fecha_ingreso_ufu)::date AS fecha,
    to_char(((ufus.fecha_ingreso_ufu)::date)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (sum(ufus.canti_personas_ufu))::integer AS eje_y
   FROM public.ufus
  GROUP BY ((ufus.fecha_ingreso_ufu)::date)
  ORDER BY ((ufus.fecha_ingreso_ufu)::date);


--
-- TOC entry 358 (class 1259 OID 100732)
-- Name: dataset_ufus_atencion_dia_tarjeta; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_ufus_atencion_dia_tarjeta AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            (ufus.fecha_ingreso_ufu)::date AS fecha,
            to_char(((ufus.fecha_ingreso_ufu)::date)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (sum(ufus.canti_personas_ufu))::integer AS eje_y
           FROM public.ufus
          GROUP BY ((ufus.fecha_ingreso_ufu)::date)
          ORDER BY ((ufus.fecha_ingreso_ufu)::date) DESC
         LIMIT 15) t
  ORDER BY t.fecha;


--
-- TOC entry 460 (class 1259 OID 302435)
-- Name: dataset_vac_total_covid_datos_ab; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_vac_total_covid_datos_ab (
    fecha_administracion timestamp(6) without time zone,
    grupo_etario character varying(255),
    genero character varying(255),
    vacuna character varying(255),
    tipo_efector character varying(255),
    dosis_1 numeric,
    dosis_2 numeric
);


--
-- TOC entry 461 (class 1259 OID 302465)
-- Name: dataset_vacuna_turno_casa_historiador; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_casa_historiador AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Casa del Historiador'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Casa del Historiador'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 462 (class 1259 OID 302471)
-- Name: dataset_vacuna_turno_casa_historiador_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_casa_historiador_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Casa del Historiador'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 424 (class 1259 OID 297686)
-- Name: dataset_vacuna_turno_cemar; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_cemar AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'CEMAR'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'CEMAR'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 463 (class 1259 OID 302478)
-- Name: dataset_vacuna_turno_cemar_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_cemar_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'CEMAR'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 425 (class 1259 OID 297691)
-- Name: dataset_vacuna_turno_centro_cultural_centeya; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_cultural_centeya AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Centro Cultural Centeya'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro Cultural Centeya'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 464 (class 1259 OID 302492)
-- Name: dataset_vacuna_turno_centro_cultural_centeya_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_cultural_centeya_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro Cultural Centeya'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 426 (class 1259 OID 297699)
-- Name: dataset_vacuna_turno_centro_cultural_el_adan; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_cultural_el_adan AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Centro Cultural El Adan'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro Cultural El Adan'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 465 (class 1259 OID 302499)
-- Name: dataset_vacuna_turno_centro_cultural_el_adan_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_cultural_el_adan_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro Cultural El Adan'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 427 (class 1259 OID 297722)
-- Name: dataset_vacuna_turno_centro_dia_n9_13; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_dia_n9_13 AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Centro de Dia N9 y 13'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro de Dia N9 y 13'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 466 (class 1259 OID 302506)
-- Name: dataset_vacuna_turno_centro_dia_n9_13_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_dia_n9_13_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro de Dia N9 y 13'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 429 (class 1259 OID 297732)
-- Name: dataset_vacuna_turno_centro_islamico; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_islamico AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Centro Islámico'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro Islámico'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 471 (class 1259 OID 302533)
-- Name: dataset_vacuna_turno_centro_islamico_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_islamico_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro Islámico'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 428 (class 1259 OID 297727)
-- Name: dataset_vacuna_turno_centro_parque_chacabuco; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_parque_chacabuco AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Centro de día Parque Chacabuco'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro de día Parque Chacabuco'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 467 (class 1259 OID 302513)
-- Name: dataset_vacuna_turno_centro_parque_chacabuco_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_parque_chacabuco_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro de día Parque Chacabuco'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 423 (class 1259 OID 297670)
-- Name: dataset_vacuna_turno_centro_recoleta; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_recoleta AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Centro C. Recoleta'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro C. Recoleta'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 491 (class 1259 OID 302708)
-- Name: dataset_vacuna_turno_centro_recoleta_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_centro_recoleta_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Centro C. Recoleta'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 430 (class 1259 OID 297740)
-- Name: dataset_vacuna_turno_club_atlanta; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_atlanta AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Club Atlanta'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Atlanta'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 472 (class 1259 OID 302540)
-- Name: dataset_vacuna_turno_club_atlanta_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_atlanta_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Atlanta'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 431 (class 1259 OID 297745)
-- Name: dataset_vacuna_turno_club_boca_juniors; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_boca_juniors AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Club Atlético Boca Juniors'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Atlético Boca Juniors'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 473 (class 1259 OID 302544)
-- Name: dataset_vacuna_turno_club_boca_juniors_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_boca_juniors_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Atlético Boca Juniors'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 432 (class 1259 OID 297750)
-- Name: dataset_vacuna_turno_club_comunicaciones; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_comunicaciones AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Club Comunicaciones'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Comunicaciones'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 474 (class 1259 OID 302551)
-- Name: dataset_vacuna_turno_club_comunicaciones_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_comunicaciones_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Comunicaciones'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 433 (class 1259 OID 297761)
-- Name: dataset_vacuna_turno_club_ferro; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_ferro AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Club Ferro'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Ferro'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 475 (class 1259 OID 302556)
-- Name: dataset_vacuna_turno_club_ferro_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_ferro_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Ferro'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 434 (class 1259 OID 297766)
-- Name: dataset_vacuna_turno_club_glorias_argentinas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_glorias_argentinas AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Club Glorias Argentinas'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Glorias Argentinas'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 476 (class 1259 OID 302563)
-- Name: dataset_vacuna_turno_club_glorias_argentinas_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_glorias_argentinas_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Glorias Argentinas'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 435 (class 1259 OID 297773)
-- Name: dataset_vacuna_turno_club_huracan; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_huracan AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Club Huracan'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Huracan'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 477 (class 1259 OID 302570)
-- Name: dataset_vacuna_turno_club_huracan_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_huracan_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Huracan'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 436 (class 1259 OID 297781)
-- Name: dataset_vacuna_turno_club_italiano; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_italiano AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Club Italiano'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Italiano'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 478 (class 1259 OID 302574)
-- Name: dataset_vacuna_turno_club_italiano_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_italiano_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Italiano'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 437 (class 1259 OID 297786)
-- Name: dataset_vacuna_turno_club_mitre; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_mitre AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Club Mitre'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Mitre'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 479 (class 1259 OID 302581)
-- Name: dataset_vacuna_turno_club_mitre_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_mitre_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Mitre'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 439 (class 1259 OID 297799)
-- Name: dataset_vacuna_turno_club_river_plate; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_river_plate AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Club River Plate'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club River Plate'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 481 (class 1259 OID 302595)
-- Name: dataset_vacuna_turno_club_river_plate_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_river_plate_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club River Plate'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 513 (class 1259 OID 312158)
-- Name: dataset_vacuna_turno_club_san_lorenzo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_san_lorenzo AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text ~~ 'Club San Lorenzo%'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text ~~ 'Club San Lorenzo%'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 512 (class 1259 OID 312148)
-- Name: dataset_vacuna_turno_club_san_lorenzo_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_san_lorenzo_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text ~~ 'Club San Lorenzo%'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 440 (class 1259 OID 297812)
-- Name: dataset_vacuna_turno_club_sin_rumbo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_sin_rumbo AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Club Sin Rumbo'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Sin Rumbo'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 482 (class 1259 OID 302606)
-- Name: dataset_vacuna_turno_club_sin_rumbo_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_club_sin_rumbo_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Sin Rumbo'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 441 (class 1259 OID 297817)
-- Name: dataset_vacuna_turno_corralon_floresta; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_corralon_floresta AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Corralón Floresta'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Corralón Floresta'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 483 (class 1259 OID 302613)
-- Name: dataset_vacuna_turno_corralon_floresta_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_corralon_floresta_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Corralón Floresta'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 551 (class 1259 OID 350695)
-- Name: dataset_vacuna_turno_fatsa; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_fatsa AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'FATSA'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 442 (class 1259 OID 297825)
-- Name: dataset_vacuna_turno_fundacion_pardes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_fundacion_pardes AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Fundacion Pardes'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Fundacion Pardes'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 484 (class 1259 OID 302620)
-- Name: dataset_vacuna_turno_fundacion_pardes_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_fundacion_pardes_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Fundacion Pardes'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 514 (class 1259 OID 312163)
-- Name: dataset_vacuna_turno_la_rural; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_la_rural AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text ~~ 'La Rural%'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text ~~ 'La Rural%'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 510 (class 1259 OID 312093)
-- Name: dataset_vacuna_turno_la_rural_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_la_rural_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text ~~ 'La Rural%'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 581 (class 1259 OID 422131)
-- Name: dataset_vacuna_turno_luna_park_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_luna_park_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Estadio Luna Park'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 443 (class 1259 OID 297838)
-- Name: dataset_vacuna_turno_oficina_escout; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_oficina_escout AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Oficina Escout'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Oficina Escout'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 485 (class 1259 OID 302628)
-- Name: dataset_vacuna_turno_oficina_escout_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_oficina_escout_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Oficina Escout'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 486 (class 1259 OID 302635)
-- Name: dataset_vacuna_turno_parque_roca_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_parque_roca_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Parque Roca'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 438 (class 1259 OID 297794)
-- Name: dataset_vacuna_turno_racing_villa_parque; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_racing_villa_parque AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE (((dataset_turnos_detalle_1.sede)::text = 'Club Racing Villa del Parque'::text) AND ((dataset_turnos_detalle_1.estado)::text = 'ATENDIDA'::text))) AS valor1,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Racing Villa del Parque'::text)) AS valor2
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 480 (class 1259 OID 302588)
-- Name: dataset_vacuna_turno_racing_villa_parque_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_racing_villa_parque_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Club Racing Villa del Parque'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 511 (class 1259 OID 312097)
-- Name: dataset_vacuna_turno_san_lorenzo_estadio_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_san_lorenzo_estadio_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text ~~ 'San Lorenzo - Estadio%'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 487 (class 1259 OID 302646)
-- Name: dataset_vacuna_turno_sede_oscoema_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_sede_oscoema_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Sede OSCOEMA'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 488 (class 1259 OID 302651)
-- Name: dataset_vacuna_turno_todos_unidos_centro_jubilados_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_todos_unidos_centro_jubilados_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Todos Unidos Centro de Jubilados'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 489 (class 1259 OID 302658)
-- Name: dataset_vacuna_turno_usina_del_arte_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_usina_del_arte_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'Usina del Arte'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 490 (class 1259 OID 302662)
-- Name: dataset_vacuna_turno_velez_biblioteca_total; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacuna_turno_velez_biblioteca_total AS
 SELECT 1 AS id,
    (dataset_turnos_detalle.fecha_solicitud)::date AS fecha,
    ( SELECT count(dataset_turnos_detalle_1.nro_cita) AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.sede)::text = 'VELEZ (BIBLIOTECA)'::text)) AS valor
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 422 (class 1259 OID 297389)
-- Name: dataset_vacunas_aplicadas_agrupadas_por_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_aplicadas_agrupadas_por_dia AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (sum((dataset_total_vacunas.dosis_1 + dataset_total_vacunas.dosis_2)))::integer AS eje_y
   FROM public.dataset_total_vacunas
  WHERE (dataset_total_vacunas.fecha IS NOT NULL)
  GROUP BY dataset_total_vacunas.fecha
  ORDER BY dataset_total_vacunas.fecha;


--
-- TOC entry 444 (class 1259 OID 297912)
-- Name: dataset_vacunas_aplicadas_por_grupo_etario; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_aplicadas_por_grupo_etario AS
 SELECT 1 AS id,
    2 AS fecha,
    dataset_total_vacunas.grupo_etario AS eje_x,
    (sum((dataset_total_vacunas.dosis_1 + dataset_total_vacunas.dosis_2)))::integer AS eje_y
   FROM public.dataset_total_vacunas
  GROUP BY dataset_total_vacunas.grupo_etario
  ORDER BY dataset_total_vacunas.grupo_etario;


--
-- TOC entry 445 (class 1259 OID 297928)
-- Name: dataset_vacunas_aplicadas_por_sexo; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_aplicadas_por_sexo AS
 SELECT 1 AS id,
    2 AS fecha,
        CASE
            WHEN ((dataset_total_vacunas.genero)::text = 'F'::text) THEN 'femenino'::text
            WHEN ((dataset_total_vacunas.genero)::text = 'M'::text) THEN 'masculino'::text
            ELSE NULL::text
        END AS eje_x,
    (sum((dataset_total_vacunas.dosis_1 + dataset_total_vacunas.dosis_2)))::integer AS eje_y
   FROM public.dataset_total_vacunas
  GROUP BY dataset_total_vacunas.genero
  ORDER BY dataset_total_vacunas.genero;


--
-- TOC entry 420 (class 1259 OID 297070)
-- Name: dataset_vacunas_total_aplicacion_dosis_1; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_1 AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 548 (class 1259 OID 338780)
-- Name: dataset_vacunas_total_aplicacion_dosis_1_covishield; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_1_covishield AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.vacuna)::text = 'AstraZeneca'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 451 (class 1259 OID 302060)
-- Name: dataset_vacunas_total_aplicacion_dosis_1_privado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_1_privado AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.tipo_efector)::text = 'Privado'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 453 (class 1259 OID 302084)
-- Name: dataset_vacunas_total_aplicacion_dosis_1_publico; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_1_publico AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.tipo_efector)::text = 'Público'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 469 (class 1259 OID 302525)
-- Name: dataset_vacunas_total_aplicacion_dosis_1_publico_nacional; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_1_publico_nacional AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.tipo_efector)::text = 'Público nacional'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 496 (class 1259 OID 303380)
-- Name: dataset_vacunas_total_aplicacion_dosis_1_sinopharm; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_1_sinopharm AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.vacuna)::text = 'Sinopharm'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 446 (class 1259 OID 298269)
-- Name: dataset_vacunas_total_aplicacion_dosis_1_sputnik; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_1_sputnik AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.vacuna)::text = 'Sputnik'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 421 (class 1259 OID 297074)
-- Name: dataset_vacunas_total_aplicacion_dosis_2; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_2 AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_2))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 547 (class 1259 OID 338772)
-- Name: dataset_vacunas_total_aplicacion_dosis_2_covishield; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_2_covishield AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_2))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.vacuna)::text = 'AstraZeneca'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 452 (class 1259 OID 302067)
-- Name: dataset_vacunas_total_aplicacion_dosis_2_privado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_2_privado AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_2))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.tipo_efector)::text = 'Privado'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 454 (class 1259 OID 302091)
-- Name: dataset_vacunas_total_aplicacion_dosis_2_publico; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_2_publico AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_2))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.tipo_efector)::text = 'Público'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 470 (class 1259 OID 302529)
-- Name: dataset_vacunas_total_aplicacion_dosis_2_publico_nacional; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_2_publico_nacional AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_2))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.tipo_efector)::text = 'Público nacional'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 498 (class 1259 OID 307272)
-- Name: dataset_vacunas_total_aplicacion_dosis_2_sinopharm; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_2_sinopharm AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_2))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.vacuna)::text = 'Sinopharm'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 447 (class 1259 OID 298279)
-- Name: dataset_vacunas_total_aplicacion_dosis_2_sputnik; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicacion_dosis_2_sputnik AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_2))::integer AS sum
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.vacuna)::text = 'Sputnik'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 457 (class 1259 OID 302241)
-- Name: dataset_vacunas_total_aplicaciones; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicaciones AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1) + (sum(dataset_total_vacunas_1.dosis_2))::integer)
           FROM public.dataset_total_vacunas dataset_total_vacunas_1) AS eje_y
   FROM public.dataset_total_vacunas
  GROUP BY dataset_total_vacunas.fecha
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 546 (class 1259 OID 338765)
-- Name: dataset_vacunas_total_aplicaciones_covishield; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicaciones_covishield AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1) + (sum(dataset_total_vacunas_1.dosis_2))::integer)
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.vacuna)::text = 'AstraZeneca'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  GROUP BY dataset_total_vacunas.fecha
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 458 (class 1259 OID 302265)
-- Name: dataset_vacunas_total_aplicaciones_privado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicaciones_privado AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1) + (sum(dataset_total_vacunas_1.dosis_2))::integer)
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.tipo_efector)::text = 'Privado'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  GROUP BY dataset_total_vacunas.fecha
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 459 (class 1259 OID 302431)
-- Name: dataset_vacunas_total_aplicaciones_publico; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicaciones_publico AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1) + (sum(dataset_total_vacunas_1.dosis_2))::integer)
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.tipo_efector)::text = 'Público'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  GROUP BY dataset_total_vacunas.fecha
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 468 (class 1259 OID 302517)
-- Name: dataset_vacunas_total_aplicaciones_publico_nacional; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicaciones_publico_nacional AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1) + (sum(dataset_total_vacunas_1.dosis_2))::integer)
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.tipo_efector)::text = 'Público nacional'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  GROUP BY dataset_total_vacunas.fecha
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 495 (class 1259 OID 303376)
-- Name: dataset_vacunas_total_aplicaciones_sinopharm; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicaciones_sinopharm AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1) + (sum(dataset_total_vacunas_1.dosis_2))::integer)
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.vacuna)::text = 'Sinopharm'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  GROUP BY dataset_total_vacunas.fecha
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 456 (class 1259 OID 302234)
-- Name: dataset_vacunas_total_aplicaciones_sputnik; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vacunas_total_aplicaciones_sputnik AS
 SELECT 1 AS id,
    dataset_total_vacunas.fecha,
    to_char((dataset_total_vacunas.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    ( SELECT (sum(dataset_total_vacunas_1.dosis_1) + (sum(dataset_total_vacunas_1.dosis_2))::integer)
           FROM public.dataset_total_vacunas dataset_total_vacunas_1
          WHERE ((dataset_total_vacunas_1.vacuna)::text = 'Sputnik'::text)) AS eje_y
   FROM public.dataset_total_vacunas
  GROUP BY dataset_total_vacunas.fecha
  ORDER BY dataset_total_vacunas.fecha DESC
 LIMIT 1;


--
-- TOC entry 220 (class 1259 OID 50520)
-- Name: dataset_vehiculo_ultimos_mes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_vehiculo_ultimos_mes (
    id integer NOT NULL,
    location_code character varying,
    hora character varying,
    cantidad character varying,
    sentido character varying,
    latitud character varying,
    longitud character varying
);


--
-- TOC entry 228 (class 1259 OID 50652)
-- Name: dataset_vehiculo_ultimos_mes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dataset_vehiculo_ultimos_mes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7749 (class 0 OID 0)
-- Dependencies: 228
-- Name: dataset_vehiculo_ultimos_mes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dataset_vehiculo_ultimos_mes_id_seq OWNED BY public.dataset_vehiculo_ultimos_mes.id;


--
-- TOC entry 310 (class 1259 OID 89272)
-- Name: dataset_vehiculos_ultimo_mes_triple; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dataset_vehiculos_ultimo_mes_triple AS
 SELECT 1 AS id,
    ingreso.fecha,
    to_char((ingreso.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    (ingreso.eje_y)::integer AS eje_y,
    (egreso.eje_y)::integer AS eje_y2,
    (interna.eje_y)::integer AS eje_y3
   FROM ((( SELECT (dataset_flujo_vehicular.hora)::date AS fecha,
            (dataset_flujo_vehicular.hora)::date AS eje_x,
            sum((dataset_flujo_vehicular.cantidad)::integer) AS eje_y
           FROM public.dataset_flujo_vehicular
          WHERE ((dataset_flujo_vehicular.sentido)::text = 'Ingreso'::text)
          GROUP BY ((dataset_flujo_vehicular.hora)::date)
          ORDER BY ((dataset_flujo_vehicular.hora)::date)) ingreso
     JOIN ( SELECT (dataset_flujo_vehicular.hora)::date AS fecha,
            ((dataset_flujo_vehicular.hora)::date)::text AS eje_x,
            sum((dataset_flujo_vehicular.cantidad)::integer) AS eje_y
           FROM public.dataset_flujo_vehicular
          WHERE ((dataset_flujo_vehicular.sentido)::text = 'Egreso'::text)
          GROUP BY ((dataset_flujo_vehicular.hora)::date)
          ORDER BY ((dataset_flujo_vehicular.hora)::date)) egreso ON ((ingreso.fecha = egreso.fecha)))
     JOIN ( SELECT (dataset_flujo_vehicular.hora)::date AS fecha,
            ((dataset_flujo_vehicular.hora)::date)::text AS eje_x,
            sum((dataset_flujo_vehicular.cantidad)::integer) AS eje_y
           FROM public.dataset_flujo_vehicular
          WHERE ((dataset_flujo_vehicular.sentido)::text = 'Interna'::text)
          GROUP BY ((dataset_flujo_vehicular.hora)::date)
          ORDER BY ((dataset_flujo_vehicular.hora)::date)) interna ON ((ingreso.fecha = interna.fecha)));


--
-- TOC entry 400 (class 1259 OID 271582)
-- Name: dataset_viajes_sube_v2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_viajes_sube_v2 (
    tipo_transporte character varying(255),
    dia timestamp(6) without time zone,
    parcial character varying(255),
    cantidad numeric(12,0),
    variacion real
);


--
-- TOC entry 602 (class 1259 OID 478290)
-- Name: dataset_web_covid_backup; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dataset_web_covid_backup (
    id_1 integer,
    id_2 integer,
    id_3 integer,
    cat_fech_1 date,
    cat_str_1 character varying(300),
    cat_str_2 character varying(300),
    valor_1 integer,
    valor_2 integer,
    valor_3 integer,
    fecha_act date,
    fecha_ult_reg date
);


--
-- TOC entry 593 (class 1259 OID 467497)
-- Name: datos_educacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.datos_educacion (
    "ID_1" double precision,
    "ID_2" double precision,
    "ID_3" double precision,
    "CAT_FECH_1" timestamp without time zone,
    "CAT_STR_1" character varying(300),
    "CAT_STR_2" character varying(300),
    "VALOR_1" double precision,
    "VALOR_2" double precision,
    "VALOR_3" double precision,
    "FECHA_ACT" timestamp without time zone,
    "FECHA_ULT_REG" timestamp without time zone
);


--
-- TOC entry 273 (class 1259 OID 53745)
-- Name: db_views_vista; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.db_views_vista (
    id integer NOT NULL,
    nombre character varying(256) NOT NULL,
    sql text NOT NULL,
    descripcion text NOT NULL,
    output_ex character varying(2048) NOT NULL,
    nombre_anterior character varying(256)
);


--
-- TOC entry 272 (class 1259 OID 53743)
-- Name: db_views_vista_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.db_views_vista_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7750 (class 0 OID 0)
-- Dependencies: 272
-- Name: db_views_vista_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.db_views_vista_id_seq OWNED BY public.db_views_vista.id;


--
-- TOC entry 262 (class 1259 OID 53251)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- TOC entry 261 (class 1259 OID 53249)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7751 (class 0 OID 0)
-- Dependencies: 261
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- TOC entry 248 (class 1259 OID 53129)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 53127)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7752 (class 0 OID 0)
-- Dependencies: 247
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- TOC entry 246 (class 1259 OID 53118)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 53116)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7753 (class 0 OID 0)
-- Dependencies: 245
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- TOC entry 274 (class 1259 OID 53762)
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- TOC entry 367 (class 1259 OID 102707)
-- Name: fallecidos_residentes_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.fallecidos_residentes_dia AS
 SELECT t.id,
    t.fecha,
    t.eje_x,
    t.eje_y
   FROM ( SELECT 1 AS id,
            dataset_reporte_covid_sit_gob.fecha,
            to_char((dataset_reporte_covid_sit_gob.fecha)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
            (dataset_reporte_covid_sit_gob.valor)::integer AS eje_y
           FROM public.dataset_reporte_covid_sit_gob
          WHERE (((dataset_reporte_covid_sit_gob.tipo_dato)::text = 'casos_residentes'::text) AND ((dataset_reporte_covid_sit_gob.subtipo_dato)::text = 'fallecidos_reportados_del_dia'::text))
          GROUP BY dataset_reporte_covid_sit_gob.fecha, dataset_reporte_covid_sit_gob.valor
          ORDER BY dataset_reporte_covid_sit_gob.fecha DESC
         LIMIT 30) t
  ORDER BY t.fecha;


--
-- TOC entry 309 (class 1259 OID 88262)
-- Name: ingres_cementerios_publ_test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingres_cementerios_publ_test (
    id numeric(8,0),
    fecha timestamp(6) without time zone,
    ing_chacarita_total numeric(12,0),
    ing_chacarita_covid numeric(12,0),
    ing_chacarita_no_covid numeric(12,0),
    ing_flores_total numeric(12,0),
    ing_flores_covid numeric(12,0),
    ing_flores_no_covid numeric(12,0),
    ing_recoleta_total numeric(12,0),
    ing_recoleta_covid numeric(12,0),
    ing_recoleta_no_covid numeric(12,0)
);


--
-- TOC entry 205 (class 1259 OID 34722)
-- Name: ingresos_cementerios_publicos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingresos_cementerios_publicos (
    id numeric(8,0),
    fecha timestamp without time zone,
    ing_chacarita_total numeric(12,0),
    ing_chacarita_covid numeric(12,0),
    ing_chacarita_no_covid numeric(12,0),
    ing_flores_total numeric(12,0),
    ing_flores_covid numeric(12,0),
    ing_flores_no_covid numeric(12,0),
    ing_recoleta_total numeric(12,0),
    ing_recoleta_covid numeric(12,0),
    ing_recoleta_no_covid numeric(12,0)
);


--
-- TOC entry 306 (class 1259 OID 87414)
-- Name: llamados_107_covid_test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.llamados_107_covid_test (
    fecha timestamp(6) without time zone NOT NULL,
    covid_llamados numeric(12,0),
    casos_sospechosos numeric(12,0),
    casos_descartados_covid numeric(12,0),
    casos_trasladados numeric(12,0),
    casos_derivados numeric(12,0)
);


--
-- TOC entry 229 (class 1259 OID 50667)
-- Name: movilidad_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.movilidad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 7754 (class 0 OID 0)
-- Dependencies: 229
-- Name: movilidad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.movilidad_id_seq OWNED BY public.dataset_movilidad.id;


--
-- TOC entry 545 (class 1259 OID 337842)
-- Name: prueba_agus; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.prueba_agus AS
 SELECT 1 AS id,
    dataset_flujo_vehicular.hora,
    (date_part('year'::text, dataset_flujo_vehicular.hora))::text AS year,
    (dataset_flujo_vehicular.cantidad)::integer AS cantidad
   FROM public.dataset_flujo_vehicular;


--
-- TOC entry 594 (class 1259 OID 467503)
-- Name: pruebas_educ; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pruebas_educ (
    id_1 integer
);


--
-- TOC entry 391 (class 1259 OID 109229)
-- Name: reporte_casos_json; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.reporte_casos_json AS
 SELECT to_char((positivos.fecha)::timestamp with time zone, 'DD-MM-YYYY'::text) AS fecha,
    positivos.eje_y AS casos_dia_residentes,
    altas.eje_y AS altas_dia_residentes,
    frd.eje_y AS fallecidos_dia_residentes,
    htd.dato AS hisopados_diarios,
    hpd.eje_y AS hisopados_positivos_diario,
    'https://bamapas.usig.buenosaires.gob.ar/render_indicador/sisa_confirmados_fecha_hisopado'::text AS grafico,
    pra.dato AS casos_totales_residentes,
    ara.dato AS altas_totales_residentes,
    far.dato AS fallecidos_totales_residente,
    hpa.eje_y AS hisopados_totales,
    hta.eje_y AS hisopados_positivos_totales,
    let.eje_y AS letalidad,
    ( SELECT (dataset_sisa_promedio_fallecidos.dato)::text AS dato
           FROM public.dataset_sisa_promedio_fallecidos
          ORDER BY dataset_sisa_promedio_fallecidos.fecha DESC
         LIMIT 1) AS edad_promedio_fallecidos,
    leves.dato AS camas_leves,
    moderadas.dato AS camas_moderadas,
    graves.dato AS camas_graves
   FROM (((((((((((((public.dataset_positivos_residentes_dia positivos
     JOIN public.altas_residentes_dia altas ON ((altas.fecha = positivos.fecha)))
     JOIN public.fallecidos_residentes_dia frd ON ((altas.fecha = frd.fecha)))
     JOIN public.dataset_sisa_hisopados_totales_dia htd ON ((altas.fecha = htd.fecha)))
     JOIN public.dataset_sisa_hisopados_positivos_dia hpd ON ((altas.fecha = hpd.fecha)))
     JOIN public.dataset_positivos_residentes_acumulado pra ON ((altas.fecha = pra.fecha)))
     JOIN public.dataset_altas_residentes_acumulado ara ON ((altas.fecha = ara.fecha)))
     JOIN public.dataset_fallecidos_acumulados_residentes far ON ((htd.fecha = far.fecha)))
     JOIN public.dataset_sisa_hisopados_positivos_acumulado hpa ON ((far.fecha = hpa.fecha)))
     JOIN public.dataset_sisa_hisopados_totales_acumulado hta ON ((altas.fecha = hta.fecha)))
     JOIN public.dataset_sisa_letalidad let ON ((altas.fecha = let.fecha)))
     LEFT JOIN public.dataset_p_camas_ocupacion_leves leves ON ((altas.fecha = leves.fecha)))
     LEFT JOIN public.dataset_p_camas_ocupacion_moderadas moderadas ON ((altas.fecha = moderadas.fecha)))
     LEFT JOIN public.dataset_p_camas_ocupacion_graves graves ON ((altas.fecha = graves.fecha)))
  ORDER BY (to_char((positivos.fecha)::timestamp with time zone, 'DD-MM-YYYY'::text)) DESC
 LIMIT 1;


--
-- TOC entry 389 (class 1259 OID 108603)
-- Name: reporte_gestion_sanitaria_json; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.reporte_gestion_sanitaria_json AS
 SELECT to_char((boti.fecha)::timestamp with time zone, 'DD-MM-YYYY'::text) AS fecha,
    boti.eje_y AS contactos_boti,
    d107.eje_y AS contactos_107,
    d147.eje_y AS contactos_147,
    ufus.eje_y AS atencion_ufus,
    ( SELECT sum((dataset_recursos_humanos_salud.designados)::integer) AS sum
           FROM public.dataset_recursos_humanos_salud
          GROUP BY dataset_recursos_humanos_salud.fecha
          ORDER BY dataset_recursos_humanos_salud.fecha DESC
         LIMIT 1) AS total_personal_salud
   FROM (((public.dataset_botitriage_consultas_evolucion boti
     JOIN public.dataset_107_llamados_dia d107 ON ((boti.fecha = d107.fecha)))
     JOIN public.dataset_147_llamados_dia d147 ON ((boti.fecha = d147.fecha)))
     JOIN public.dataset_ufus_atencion_dia ufus ON ((boti.fecha = ufus.fecha)))
  ORDER BY boti.fecha DESC
 LIMIT 1;


--
-- TOC entry 393 (class 1259 OID 109395)
-- Name: reporte_movilidad_json; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.reporte_movilidad_json AS
 SELECT ( SELECT to_char(dataset_viajes_sube.dia, 'DD-MM-YYYY'::text) AS to_char
           FROM public.dataset_viajes_sube
          ORDER BY dataset_viajes_sube.dia DESC
         LIMIT 1) AS fecha1,
    ( SELECT to_char((dataset_sube_ffcc_variacion_dia.fecha)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char
           FROM public.dataset_sube_ffcc_variacion_dia
          ORDER BY dataset_sube_ffcc_variacion_dia.fecha DESC
         LIMIT 1) AS fecha2,
    ( SELECT (dataset_viajes_sube.cantidad)::integer AS cantidad
           FROM public.dataset_viajes_sube
          WHERE ((dataset_viajes_sube.tipo_transporte)::text = 'Colectivo'::text)
          ORDER BY dataset_viajes_sube.dia DESC
         OFFSET 2
         LIMIT 1) AS viajes_colectivo,
    ( SELECT dataset_sube_colectivo_variacion_dia.dato
           FROM public.dataset_sube_colectivo_variacion_dia
          ORDER BY dataset_sube_colectivo_variacion_dia.fecha DESC) AS variacion_colectivo,
    ( SELECT (dataset_viajes_sube.cantidad)::integer AS cantidad
           FROM public.dataset_viajes_sube
          WHERE ((dataset_viajes_sube.tipo_transporte)::text = 'Tren'::text)
          ORDER BY dataset_viajes_sube.dia DESC
         OFFSET 2
         LIMIT 1) AS viajes_tren,
    ( SELECT dataset_sube_ffcc_variacion_dia.dato
           FROM public.dataset_sube_ffcc_variacion_dia
          ORDER BY dataset_sube_ffcc_variacion_dia.fecha DESC) AS variacion_tren,
    ( SELECT (dataset_viajes_sube.cantidad)::integer AS cantidad
           FROM public.dataset_viajes_sube
          WHERE ((dataset_viajes_sube.tipo_transporte)::text = 'Subte'::text)
          ORDER BY dataset_viajes_sube.dia DESC
         OFFSET 2
         LIMIT 1) AS viajes_subte,
    ( SELECT dataset_sube_subte_variacion_dia.dato
           FROM public.dataset_sube_subte_variacion_dia
          ORDER BY dataset_sube_subte_variacion_dia.fecha DESC) AS variacion_subte,
    ( SELECT (sum((dataset_flujo_vehicular.cantidad)::integer))::integer AS cantidad
           FROM public.dataset_flujo_vehicular
          WHERE ((dataset_flujo_vehicular.sentido)::text = 'Ingreso'::text)
          GROUP BY ((dataset_flujo_vehicular.hora)::date)
          ORDER BY ((dataset_flujo_vehicular.hora)::date) DESC
         LIMIT 1) AS vehiculos_ingreso,
    vingreso.dato AS variacion_ingreso,
    ( SELECT (sum((dataset_flujo_vehicular.cantidad)::integer))::integer AS cantidad
           FROM public.dataset_flujo_vehicular
          WHERE ((dataset_flujo_vehicular.sentido)::text = 'Egreso'::text)
          GROUP BY ((dataset_flujo_vehicular.hora)::date)
          ORDER BY ((dataset_flujo_vehicular.hora)::date) DESC
         LIMIT 1) AS vehiculos_egreso,
    vegreso.dato AS variacion_egreso,
    ( SELECT (sum((dataset_flujo_vehicular.cantidad)::integer))::integer AS cantidad
           FROM public.dataset_flujo_vehicular
          WHERE ((dataset_flujo_vehicular.sentido)::text = 'Interna'::text)
          GROUP BY ((dataset_flujo_vehicular.hora)::date)
          ORDER BY ((dataset_flujo_vehicular.hora)::date) DESC
         LIMIT 1) AS vehiculos_internos,
    vinterna.dato AS variacion_interna
   FROM ((public.dataset_flujo_interna_variacion_dia vinterna
     JOIN public.dataset_flujo_egreso_variacion_dia vegreso ON ((vinterna.fecha = vegreso.fecha)))
     JOIN public.dataset_flujo_ingreso_variacion_dia vingreso ON ((vinterna.fecha = vingreso.fecha)));


--
-- TOC entry 316 (class 1259 OID 93072)
-- Name: reporte_prensa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reporte_prensa (
    fecha date,
    tipo_reporte character varying,
    tipo_dato text,
    subtipo_dato text,
    valor integer
);


--
-- TOC entry 583 (class 1259 OID 422186)
-- Name: riesgo_citas_por_dia; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.riesgo_citas_por_dia AS
 SELECT 1 AS id,
    dosis.fecha,
    dosis.eje_x,
    (sum(dosis.eje_y))::integer AS eje_y,
    (sum(dosis.eje_y2))::integer AS eje_y2
   FROM ( SELECT (dataset_turnos_detalle.fecha_cita)::date AS fecha,
            to_char(dataset_turnos_detalle.fecha_cita, 'DD-MM'::text) AS eje_x,
                CASE
                    WHEN ((dataset_turnos_detalle.componente)::text = 'Primera Dosis'::text) THEN sum(1)
                    ELSE sum(0)
                END AS eje_y,
                CASE
                    WHEN ((dataset_turnos_detalle.componente)::text = 'Segunda Dosis'::text) THEN sum(1)
                    ELSE sum(0)
                END AS eje_y2
           FROM public.dataset_turnos_detalle
          WHERE ((dataset_turnos_detalle.servicio)::text = 'Adultos Menores de 60 años con condiciones de riesgo'::text)
          GROUP BY ((dataset_turnos_detalle.fecha_cita)::date), (to_char(dataset_turnos_detalle.fecha_cita, 'DD-MM'::text)), dataset_turnos_detalle.componente) dosis
  GROUP BY 1::integer, dosis.fecha, dosis.eje_x
  ORDER BY dosis.fecha;


--
-- TOC entry 582 (class 1259 OID 422165)
-- Name: riesgo_turnos_asignados_totales; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.riesgo_turnos_asignados_totales AS
 SELECT 1 AS id,
    dataset_turnos_detalle.fecha_solicitud AS fecha,
    to_char(dataset_turnos_detalle.fecha_solicitud, 'DD-MM'::text) AS eje_x,
    ( SELECT (count(dataset_turnos_detalle_1.nro_cita))::integer AS count
           FROM public.dataset_turnos_detalle dataset_turnos_detalle_1
          WHERE ((dataset_turnos_detalle_1.servicio)::text = 'Adultos Menores de 60 años con condiciones de riesgo'::text)) AS eje_y
   FROM public.dataset_turnos_detalle
  ORDER BY dataset_turnos_detalle.fecha_solicitud DESC
 LIMIT 1;


--
-- TOC entry 568 (class 1259 OID 396375)
-- Name: riesgo_turnos_edad; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.riesgo_turnos_edad AS
 SELECT 1 AS id,
    2 AS fecha,
    dataset_turnos_detalle.edad AS eje_x,
    (count(dataset_turnos_detalle.nro_cita))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE ((((dataset_turnos_detalle.servicio)::text ~~ 'Adultos Menores de 60 años con condiciones de riesgo'::text) AND (dataset_turnos_detalle.edad IS NOT NULL) AND (dataset_turnos_detalle.edad >= 18) AND (dataset_turnos_detalle.edad <= 105)) OR (((dataset_turnos_detalle.servicio)::text ~~ 'Adultos Menores de 60 años con condiciones de riesgo'::text) AND (dataset_turnos_detalle.edad IS NOT NULL) AND (dataset_turnos_detalle.edad >= 18) AND (dataset_turnos_detalle.edad <= 105)) OR (((dataset_turnos_detalle.servicio)::text = 'Adultos Menores de 60 años con condiciones de riesgo'::text) AND (dataset_turnos_detalle.edad IS NOT NULL) AND (dataset_turnos_detalle.edad >= 18) AND (dataset_turnos_detalle.edad <= 105)))
  GROUP BY dataset_turnos_detalle.edad
  ORDER BY dataset_turnos_detalle.edad;


--
-- TOC entry 569 (class 1259 OID 398374)
-- Name: riesgo_turnos_genero; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.riesgo_turnos_genero AS
 SELECT 1 AS id,
    2 AS fecha,
        CASE
            WHEN ((dataset_turnos_detalle.genero)::text = 'FEMENINO'::text) THEN 'femenino'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'MASCULINO'::text) THEN 'masculino'::text
            WHEN ((dataset_turnos_detalle.genero)::text = 'OTROS'::text) THEN 'otros'::text
            ELSE NULL::text
        END AS eje_x,
    (count(dataset_turnos_detalle.nro_cita))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE ((dataset_turnos_detalle.servicio)::text = 'Adultos Menores de 60 años con condiciones de riesgo'::text)
  GROUP BY dataset_turnos_detalle.genero
  ORDER BY dataset_turnos_detalle.genero;


--
-- TOC entry 610 (class 1259 OID 1827382)
-- Name: sunburst_vacunas_aplicadas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.sunburst_vacunas_aplicadas AS
 WITH vacunas AS (
         SELECT 1 AS id,
            sum(dataset_total_vacunas.dosis_1) AS dosis_1,
            sum(dataset_total_vacunas.dosis_2) AS dosis_2,
            dataset_total_vacunas.vacuna
           FROM public.dataset_total_vacunas
          GROUP BY dataset_total_vacunas.vacuna
        )
 SELECT vacunas.id,
    (unnest(ARRAY[vacunas.dosis_1, vacunas.dosis_2]))::integer AS cantidad,
    (unnest(ARRAY['dosis_1'::text, 'dosis_2'::text]))::character varying AS dosis,
    vacunas.vacuna
   FROM vacunas;


--
-- TOC entry 612 (class 1259 OID 1828173)
-- Name: temp_50506; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temp_50506 (
    "MEDIO" character varying(255),
    "FECHA" timestamp without time zone,
    "CANTIDAD" integer,
    "VARIACION" double precision
);


--
-- TOC entry 613 (class 1259 OID 1828347)
-- Name: temp_53826; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temp_53826 (
    fecha date,
    hora numeric(11,0),
    triage_cantidad numeric(11,0)
);


--
-- TOC entry 616 (class 1259 OID 1829080)
-- Name: temp_54779; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temp_54779 (
    fecha date,
    hora numeric(11,0),
    triage_cantidad numeric(11,0)
);


--
-- TOC entry 608 (class 1259 OID 1478517)
-- Name: temp_55190; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temp_55190 (
    "FECHA_CREACION" timestamp without time zone,
    "TIPO_DOC" character varying(300),
    "NUM_DOC" character varying(30),
    "GENERO" character varying(9),
    "APELLIDO_NOMBRES" character varying(255),
    "FECHA_NACIMIENTO" timestamp without time zone,
    "SERVICIO" character varying(255),
    "EMAIL" character varying(255),
    "TEL_CEL" character varying(255),
    "TEL_FIJ" character varying(255),
    "ORDEN" double precision
);


--
-- TOC entry 615 (class 1259 OID 1829041)
-- Name: temp_57937; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temp_57937 (
    "TIPO_TRANSPORTE" character varying(255),
    "DIA" timestamp without time zone,
    "PARCIAL" character varying(255),
    "CANTIDAD" numeric(13,0)
);


--
-- TOC entry 607 (class 1259 OID 921394)
-- Name: temp_59294; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temp_59294 (
    "FECHA_MUESTRA" timestamp without time zone,
    "TIPO" character varying(256),
    "DISPOSITIVO" character varying(256),
    "GENERO" character varying(50),
    "GRUPO_ETARIO" character varying(300),
    "N" integer
);


--
-- TOC entry 614 (class 1259 OID 1828362)
-- Name: temp_64371; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temp_64371 (
    fecha timestamp without time zone,
    cantidad_voluntarios numeric(13,0),
    cantidad_adultos_mayores numeric(13,0),
    cantidad_contactos_147 numeric(13,0)
);


--
-- TOC entry 586 (class 1259 OID 451806)
-- Name: temp_68855; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temp_68855 (
    "FECHA_CREACION" timestamp without time zone,
    "TIPO_DOC" character varying(300),
    "NUM_DOC" character varying(30),
    "GENERO" character varying(9),
    "APELLIDO_NOMBRES" character varying(255),
    "FECHA_NACIMIENTO" timestamp without time zone,
    "SERVICIO" character varying(255),
    "EMAIL" character varying(255),
    "TEL_CEL" character varying(255),
    "TEL_FIJ" character varying(255),
    "ORDEN" double precision
);


--
-- TOC entry 609 (class 1259 OID 1478535)
-- Name: temp_69081; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temp_69081 (
    "NRO_CITA" numeric(12,0),
    "GENERO" character varying(300),
    "SEDE" character varying(300),
    "SERVICIO" character varying(300),
    "ESTADO" character varying(300),
    "FECHA_SOLICITUD" timestamp without time zone,
    "FECHA_CITA" timestamp without time zone,
    "EDAD" numeric(12,0),
    "COMPONENTE" character varying(300)
);


--
-- TOC entry 599 (class 1259 OID 473521)
-- Name: testeos_por_dia_docentes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.testeos_por_dia_docentes AS
 SELECT 1 AS id,
    dataset_web_covid.cat_fech_1 AS fecha,
    to_char((dataset_web_covid.cat_fech_1)::timestamp with time zone, 'DD-MM'::text) AS eje_x,
    dataset_web_covid.valor_1 AS eje_y,
    7578 AS eje_y2
   FROM public.dataset_web_covid
  WHERE ((dataset_web_covid.id_1 = 9) AND (dataset_web_covid.id_2 = 17) AND (dataset_web_covid.cat_fech_1 > '2021-01-01'::date))
  ORDER BY dataset_web_covid.cat_fech_1;


--
-- TOC entry 578 (class 1259 OID 417063)
-- Name: turnos_dia_por_dosis; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.turnos_dia_por_dosis AS
 SELECT 1 AS id,
    dosis.fecha,
    dosis.eje_x,
    (sum(dosis.eje_y))::integer AS eje_y,
    (sum(dosis.eje_y2))::integer AS eje_y2
   FROM ( SELECT (dataset_turnos_detalle.fecha_cita)::date AS fecha,
            to_char(dataset_turnos_detalle.fecha_cita, 'DD-MM'::text) AS eje_x,
                CASE
                    WHEN ((dataset_turnos_detalle.componente)::text = 'Primera Dosis'::text) THEN sum(1)
                    ELSE sum(0)
                END AS eje_y,
                CASE
                    WHEN ((dataset_turnos_detalle.componente)::text = 'Segunda Dosis'::text) THEN sum(1)
                    ELSE sum(0)
                END AS eje_y2
           FROM public.dataset_turnos_detalle
          GROUP BY ((dataset_turnos_detalle.fecha_cita)::date), (to_char(dataset_turnos_detalle.fecha_cita, 'DD-MM'::text)), dataset_turnos_detalle.componente) dosis
  GROUP BY 1::integer, dosis.fecha, dosis.eje_x
  ORDER BY dosis.fecha;


--
-- TOC entry 577 (class 1259 OID 417041)
-- Name: turnos_segun_dosis; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.turnos_segun_dosis AS
 SELECT 1 AS id,
        CASE
            WHEN ((dataset_turnos_detalle.componente)::text = 'Primera Dosis'::text) THEN 'Primera Dosis'::text
            WHEN ((dataset_turnos_detalle.componente)::text = 'Segunda Dosis'::text) THEN 'Segunda Dosis'::text
            ELSE NULL::text
        END AS eje_x,
    (count(dataset_turnos_detalle.nro_cita))::integer AS eje_y
   FROM public.dataset_turnos_detalle
  WHERE ((dataset_turnos_detalle.servicio)::text !~~ '%PAMI'::text)
  GROUP BY dataset_turnos_detalle.componente
  ORDER BY dataset_turnos_detalle.componente;


--
-- TOC entry 308 (class 1259 OID 87423)
-- Name: ufus_test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ufus_test (
    id_ufus_nominal numeric(12,0),
    ufu character varying(255),
    fecha_ingreso_ufu timestamp(6) without time zone,
    canti_genero_f numeric(12,0),
    canti_genero_m numeric(12,0),
    canti_domi_caba numeric(12,0),
    canti_domi_no_caba numeric(12,0),
    canti_domi_no_aplica numeric(12,0),
    canti_personas_ufu numeric(12,0),
    canti_consultas_covid numeric(12,0),
    canti_consultas_no_covid numeric(12,0),
    canti_consultas_atendidas numeric(12,0),
    canti_consultas_descartadas numeric(12,0),
    rango_etario_0_9 numeric(12,0),
    rango_etario_10_19 numeric(12,0),
    rango_etario_20_29 numeric(12,0),
    rango_etario_30_39 numeric(12,0),
    rango_etario_40_49 numeric(12,0),
    rango_etario_50_59 numeric(12,0),
    rango_etario_60_69 numeric(12,0),
    rango_etario_70_mas numeric(12,0),
    rango_etario_sin_datos numeric(12,0),
    canti_test_positivos numeric(12,0),
    canti_test_negativos numeric(12,0),
    canti_test_pendientes numeric(12,0),
    canti_test_realizados numeric(12,0)
);


--
-- TOC entry 7078 (class 2604 OID 53156)
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- TOC entry 7079 (class 2604 OID 53168)
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 7077 (class 2604 OID 53147)
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- TOC entry 7080 (class 2604 OID 53176)
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- TOC entry 7081 (class 2604 OID 53186)
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- TOC entry 7082 (class 2604 OID 53194)
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- TOC entry 7109 (class 2604 OID 316427)
-- Name: componentes_colecciondeiconos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_colecciondeiconos ALTER COLUMN id SET DEFAULT nextval('public.componentes_colecciondeiconos_id_seq'::regclass);


--
-- TOC entry 7119 (class 2604 OID 320376)
-- Name: componentes_columnaconorden id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_columnaconorden ALTER COLUMN id SET DEFAULT nextval('public.componentes_columnaconorden_id_seq'::regclass);


--
-- TOC entry 7124 (class 2604 OID 320419)
-- Name: componentes_coordenadasparalelas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_coordenadasparalelas ALTER COLUMN id SET DEFAULT nextval('public.componentes_coordenadasparalelas_id_seq'::regclass);


--
-- TOC entry 7126 (class 2604 OID 320431)
-- Name: componentes_coordenadasparalelas_ejes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_coordenadasparalelas_ejes ALTER COLUMN id SET DEFAULT nextval('public.componentes_coordenadasparalelas_ejes_id_seq'::regclass);


--
-- TOC entry 7111 (class 2604 OID 316466)
-- Name: componentes_diagramadeburbujas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_diagramadeburbujas ALTER COLUMN id SET DEFAULT nextval('public.componentes_diagramadeburbujas_id_seq'::regclass);


--
-- TOC entry 7088 (class 2604 OID 53696)
-- Name: componentes_dona id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_dona ALTER COLUMN id SET DEFAULT nextval('public.componentes_dona_id_seq'::regclass);


--
-- TOC entry 7086 (class 2604 OID 53634)
-- Name: componentes_grafico_cartesiano id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_grafico_cartesiano ALTER COLUMN id SET DEFAULT nextval('public.componentes_grafico_cartesiano_id_seq'::regclass);


--
-- TOC entry 7110 (class 2604 OID 316435)
-- Name: componentes_icono id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_icono ALTER COLUMN id SET DEFAULT nextval('public.componentes_icono_id_seq'::regclass);


--
-- TOC entry 7105 (class 2604 OID 311273)
-- Name: componentes_iconoconrelleno id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_iconoconrelleno ALTER COLUMN id SET DEFAULT nextval('public.componentes_iconoconrelleno_id_seq'::regclass);


--
-- TOC entry 7085 (class 2604 OID 53316)
-- Name: componentes_indicador id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_indicador ALTER COLUMN id SET DEFAULT nextval('public.componentes_indicador_id_seq'::regclass);


--
-- TOC entry 7108 (class 2604 OID 313154)
-- Name: componentes_mapa id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_mapa ALTER COLUMN id SET DEFAULT nextval('public.componentes_mapa_id_seq'::regclass);


--
-- TOC entry 7095 (class 2604 OID 311115)
-- Name: componentes_mapaconburbujas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_mapaconburbujas ALTER COLUMN id SET DEFAULT nextval('public.componentes_mapaconburbujas_id_seq'::regclass);


--
-- TOC entry 7100 (class 2604 OID 311132)
-- Name: componentes_paletacolor id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_paletacolor ALTER COLUMN id SET DEFAULT nextval('public.componentes_paletacolor_id_seq'::regclass);


--
-- TOC entry 7101 (class 2604 OID 311237)
-- Name: componentes_radar id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_radar ALTER COLUMN id SET DEFAULT nextval('public.componentes_radar_id_seq'::regclass);


--
-- TOC entry 7116 (class 2604 OID 320339)
-- Name: componentes_sunburst id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_sunburst ALTER COLUMN id SET DEFAULT nextval('public.componentes_sunburst_id_seq'::regclass);


--
-- TOC entry 7123 (class 2604 OID 320386)
-- Name: componentes_sunburst_anillos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_sunburst_anillos ALTER COLUMN id SET DEFAULT nextval('public.componentes_sunburst_anillos_id_seq'::regclass);


--
-- TOC entry 7087 (class 2604 OID 53645)
-- Name: componentes_tarjeta id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_tarjeta ALTER COLUMN id SET DEFAULT nextval('public.componentes_tarjeta_id_seq'::regclass);


--
-- TOC entry 7091 (class 2604 OID 93025)
-- Name: componentes_tarjeta_doble id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_tarjeta_doble ALTER COLUMN id SET DEFAULT nextval('public.componentes_tarjeta_doble_id_seq'::regclass);


--
-- TOC entry 7092 (class 2604 OID 311098)
-- Name: componentes_treemap id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_treemap ALTER COLUMN id SET DEFAULT nextval('public.componentes_treemap_id_seq'::regclass);


--
-- TOC entry 7127 (class 2604 OID 327024)
-- Name: componentes_treemap_jerarquias id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_treemap_jerarquias ALTER COLUMN id SET DEFAULT nextval('public.componentes_treemap_jerarquias_id_seq'::regclass);


--
-- TOC entry 7067 (class 2604 OID 50669)
-- Name: dataset_casos_sisa id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_casos_sisa ALTER COLUMN id SET DEFAULT nextval('public.dataset_casos_sisa_id_seq'::regclass);


--
-- TOC entry 7068 (class 2604 OID 50670)
-- Name: dataset_contactosbotitriage id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_contactosbotitriage ALTER COLUMN id SET DEFAULT nextval('public.dataset_contactosbotitriage_id_seq'::regclass);


--
-- TOC entry 7090 (class 2604 OID 57752)
-- Name: dataset_cov_log_trabajos_hml id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_cov_log_trabajos_hml ALTER COLUMN id SET DEFAULT nextval('public."dataset_cov_log_trabajos_HML_id_seq"'::regclass);


--
-- TOC entry 7070 (class 2604 OID 50671)
-- Name: dataset_movilidad id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_movilidad ALTER COLUMN id SET DEFAULT nextval('public.movilidad_id_seq'::regclass);


--
-- TOC entry 7069 (class 2604 OID 50672)
-- Name: dataset_recursos_humanos_salud id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_recursos_humanos_salud ALTER COLUMN id SET DEFAULT nextval('public.dataset_recursos_humanos_salud_id_seq'::regclass);


--
-- TOC entry 7073 (class 2604 OID 50673)
-- Name: dataset_repatriados_pais_procedencia id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_repatriados_pais_procedencia ALTER COLUMN id SET DEFAULT nextval('public.dataset_repatriados_pais_procedencia_id_seq'::regclass);


--
-- TOC entry 7071 (class 2604 OID 50674)
-- Name: dataset_sube_ultimo_mes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_sube_ultimo_mes ALTER COLUMN id SET DEFAULT nextval('public.dataset_sube_ultimo_mes_id_seq'::regclass);


--
-- TOC entry 7072 (class 2604 OID 50675)
-- Name: dataset_vehiculo_ultimos_mes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_vehiculo_ultimos_mes ALTER COLUMN id SET DEFAULT nextval('public.dataset_vehiculo_ultimos_mes_id_seq'::regclass);


--
-- TOC entry 7089 (class 2604 OID 53748)
-- Name: db_views_vista id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.db_views_vista ALTER COLUMN id SET DEFAULT nextval('public.db_views_vista_id_seq'::regclass);


--
-- TOC entry 7083 (class 2604 OID 53254)
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- TOC entry 7076 (class 2604 OID 53132)
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- TOC entry 7075 (class 2604 OID 53121)
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- TOC entry 7160 (class 2606 OID 53280)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 7165 (class 2606 OID 53207)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 7168 (class 2606 OID 53170)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 7162 (class 2606 OID 53158)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 7155 (class 2606 OID 53198)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 7157 (class 2606 OID 53149)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 7176 (class 2606 OID 53188)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 7179 (class 2606 OID 53222)
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 7170 (class 2606 OID 53178)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 7182 (class 2606 OID 53196)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 7185 (class 2606 OID 53236)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 7173 (class 2606 OID 53274)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 7192 (class 2606 OID 53286)
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- TOC entry 7194 (class 2606 OID 53288)
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- TOC entry 7130 (class 2606 OID 1829701)
-- Name: casos_covid19 casos_covid19_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.casos_covid19
    ADD CONSTRAINT casos_covid19_pk PRIMARY KEY (numero_de_caso);


--
-- TOC entry 7240 (class 2606 OID 316429)
-- Name: componentes_colecciondeiconos componentes_colecciondeiconos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_colecciondeiconos
    ADD CONSTRAINT componentes_colecciondeiconos_pkey PRIMARY KEY (id);


--
-- TOC entry 7253 (class 2606 OID 320380)
-- Name: componentes_columnaconorden componentes_columnaconorden_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_columnaconorden
    ADD CONSTRAINT componentes_columnaconorden_pkey PRIMARY KEY (id);


--
-- TOC entry 7265 (class 2606 OID 320441)
-- Name: componentes_coordenadasparalelas_ejes componentes_coordenadasp_coordenadasparalelas_id__8480da3d_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_coordenadasparalelas_ejes
    ADD CONSTRAINT componentes_coordenadasp_coordenadasparalelas_id__8480da3d_uniq UNIQUE (coordenadasparalelas_id, columnaconorden_id);


--
-- TOC entry 7269 (class 2606 OID 320433)
-- Name: componentes_coordenadasparalelas_ejes componentes_coordenadasparalelas_ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_coordenadasparalelas_ejes
    ADD CONSTRAINT componentes_coordenadasparalelas_ejes_pkey PRIMARY KEY (id);


--
-- TOC entry 7262 (class 2606 OID 320425)
-- Name: componentes_coordenadasparalelas componentes_coordenadasparalelas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_coordenadasparalelas
    ADD CONSTRAINT componentes_coordenadasparalelas_pkey PRIMARY KEY (id);


--
-- TOC entry 7246 (class 2606 OID 316475)
-- Name: componentes_diagramadeburbujas componentes_diagramadeburbujas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_diagramadeburbujas
    ADD CONSTRAINT componentes_diagramadeburbujas_pkey PRIMARY KEY (id);


--
-- TOC entry 7204 (class 2606 OID 53701)
-- Name: componentes_dona componentes_dona_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_dona
    ADD CONSTRAINT componentes_dona_pkey PRIMARY KEY (id);


--
-- TOC entry 7198 (class 2606 OID 53639)
-- Name: componentes_grafico_cartesiano componentes_grafico_cartesiano_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_grafico_cartesiano
    ADD CONSTRAINT componentes_grafico_cartesiano_pkey PRIMARY KEY (id);


--
-- TOC entry 7243 (class 2606 OID 316440)
-- Name: componentes_icono componentes_icono_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_icono
    ADD CONSTRAINT componentes_icono_pkey PRIMARY KEY (id);


--
-- TOC entry 7235 (class 2606 OID 311279)
-- Name: componentes_iconoconrelleno componentes_iconoconrelleno_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_iconoconrelleno
    ADD CONSTRAINT componentes_iconoconrelleno_pkey PRIMARY KEY (id);


--
-- TOC entry 7196 (class 2606 OID 53321)
-- Name: componentes_indicador componentes_indicador_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_indicador
    ADD CONSTRAINT componentes_indicador_pkey PRIMARY KEY (id);


--
-- TOC entry 7238 (class 2606 OID 313156)
-- Name: componentes_mapa componentes_mapa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_mapa
    ADD CONSTRAINT componentes_mapa_pkey PRIMARY KEY (id);


--
-- TOC entry 7225 (class 2606 OID 311120)
-- Name: componentes_mapaconburbujas componentes_mapaconburbujas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_mapaconburbujas
    ADD CONSTRAINT componentes_mapaconburbujas_pkey PRIMARY KEY (id);


--
-- TOC entry 7228 (class 2606 OID 311134)
-- Name: componentes_paletacolor componentes_paletacolor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_paletacolor
    ADD CONSTRAINT componentes_paletacolor_pkey PRIMARY KEY (id);


--
-- TOC entry 7231 (class 2606 OID 311244)
-- Name: componentes_radar componentes_radar_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_radar
    ADD CONSTRAINT componentes_radar_pkey PRIMARY KEY (id);


--
-- TOC entry 7255 (class 2606 OID 320390)
-- Name: componentes_sunburst_anillos componentes_sunburst_ani_sunburst_id_columnaconor_37122893_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_sunburst_anillos
    ADD CONSTRAINT componentes_sunburst_ani_sunburst_id_columnaconor_37122893_uniq UNIQUE (sunburst_id, columnaconorden_id);


--
-- TOC entry 7258 (class 2606 OID 320388)
-- Name: componentes_sunburst_anillos componentes_sunburst_anillos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_sunburst_anillos
    ADD CONSTRAINT componentes_sunburst_anillos_pkey PRIMARY KEY (id);


--
-- TOC entry 7250 (class 2606 OID 320347)
-- Name: componentes_sunburst componentes_sunburst_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_sunburst
    ADD CONSTRAINT componentes_sunburst_pkey PRIMARY KEY (id);


--
-- TOC entry 7213 (class 2606 OID 93030)
-- Name: componentes_tarjeta_doble componentes_tarjeta_doble_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_tarjeta_doble
    ADD CONSTRAINT componentes_tarjeta_doble_pkey PRIMARY KEY (id);


--
-- TOC entry 7201 (class 2606 OID 53650)
-- Name: componentes_tarjeta componentes_tarjeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_tarjeta
    ADD CONSTRAINT componentes_tarjeta_pkey PRIMARY KEY (id);


--
-- TOC entry 7271 (class 2606 OID 327028)
-- Name: componentes_treemap_jerarquias componentes_treemap_jera_treemap_id_columnaconord_71a19b3d_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_treemap_jerarquias
    ADD CONSTRAINT componentes_treemap_jera_treemap_id_columnaconord_71a19b3d_uniq UNIQUE (treemap_id, columnaconorden_id);


--
-- TOC entry 7274 (class 2606 OID 327026)
-- Name: componentes_treemap_jerarquias componentes_treemap_jerarquias_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_treemap_jerarquias
    ADD CONSTRAINT componentes_treemap_jerarquias_pkey PRIMARY KEY (id);


--
-- TOC entry 7221 (class 2606 OID 311103)
-- Name: componentes_treemap componentes_treemap_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_treemap
    ADD CONSTRAINT componentes_treemap_pkey PRIMARY KEY (id);


--
-- TOC entry 7132 (class 2606 OID 50683)
-- Name: dataset_casos_sisa dataset_casos_sisa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_casos_sisa
    ADD CONSTRAINT dataset_casos_sisa_pkey PRIMARY KEY (id);


--
-- TOC entry 7134 (class 2606 OID 50685)
-- Name: dataset_contactosbotitriage dataset_contactosbotitriage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_contactosbotitriage
    ADD CONSTRAINT dataset_contactosbotitriage_pkey PRIMARY KEY (id);


--
-- TOC entry 7136 (class 2606 OID 50687)
-- Name: dataset_recursos_humanos_salud dataset_recursos_humanos_salud_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_recursos_humanos_salud
    ADD CONSTRAINT dataset_recursos_humanos_salud_pkey PRIMARY KEY (id);


--
-- TOC entry 7144 (class 2606 OID 50689)
-- Name: dataset_repatriados_pais_procedencia dataset_repatriados_pais_procedencia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_repatriados_pais_procedencia
    ADD CONSTRAINT dataset_repatriados_pais_procedencia_pkey PRIMARY KEY (id);


--
-- TOC entry 7140 (class 2606 OID 50691)
-- Name: dataset_sube_ultimo_mes dataset_sube_ultimo_mes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_sube_ultimo_mes
    ADD CONSTRAINT dataset_sube_ultimo_mes_pkey PRIMARY KEY (id);


--
-- TOC entry 7142 (class 2606 OID 50693)
-- Name: dataset_vehiculo_ultimos_mes dataset_vehiculo_ultimos_mes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_vehiculo_ultimos_mes
    ADD CONSTRAINT dataset_vehiculo_ultimos_mes_pkey PRIMARY KEY (id);


--
-- TOC entry 7207 (class 2606 OID 53753)
-- Name: db_views_vista db_views_vista_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.db_views_vista
    ADD CONSTRAINT db_views_vista_pkey PRIMARY KEY (id);


--
-- TOC entry 7188 (class 2606 OID 53260)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 7150 (class 2606 OID 53136)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 7152 (class 2606 OID 53134)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 7148 (class 2606 OID 53126)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 7210 (class 2606 OID 53769)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 7138 (class 2606 OID 50695)
-- Name: dataset_movilidad movilidad_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dataset_movilidad
    ADD CONSTRAINT movilidad_pkey PRIMARY KEY (id);


--
-- TOC entry 7158 (class 1259 OID 53281)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 7163 (class 1259 OID 53218)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 7166 (class 1259 OID 53219)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 7153 (class 1259 OID 53204)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 7174 (class 1259 OID 53234)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- TOC entry 7177 (class 1259 OID 53233)
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- TOC entry 7180 (class 1259 OID 53248)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 7183 (class 1259 OID 53247)
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 7171 (class 1259 OID 53275)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 7190 (class 1259 OID 53294)
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- TOC entry 7128 (class 1259 OID 1829872)
-- Name: casos_covid19_fecha_toma_muestra_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX casos_covid19_fecha_toma_muestra_idx ON public.casos_covid19 USING btree (fecha_toma_muestra);


--
-- TOC entry 7266 (class 1259 OID 320453)
-- Name: componentes_coordenadaspar_columnaconorden_id_a4c9e16f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_coordenadaspar_columnaconorden_id_a4c9e16f ON public.componentes_coordenadasparalelas_ejes USING btree (columnaconorden_id);


--
-- TOC entry 7267 (class 1259 OID 320452)
-- Name: componentes_coordenadaspar_coordenadasparalelas_id_74ec2652; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_coordenadaspar_coordenadasparalelas_id_74ec2652 ON public.componentes_coordenadasparalelas_ejes USING btree (coordenadasparalelas_id);


--
-- TOC entry 7260 (class 1259 OID 320459)
-- Name: componentes_coordenadasparalelas_paleta_color_id_7b76d96a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_coordenadasparalelas_paleta_color_id_7b76d96a ON public.componentes_coordenadasparalelas USING btree (paleta_color_id);


--
-- TOC entry 7263 (class 1259 OID 320439)
-- Name: componentes_coordenadasparalelas_view_asociada_id_c1d3e6ff; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_coordenadasparalelas_view_asociada_id_c1d3e6ff ON public.componentes_coordenadasparalelas USING btree (view_asociada_id);


--
-- TOC entry 7244 (class 1259 OID 316486)
-- Name: componentes_diagramadeburbujas_paleta_color_id_986fb0c8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_diagramadeburbujas_paleta_color_id_986fb0c8 ON public.componentes_diagramadeburbujas USING btree (paleta_color_id);


--
-- TOC entry 7247 (class 1259 OID 316487)
-- Name: componentes_diagramadeburbujas_view_asociada_id_1c11beec; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_diagramadeburbujas_view_asociada_id_1c11beec ON public.componentes_diagramadeburbujas USING btree (view_asociada_id);


--
-- TOC entry 7205 (class 1259 OID 54178)
-- Name: componentes_dona_view_asociada_id_1aace4a9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_dona_view_asociada_id_1aace4a9 ON public.componentes_dona USING btree (view_asociada_id);


--
-- TOC entry 7199 (class 1259 OID 54179)
-- Name: componentes_grafico_cartesiano_view_asociada_id_b91ddebd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_grafico_cartesiano_view_asociada_id_b91ddebd ON public.componentes_grafico_cartesiano USING btree (view_asociada_id);


--
-- TOC entry 7241 (class 1259 OID 316460)
-- Name: componentes_icono_coleccion_id_63a39658; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_icono_coleccion_id_63a39658 ON public.componentes_icono USING btree (coleccion_id);


--
-- TOC entry 7233 (class 1259 OID 316449)
-- Name: componentes_iconoconrelleno_icono_id_e38a859d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_iconoconrelleno_icono_id_e38a859d ON public.componentes_iconoconrelleno USING btree (icono_id);


--
-- TOC entry 7236 (class 1259 OID 311285)
-- Name: componentes_iconoconrelleno_view_asociada_id_b5869515; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_iconoconrelleno_view_asociada_id_b5869515 ON public.componentes_iconoconrelleno USING btree (view_asociada_id);


--
-- TOC entry 7223 (class 1259 OID 313162)
-- Name: componentes_mapaconburbujas_mapa_id_4c15db3c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_mapaconburbujas_mapa_id_4c15db3c ON public.componentes_mapaconburbujas USING btree (mapa_id);


--
-- TOC entry 7226 (class 1259 OID 311126)
-- Name: componentes_mapaconburbujas_view_asociada_id_455b2edf; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_mapaconburbujas_view_asociada_id_455b2edf ON public.componentes_mapaconburbujas USING btree (view_asociada_id);


--
-- TOC entry 7229 (class 1259 OID 311255)
-- Name: componentes_radar_paleta_color_id_3f21c9ad; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_radar_paleta_color_id_3f21c9ad ON public.componentes_radar USING btree (paleta_color_id);


--
-- TOC entry 7232 (class 1259 OID 311256)
-- Name: componentes_radar_view_asociada_id_05eec05c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_radar_view_asociada_id_05eec05c ON public.componentes_radar USING btree (view_asociada_id);


--
-- TOC entry 7256 (class 1259 OID 320402)
-- Name: componentes_sunburst_anillos_columnaconorden_id_adbe86b2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_sunburst_anillos_columnaconorden_id_adbe86b2 ON public.componentes_sunburst_anillos USING btree (columnaconorden_id);


--
-- TOC entry 7259 (class 1259 OID 320401)
-- Name: componentes_sunburst_anillos_sunburst_id_241e8394; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_sunburst_anillos_sunburst_id_241e8394 ON public.componentes_sunburst_anillos USING btree (sunburst_id);


--
-- TOC entry 7248 (class 1259 OID 320358)
-- Name: componentes_sunburst_paleta_color_id_33a456fd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_sunburst_paleta_color_id_33a456fd ON public.componentes_sunburst USING btree (paleta_color_id);


--
-- TOC entry 7251 (class 1259 OID 320359)
-- Name: componentes_sunburst_view_asociada_id_20d1146f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_sunburst_view_asociada_id_20d1146f ON public.componentes_sunburst USING btree (view_asociada_id);


--
-- TOC entry 7214 (class 1259 OID 93036)
-- Name: componentes_tarjeta_doble_view_asociada_id_19d4a810; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_tarjeta_doble_view_asociada_id_19d4a810 ON public.componentes_tarjeta_doble USING btree (view_asociada_id);


--
-- TOC entry 7202 (class 1259 OID 54180)
-- Name: componentes_tarjeta_view_asociada_id_849cd7cc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_tarjeta_view_asociada_id_849cd7cc ON public.componentes_tarjeta USING btree (view_asociada_id);


--
-- TOC entry 7272 (class 1259 OID 327040)
-- Name: componentes_treemap_jerarquias_columnaconorden_id_dc5aea7e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_treemap_jerarquias_columnaconorden_id_dc5aea7e ON public.componentes_treemap_jerarquias USING btree (columnaconorden_id);


--
-- TOC entry 7275 (class 1259 OID 327039)
-- Name: componentes_treemap_jerarquias_treemap_id_7ef9f094; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_treemap_jerarquias_treemap_id_7ef9f094 ON public.componentes_treemap_jerarquias USING btree (treemap_id);


--
-- TOC entry 7219 (class 1259 OID 311140)
-- Name: componentes_treemap_paleta_color_id_22276f97; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_treemap_paleta_color_id_22276f97 ON public.componentes_treemap USING btree (paleta_color_id);


--
-- TOC entry 7222 (class 1259 OID 311109)
-- Name: componentes_treemap_view_asociada_id_c08828f6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX componentes_treemap_view_asociada_id_c08828f6 ON public.componentes_treemap USING btree (view_asociada_id);


--
-- TOC entry 7215 (class 1259 OID 510532)
-- Name: dataset_turnos_detalle_fc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX dataset_turnos_detalle_fc_idx ON public.dataset_turnos_detalle USING btree (fecha_cita DESC);


--
-- TOC entry 7216 (class 1259 OID 510656)
-- Name: dataset_turnos_detalle_fecha_cita_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX dataset_turnos_detalle_fecha_cita_idx ON public.dataset_turnos_detalle USING btree (fecha_cita DESC);


--
-- TOC entry 7217 (class 1259 OID 509246)
-- Name: dataset_turnos_detalle_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX dataset_turnos_detalle_idx ON public.dataset_turnos_detalle USING btree (fecha_solicitud DESC);


--
-- TOC entry 7218 (class 1259 OID 509247)
-- Name: dataset_turnos_detalle_sede_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX dataset_turnos_detalle_sede_idx ON public.dataset_turnos_detalle USING btree (sede);


--
-- TOC entry 7186 (class 1259 OID 53271)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 7189 (class 1259 OID 53272)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 7208 (class 1259 OID 53771)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 7211 (class 1259 OID 53770)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 7278 (class 2606 OID 53213)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7277 (class 2606 OID 53208)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7276 (class 2606 OID 53199)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7280 (class 2606 OID 53228)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7279 (class 2606 OID 53223)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7282 (class 2606 OID 53242)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7281 (class 2606 OID 53237)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7285 (class 2606 OID 53295)
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7307 (class 2606 OID 331422)
-- Name: componentes_coordenadasparalelas_ejes componentes_coordena_columnaconorden_id_a4c9e16f_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_coordenadasparalelas_ejes
    ADD CONSTRAINT componentes_coordena_columnaconorden_id_a4c9e16f_fk_component FOREIGN KEY (columnaconorden_id) REFERENCES public.componentes_columnaconorden(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7308 (class 2606 OID 331427)
-- Name: componentes_coordenadasparalelas_ejes componentes_coordena_coordenadasparalelas_74ec2652_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_coordenadasparalelas_ejes
    ADD CONSTRAINT componentes_coordena_coordenadasparalelas_74ec2652_fk_component FOREIGN KEY (coordenadasparalelas_id) REFERENCES public.componentes_coordenadasparalelas(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7306 (class 2606 OID 320454)
-- Name: componentes_coordenadasparalelas componentes_coordena_paleta_color_id_7b76d96a_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_coordenadasparalelas
    ADD CONSTRAINT componentes_coordena_paleta_color_id_7b76d96a_fk_component FOREIGN KEY (paleta_color_id) REFERENCES public.componentes_paletacolor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7305 (class 2606 OID 320434)
-- Name: componentes_coordenadasparalelas componentes_coordena_view_asociada_id_c1d3e6ff_fk_db_views_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_coordenadasparalelas
    ADD CONSTRAINT componentes_coordena_view_asociada_id_c1d3e6ff_fk_db_views_ FOREIGN KEY (view_asociada_id) REFERENCES public.db_views_vista(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7299 (class 2606 OID 316476)
-- Name: componentes_diagramadeburbujas componentes_diagrama_paleta_color_id_986fb0c8_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_diagramadeburbujas
    ADD CONSTRAINT componentes_diagrama_paleta_color_id_986fb0c8_fk_component FOREIGN KEY (paleta_color_id) REFERENCES public.componentes_paletacolor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7300 (class 2606 OID 316481)
-- Name: componentes_diagramadeburbujas componentes_diagrama_view_asociada_id_1c11beec_fk_db_views_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_diagramadeburbujas
    ADD CONSTRAINT componentes_diagrama_view_asociada_id_1c11beec_fk_db_views_ FOREIGN KEY (view_asociada_id) REFERENCES public.db_views_vista(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7288 (class 2606 OID 54181)
-- Name: componentes_dona componentes_dona_view_asociada_id_1aace4a9_fk_db_views_vista_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_dona
    ADD CONSTRAINT componentes_dona_view_asociada_id_1aace4a9_fk_db_views_vista_id FOREIGN KEY (view_asociada_id) REFERENCES public.db_views_vista(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7286 (class 2606 OID 54186)
-- Name: componentes_grafico_cartesiano componentes_grafico__view_asociada_id_b91ddebd_fk_db_views_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_grafico_cartesiano
    ADD CONSTRAINT componentes_grafico__view_asociada_id_b91ddebd_fk_db_views_ FOREIGN KEY (view_asociada_id) REFERENCES public.db_views_vista(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7298 (class 2606 OID 316455)
-- Name: componentes_icono componentes_icono_coleccion_id_63a39658_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_icono
    ADD CONSTRAINT componentes_icono_coleccion_id_63a39658_fk_component FOREIGN KEY (coleccion_id) REFERENCES public.componentes_colecciondeiconos(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7297 (class 2606 OID 316450)
-- Name: componentes_iconoconrelleno componentes_iconocon_icono_id_e38a859d_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_iconoconrelleno
    ADD CONSTRAINT componentes_iconocon_icono_id_e38a859d_fk_component FOREIGN KEY (icono_id) REFERENCES public.componentes_icono(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7296 (class 2606 OID 311280)
-- Name: componentes_iconoconrelleno componentes_iconocon_view_asociada_id_b5869515_fk_db_views_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_iconoconrelleno
    ADD CONSTRAINT componentes_iconocon_view_asociada_id_b5869515_fk_db_views_ FOREIGN KEY (view_asociada_id) REFERENCES public.db_views_vista(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7293 (class 2606 OID 313157)
-- Name: componentes_mapaconburbujas componentes_mapaconb_mapa_id_4c15db3c_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_mapaconburbujas
    ADD CONSTRAINT componentes_mapaconb_mapa_id_4c15db3c_fk_component FOREIGN KEY (mapa_id) REFERENCES public.componentes_mapa(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7292 (class 2606 OID 311121)
-- Name: componentes_mapaconburbujas componentes_mapaconb_view_asociada_id_455b2edf_fk_db_views_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_mapaconburbujas
    ADD CONSTRAINT componentes_mapaconb_view_asociada_id_455b2edf_fk_db_views_ FOREIGN KEY (view_asociada_id) REFERENCES public.db_views_vista(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7294 (class 2606 OID 311245)
-- Name: componentes_radar componentes_radar_paleta_color_id_3f21c9ad_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_radar
    ADD CONSTRAINT componentes_radar_paleta_color_id_3f21c9ad_fk_component FOREIGN KEY (paleta_color_id) REFERENCES public.componentes_paletacolor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7295 (class 2606 OID 311250)
-- Name: componentes_radar componentes_radar_view_asociada_id_05eec05c_fk_db_views_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_radar
    ADD CONSTRAINT componentes_radar_view_asociada_id_05eec05c_fk_db_views_ FOREIGN KEY (view_asociada_id) REFERENCES public.db_views_vista(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7303 (class 2606 OID 331432)
-- Name: componentes_sunburst_anillos componentes_sunburst_columnaconorden_id_adbe86b2_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_sunburst_anillos
    ADD CONSTRAINT componentes_sunburst_columnaconorden_id_adbe86b2_fk_component FOREIGN KEY (columnaconorden_id) REFERENCES public.componentes_columnaconorden(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7301 (class 2606 OID 320348)
-- Name: componentes_sunburst componentes_sunburst_paleta_color_id_33a456fd_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_sunburst
    ADD CONSTRAINT componentes_sunburst_paleta_color_id_33a456fd_fk_component FOREIGN KEY (paleta_color_id) REFERENCES public.componentes_paletacolor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7304 (class 2606 OID 331437)
-- Name: componentes_sunburst_anillos componentes_sunburst_sunburst_id_241e8394_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_sunburst_anillos
    ADD CONSTRAINT componentes_sunburst_sunburst_id_241e8394_fk_component FOREIGN KEY (sunburst_id) REFERENCES public.componentes_sunburst(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7302 (class 2606 OID 320353)
-- Name: componentes_sunburst componentes_sunburst_view_asociada_id_20d1146f_fk_db_views_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_sunburst
    ADD CONSTRAINT componentes_sunburst_view_asociada_id_20d1146f_fk_db_views_ FOREIGN KEY (view_asociada_id) REFERENCES public.db_views_vista(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7289 (class 2606 OID 93031)
-- Name: componentes_tarjeta_doble componentes_tarjeta__view_asociada_id_19d4a810_fk_db_views_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_tarjeta_doble
    ADD CONSTRAINT componentes_tarjeta__view_asociada_id_19d4a810_fk_db_views_ FOREIGN KEY (view_asociada_id) REFERENCES public.db_views_vista(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7287 (class 2606 OID 54191)
-- Name: componentes_tarjeta componentes_tarjeta_view_asociada_id_849cd7cc_fk_db_views_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_tarjeta
    ADD CONSTRAINT componentes_tarjeta_view_asociada_id_849cd7cc_fk_db_views_ FOREIGN KEY (view_asociada_id) REFERENCES public.db_views_vista(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7309 (class 2606 OID 331442)
-- Name: componentes_treemap_jerarquias componentes_treemap__columnaconorden_id_dc5aea7e_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_treemap_jerarquias
    ADD CONSTRAINT componentes_treemap__columnaconorden_id_dc5aea7e_fk_component FOREIGN KEY (columnaconorden_id) REFERENCES public.componentes_columnaconorden(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7310 (class 2606 OID 331447)
-- Name: componentes_treemap_jerarquias componentes_treemap__treemap_id_7ef9f094_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_treemap_jerarquias
    ADD CONSTRAINT componentes_treemap__treemap_id_7ef9f094_fk_component FOREIGN KEY (treemap_id) REFERENCES public.componentes_treemap(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7291 (class 2606 OID 311135)
-- Name: componentes_treemap componentes_treemap_paleta_color_id_22276f97_fk_component; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_treemap
    ADD CONSTRAINT componentes_treemap_paleta_color_id_22276f97_fk_component FOREIGN KEY (paleta_color_id) REFERENCES public.componentes_paletacolor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7290 (class 2606 OID 311104)
-- Name: componentes_treemap componentes_treemap_view_asociada_id_c08828f6_fk_db_views_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.componentes_treemap
    ADD CONSTRAINT componentes_treemap_view_asociada_id_c08828f6_fk_db_views_ FOREIGN KEY (view_asociada_id) REFERENCES public.db_views_vista(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7283 (class 2606 OID 53261)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 7284 (class 2606 OID 53266)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2021-09-29 16:35:50 -03

--
-- PostgreSQL database dump complete
--

