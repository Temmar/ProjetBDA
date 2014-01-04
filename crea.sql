prompt *****Delete Existing Tables and Types*****
host cls;
drop table DescripteurAssocie force;
drop table Concept force;
drop table DescripteurVedette force;
drop type t_descripteurVedette force;
drop type listeDescripteurA	force;
drop type t_relationA force;
drop type t_relationV force;
drop type listeDescripteurV force;
drop type t_descripteur force;
drop type t_concept force;

-----------------------------------
-- Creation de la base de donnée --
-----------------------------------

prompt *****Create Types*****
-- type concept
create or replace type t_concept
/

-- type descripteur
create or replace type t_descripteur as object (
	libelle 	varchar(26)	
) not final
/
create or replace type t_descripteurVedette 
/

create or replace type t_relationV as object (
	NomRelation varchar(25), -- generalise , spécialise, autres ...
-- 'spec' pour dire qu'il spécialise un autre desc  
	Description varchar(150),
	ref_descrip ref t_descripteurVedette
)
/
-- check (value in ('S', 'A'))
-- constraint chk_nomR check(NomRelation in ('S', 'A'))
create or replace type t_relationA as object (
	NomRelation varchar(25) ,
	Description varchar(150),
	ref_descrip ref t_descripteur
)
/

create or replace type listeDescripteurV is table of t_relationV
/

create or replace type listeDescripteurA is table of t_relationA
/

-- type descripteur vedette
create or replace type t_descripteurVedette under t_descripteur(
	description 	varchar(150),
	ref_concept ref t_concept,
	spec_gen listeDescripteurV,
	associes listeDescripteurA
)
/

-- type concept
create or replace type t_concept as object(
	libelle		varchar(25),	
	ref_decripteurVedette ref t_descripteurVedette
)
/

prompt *****Create Tables*****
-- creation des tables
create table Concept of t_concept (
	primary key (libelle)	
);

create table DescripteurAssocie of t_descripteur (
	primary key (libelle)
);

create table DescripteurVedette of t_descripteurVedette (
	primary key (libelle)
)
NESTED TABLE spec_gen store as desc_spec_gen ,
NESTED TABLE associes store as desc_asso

--ALTER TABLE desc_syno_anto ADD CONSTRAINT
--ch_ds CHECK (NomRelation in ('S', 'A'))
-- il se peut qu'un discV soit spec ou gen par un desc non vedette
/
