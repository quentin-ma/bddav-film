create schema public;

comment on schema public is 'standard public schema';

alter schema public owner to postgres;

create table utilisateur
(
	id serial not null
		constraint utilisateur_pk
			primary key,
	mail varchar not null,
	nom varchar not null,
	password varchar not null,
	type varchar not null
);

alter table utilisateur owner to quentinma;

create unique index utilisateur_mail_uindex
	on utilisateur (mail);

create unique index utilisateur_nom_uindex
	on utilisateur (nom);

create table film
(
	id serial not null
		constraint film_pk
			primary key,
	titre varchar not null,
	duree smallint not null
		constraint film_duree_check
			check (duree > 0),
	description text,
	nationalite varchar not null,
	date_sortie varchar not null,
	status varchar not null,
	budget integer
);

alter table film owner to quentinma;

create unique index film_titre_uindex
	on film (titre);

create table critique
(
	id_film integer not null
		constraint critique_film_id_fk
			references film,
	id_utilisateur integer not null
		constraint critique_utilisateur_id_fk_2
			references utilisateur,
	date date not null,
	message varchar(999) not null,
	note integer not null
		constraint critique_note_check
			check ((note >= 0) AND (note <= 5))
);

alter table critique owner to quentinma;

create unique index critique_id_film_id_utilisateur_uindex
	on critique (id_film, id_utilisateur);

create index critique_note_index
	on critique (note);

create table etablissement
(
	id serial not null
		constraint etablissement_pk
			primary key,
	nom varchar not null,
	adresse varchar not null,
	commune varchar not null,
	code varchar not null,
	ecran integer,
	fauteuil integer
);

alter table etablissement owner to quentinma;

create table salle
(
	id serial not null
		constraint salle_pk
			primary key,
	capacite integer not null
		constraint salle_capacite_check
			check (capacite > 0),
	id_etablissement integer
		constraint salle_etablissement_id_fk
			references etablissement
);

alter table salle owner to quentinma;

create table seance
(
	id_film integer not null
		constraint seance_film_id_fk
			references film,
	id_salle integer not null
		constraint seance_salle_id_fk
			references salle,
	horaire date not null,
	constraint seance_pk
		primary key (id_film, id_salle)
);

alter table seance owner to quentinma;

create unique index seance_id_film_id_salle_uindex
	on seance (id_film, id_salle);

create table role
(
	id serial not null
		constraint role_pk
			primary key,
	nom varchar not null
);

alter table role owner to quentinma;

create table personnalite
(
	id_film integer
		constraint personnalite_film_id_fk
			references film,
	id_role integer
		constraint personnalite_role_id_fk
			references role,
	nom varchar not null,
	date_naissance date not null,
	nationalite varchar not null
);

alter table personnalite owner to quentinma;

create unique index personnalite_id_film_id_role_uindex
	on personnalite (id_film, id_role);

create table genre
(
	id integer not null
		constraint genre_pk
			unique,
	name varchar not null,
	id_film integer not null
		constraint genre_film_id_fk
			references film,
	constraint genre_pk_2
		primary key (id, id_film)
);

alter table genre owner to quentinma;

create unique index genre_id_uindex
	on genre (id);

create table motcle
(
	id integer not null,
	id_film integer not null
		constraint motcle_film_id_fk
			references film,
	name varchar not null,
	constraint motcle_pk
		primary key (id, id_film)
);

alter table motcle owner to quentinma;

create unique index motcle_id_film_uindex
	on motcle (id_film);

create unique index motcle_id_uindex
	on motcle (id);

