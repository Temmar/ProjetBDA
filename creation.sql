prompt *****Delete Existing Tables and Types*****
host cls;
drop table DescripteurAssocie;
drop table Concept;
drop table DescripteurVedette;
 
-----------------------------------
-- Creation de la base de donnée --
-----------------------------------
 
prompt *****Create Types*****
-- type concept
create or replace type t_concept
/
 
-- type descripteur
create or replace type t_descripteur as object (
    libelle     varchar(50),
    description     varchar(300)
) not final
/

create or replace type t_descripteurVedette
/
 
create or replace type t_relationV as object (
    NomRelation varchar(50), -- generalise ou spécialise
    Description varchar(300),
    Descrip ref t_descripteurVedette
)
/
-- Est soit un synonyme ou un antonyme
create or replace type t_relationA as object (
    NomRelation varchar(50) ,
    Description varchar(300),
    Descrip ref t_descripteur
)
/
 
create or replace type listeDescripteurV as table of t_relationV
/
 
create or replace type listeDescripteurA as table of t_relationA
/
 
-- type descripteur vedette
create or replace type t_descripteurVedette under t_descripteur(
    concept ref t_concept,
    child listeDescripteurV,
    associes listeDescripteurA
)
/
 
-- type concept
create or replace type t_concept as object(
    libelle     varchar(50),
    description varchar(300),
    decripteurVedette ref t_descripteurVedette
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
NESTED TABLE child store as desc_spec_gen ,
NESTED TABLE associes store as desc_syno_anto;
 
ALTER TABLE desc_syno_anto ADD CONSTRAINT ch_ds CHECK (NomRelation LIKE 'S%'OR NomRelation LIKE 'A%')
/

