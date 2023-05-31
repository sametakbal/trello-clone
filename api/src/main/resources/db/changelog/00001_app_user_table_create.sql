CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS app_user
(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    login character varying(50) NOT NULL,
    password_hash character varying(60) NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(191),
    image_url character varying(256),
    activated boolean NOT NULL,
    lang_key character varying(10),
    activation_key character varying(20),
    reset_key character varying(20),
    created_by character varying(50) NOT NULL,
    created_date timestamp without time zone,
    reset_date timestamp without time zone,
    last_modified_by character varying(50),
    last_modified_date timestamp without time zone,
    CONSTRAINT app_user_pkey PRIMARY KEY (id),
    CONSTRAINT ux_user_email UNIQUE (email),
    CONSTRAINT ux_user_login UNIQUE (login)
);

CREATE TABLE IF NOT EXISTS authority
(
    name character varying(50) NOT NULL,
    CONSTRAINT authority_pkey PRIMARY KEY (name)
);

CREATE TABLE IF NOT EXISTS user_authority
(
    user_id uuid NOT NULL,
    authority_name character varying(50) NOT NULL,
    CONSTRAINT app_user_authority_pkey PRIMARY KEY (user_id, authority_name),
    CONSTRAINT fk_authority_name FOREIGN KEY (authority_name)
        REFERENCES authority (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id)
        REFERENCES app_user (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

