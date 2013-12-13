--                                     (libelle     varchar(50),
--                                      description     varchar(150))
insert into DescripteurAssocie values ( 'Série',
                                        '');

 
--                         ( libelle    varchar(50),
--                           description    varchar(150),
--                           decripteurVedette ref t_descripteurVedette)
insert into concept values ('Film',
                            'Pellicule utilisée en photographie et au cinéma',
                            null);
insert into concept values ('Acteur',
                            'Artiste dont la profession est de jouer des rôles sur la scène du théâtre ou au cinéma ',
                            null);
 
 
--                                  ( libelle   varchar(50),
--                                    description   varchar(150)
--                                    concept ref t_concept,
--                                    child listeDescripteurV,
--                                    associer listeDescripteurA

insert into DescripteurVedette values ( 'Film',
                                        'Pellicule utilisée en photographie et au cinéma',
                                        select ref(c) from concept c where c.libelle = 'Film');
insert into DescripteurVedette values ( 'Acteur',
                                        'Artiste dont la profession est de jouer des rôles sur la scène du théâtre ou au cinéma ',
                                        select ref(c) from concept c where c.libelle = 'Acteur');
insert into DescripteurVedette values ( 'Artiste',
                                        'Personne qui crée ou interprète des oeuvres d"art',
                                        select ref(c) from concept c where c.libelle = 'Artiste');
