/*

Comment ajouter des termes au Thésaurus ?

-Définir en premier les concepts
-Puis les descripteurs vedettes en faisant références au concept
-Utiliser les tables imbriquées listeDescripteurV et listeDescripteurA pour étendre les termes associés au descripteur

Il arrive parfois qu'il n'y a pas de descripteur vedette à un autre descripteur. Dans ce cas là, mettre nul.

Pour la table imbriqué listeDescripteurA, il faut écrire le nom de la relation en spécifiant en premier S pour synonyme
ou A pour antonyme puis le nom de cette relation. Par exemple : 'S pellicule'

Respectez une certaine indentation pour que l'on puisse s'y retrouver facilement.

*/

insert into concept values ('Cinéma',
                            'Art de composer et de réaliser des films cinématographiques. 
                            Métrage, avec ou sans enregistrement sonore,
                            comportant une séquence d images dont la projection, dans un ordre de succession rapide, donne l illusion du mouvement.',
                            null);
                          
                            
insert into concept values ('Acteur',
                            'Artiste dont la profession est de jouer des rôles sur la scène du théâtre ou au cinéma ',
                            null);                            
                          


insert into DescripteurVedette values ( 'Film',
                                        'Pellicule utilisée en photographie et au cinéma',
                                        (select ref(c) from concept c where c.libelle = 'Cinéma'),
                                        
                                        listeDescripteurV
                                        (
                                            t_relationV
                                            (
                                              'Cinéma d auteur',
                                              'Type de cinéma dans lequel le réalisateur, perçu comme unique auteur de son film, présente à travers son art un univers qui lui est propre.',
                                              (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
                                            ),
                                            
                                            t_relationV
                                            (
                                              'Film d animation',
                                              'Film cinématographique réalisé en partant d une suite de dessins représentant les phases successives du mouvement du corps.',
                                              (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
                                            ),            
                                                      
                                           t_relationV
                                           (
                                            'Doublage',
                                            'Ensemble des opérations de postsynchronisation au cours desquelles des artistes enregistrent le dialogue en langue étrangère constituant l équivalent du dialogue original d un film.',
                                            (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
                                           )
                                        ),
                                        
                                        listeDescripteurA
                                        (
                                          t_relationA
                                          (
                                            'S pellicule',
                                            'Bande recouverte d une matière sensible à la lumière et destinée au cinéma',
                                            (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
                                          ),
                                          
                                          t_relationA
                                          (
                                            'S production',
                                            'Action de produire un film ou un spectacle',
                                            (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
                                          )
                                        )
                                          
                                );

insert into DescripteurVedette values ( 
                                          'Acteur',
                                          'Artiste dont la profession est de jouer des rôles sur la scène du théâtre ou au cinéma ',
                                          (select ref(c) from concept c where c.libelle = 'Acteur'),
                                          null,
                                          listeDescripteurA
                                          (
                                            t_relationA
                                            (
                                              'S théâtre',
                                              'Art de représenter sur scène des événements mettant en cause des êtres humains.',
                                              (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
                                            )                                          
                                          )
                                      );

insert into DescripteurVedette values ( 'Artiste',
                                        'Personne qui crée ou interprète des oeuvres d"art',
                                        (select ref(c) from concept c where c.libelle = 'Cinéma'),
                                        listeDescripteurV
                                        (
                                          t_relationV
                                          (
                                           'Compositeur', 
                                           'Personne qui crée l expression d idées et de sentiments sous forme de compositions musicales telles que symphonies, sonates ou opéras',
                                           (select ref(v) from DescripteurVedette v where v.libelle = 'Artiste')
                                          ),
                                          
                                           t_relationV
                                          (
                                           'Danseur',
                                           'Personne dont la profession est la danse',
                                           (select ref(v) from DescripteurVedette v where v.libelle = 'Artiste')
                                          ),
                                          
                                           t_relationV
                                          (
                                           'Écrivain',
                                           'Personne qui compose des ouvrages littéraires',
                                           (select ref(v) from DescripteurVedette v where v.libelle = 'Artiste')
                                          ),
                                          
                                           t_relationV
                                          (
                                           'Musicien',
                                           'Individu qui compose ou exécute des morceaux de musique',
                                           (select ref(v) from DescripteurVedette v where v.libelle = 'Artiste')
                                          )          
                                  
                                        ),
                                        
                                        listeDescripteurA
                                        (
                                          t_relationA
                                          (
                                           'S Acteur',
                                           'Artiste dont la profession est de jouer des rôles sur la scène du théâtre ou au cinéma',
                                           (select ref(v) from DescripteurVedette v where v.libelle = 'Acteur')
                                          ),
                                          
                                          t_relationA
                                          (
                                           'S Arts',
                                           'Ensemble de disciplines artistiques, notamment celles qui sont consacrées à la beauté des lignes et des formes, appelées aussi beaux-arts',
                                           null
                                          ),
                                          t_relationA
                                          (
                                           'S Formation artistique',
                                           'Activités d apprentissage offertes dans le domaine des arts.',
                                           null
                                          )
                                        )                                     
                                  );
                                  
insert into DescripteurAssocie values (
  'Cinémathèque',
  'Organisme d archivage et/ou de diffusion de documents cinématographiques'
); 

insert into DescripteurAssocie values (
  'Industrie cinématographique',
  'Ensemble des activités d aspect commercial, relatives au monde du cinéma et qui sont généralement basées sur la production, la promotion et la diffusion des produits cinématographiques.'
);                                        

                             
                                     
