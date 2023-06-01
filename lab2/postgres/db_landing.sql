-- Table: public.departement

-- DROP TABLE IF EXISTS public.departement;

CREATE TABLE IF NOT EXISTS public.departement
(
    nom text COLLATE pg_catalog."default",
    numero text COLLATE pg_catalog."default",
    region text COLLATE pg_catalog."default",
    superficie bigint,
    population bigint,
    densite numeric,
    CONSTRAINT departement_pkey PRIMARY KEY (numero)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.departement
    OWNER to postgres;

-- Table: public.product

-- DROP TABLE IF EXISTS public.product;

CREATE TABLE IF NOT EXISTS public.product
(
    id bigint NOT NULL,
    name text COLLATE pg_catalog."default",
    price numeric,
    CONSTRAINT product_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product
    OWNER to postgres;

-- Table: public.purshase

-- DROP TABLE IF EXISTS public.purshase;

CREATE TABLE IF NOT EXISTS public.purshase
(
    id bigint NOT NULL,
    product bigint,
    quantity bigint,
    requester bigint,
    status text COLLATE pg_catalog."default",
    request_date date,
    validation_time smallint,
    CONSTRAINT purshase_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.purshase
    OWNER to postgres;

-- Table: public.user

-- DROP TABLE IF EXISTS public."user";

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    first_name text COLLATE pg_catalog."default",
    last_name text COLLATE pg_catalog."default",
    departement text COLLATE pg_catalog."default",
    CONSTRAINT user_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;