--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

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
-- Name: guardian_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guardian_tokens (
    jti character varying(255) NOT NULL,
    aud character varying(255) NOT NULL,
    typ character varying(255),
    iss character varying(255),
    sub character varying(255),
    exp bigint,
    jwt text,
    claims jsonb,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: requirements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.requirements (
    id uuid NOT NULL,
    type character varying(255),
    subject uuid,
    requirement uuid,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subjects (
    id uuid NOT NULL,
    name character varying(255),
    hours integer,
    professor uuid,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    name character varying(255),
    cpf character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255),
    role character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: guardian_tokens guardian_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guardian_tokens
    ADD CONSTRAINT guardian_tokens_pkey PRIMARY KEY (jti, aud);


--
-- Name: requirements requirements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requirements
    ADD CONSTRAINT requirements_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: requirements_requirement_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX requirements_requirement_index ON public.requirements USING btree (requirement);


--
-- Name: requirements_subject_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX requirements_subject_index ON public.requirements USING btree (subject);


--
-- Name: subjects_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX subjects_name_index ON public.subjects USING btree (name);


--
-- Name: subjects_professor_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subjects_professor_index ON public.subjects USING btree (professor);


--
-- Name: users_cpf_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_cpf_index ON public.users USING btree (cpf);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: requirements requirements_requirement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requirements
    ADD CONSTRAINT requirements_requirement_fkey FOREIGN KEY (requirement) REFERENCES public.subjects(id);


--
-- Name: requirements requirements_subject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requirements
    ADD CONSTRAINT requirements_subject_fkey FOREIGN KEY (subject) REFERENCES public.subjects(id);


--
-- Name: subjects subjects_professor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_professor_fkey FOREIGN KEY (professor) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20210510162444);
INSERT INTO public."schema_migrations" (version) VALUES (20210517230640);
INSERT INTO public."schema_migrations" (version) VALUES (20210521221257);
INSERT INTO public."schema_migrations" (version) VALUES (20210521222006);
INSERT INTO public."schema_migrations" (version) VALUES (20210522043336);
