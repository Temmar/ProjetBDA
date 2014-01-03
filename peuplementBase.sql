/*

Comment ajouter des termes au Thésaurus ?

-Définir en premier les concepts
-Puis les descripteurs vedettes en faisant références au concept
-Utiliser les tables imbriquées listeDescripteurV et listeDescripteurA pour étendre les termes associés au descripteur

Il arrive parfois qu'il n'y a pas de descripteur vedette à un autre descripteur. Dans ce cas là, mettre null.

Pour la table imbriqué listeDescripteurA, il faut écrire le nom de la relation en spécifiant en premier S pour synonyme
ou A pour antonyme puis le nom de cette relation. Par exemple : 'S pellicule'

Respectez une certaine indentation pour que l'on puisse s'y retrouver facilement.

*/

insert into concept values ('Cinéma',
                            'Art de composer et de réaliser des films cinématographiques. 
                            Métrage, avec ou sans enregistrement sonore,
                            comportant une séquence d images dont la projection, dans un ordre de succession rapide, donne l illusion du mouvement.',
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

insert into DescripteurVedette values (  'Acteur',
                                          'Artiste dont la profession est de jouer des rôles sur la scène du théâtre ou au cinéma ',
                                          (select ref(c) from concept c where c.libelle = 'Cinéma'),
                                          null,
                                          listeDescripteurA
                                          (
                                            t_relationA
                                            (
                                              'S théâtre',
                                              'Art de représenter sur scène des événements mettant en cause des êtres humains.',
                                              (select ref(v) from DescripteurVedette v where v.libelle = 'Film')       
					    ),
					    
					      t_relationA
                                            (
                                              'A Deutéragoniste',
                                              'dans l Antiquité, en tragédie grecque, acteur jouant un second rôle',
                                              (select ref(v) from DescripteurVedette v where v.libelle = 'Film')                                           ),
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
                                           'S Formation artistique', 'Activités d apprentissage offertes dans le domaine des arts.',null
                                          ),
                                          
                                            t_relationA
                                          (
                                           'A Sans talent','Personne qui n’a pas de capacités artistiques', null
                                          ),
                                          
                                            t_relationA
                                          (
                                           'A Spectateur',' Celui, celle qui assiste à un spectacle, à une représentation théâtrale,
							   à un événement sportif, à quelque exercice, à quelque grande cérémonie ou réjouissance publique',
                                           null
                                          )
                                        )                                     
                                  );
                                  
insert into DescripteurVedette values ('Réalisation cinématographique',
				       'Ensemble des opérations nécessaires pour passer d un projet, d un scénario, à un film, (du point de vue artistique)',
				       (select ref(c) from Concept c where c.libelle = 'Cinéma'), null, null
				      );
				      
				      
insert into DescripteurVedette values ('Salle de cinéma','Salle de spectacle où sont projetés des films', 
				       (select ref(c) from Concept c where c.libelle = 'Cinéma'),null,
				       
				       listeDescripteurA
				       (
				         t_relationA
				         (
				          'S Permis d exploitation de projection de films','Autorisation officielle de la Régie du cinéma.',
				          (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
				         ),
				         
				         t_relationA
				         (
				          'S Permis de commerçant au détail de matériel vidéo','Autorisation officielle de la Régie du cinéma.',
				          (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
				         )
				       )
                                      );
					
insert into DescripteurVedette values ('Epistémologie de l histoire du cinéma',
				       'Etude critique des conditions de création de l histoire ou des histoires du cinéma, des méthodes de recherche employées, etc.'
				      ,(select ref(c) from Concept c where c.libelle = 'Cinéma'), null,null				     
				      );
				      
				      
insert into DescripteurVedette values ('Citation','Désigne la citation cinématographique au cinéma',
					(select ref(c) from Concept c where c.libelle = 'Cinéma'),null,
					
					 listeDescripteurA
					 (
					   t_relationA
					   (
					    'S Remake','Film adapté à partir d un film existant précédemment',(
					   (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
					   ),
					   
					   t_relationA
					   (
					    'S parodie','Forme d humour qui utilise le cadre, les personnages, le style et le fonctionnement d une œuvre pour s en moquer',
					    (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
					    ),
					   
					   t_relationA
					   (
					    'S Mise en abyme','Procédé consistant à représenter une œuvre dans une œuvre du même type, par exemple en incrustant une image en elle-même.',
					    (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
					   )
					 )
				      );
				      
insert into DescripteurVedette values ('Économie du cinéma','branche de l économie de la culture qui s intéresse à la filière cinématographique',
					(select ref(c) from Concept c where c.libelle = 'Cinéma'),
					
					listeDescripteurV
					(
					  t_relationV
					  (
					   'Fiscalité','Taxes, amortissements, prêts, taxe professionnelle, traitements et salaires',
					   (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
					  )
					),
					
					listeDescripteurA
					(
					  t_relationA
					  (
					   'S Cinéma indépendant','Désigne les cinéastes, producteurs, distributeurs ou exploitants travaillant 
								   hors des conglomérats de production et des grands circuits de diffusion'
					   ,(select ref(v) from DescripteurVedette v where v.libelle = 'Film')
					  )
					  
					  t_relationA
					  ('S Rapport cinéma / jeu vidéo','Désigne les adaptations de jeux vidéo au cinéma ainsi que les jeux vidéo dérivés de films',
					    (select ref(v) from DescripteurVedette v where v.libelle = 'Film')
					  ),
					  
					  t_relationA
					  (
					   'A Dépenses liées au cinéma','Ensemble des moyens techniques et financier pour produire et réaliser un film',(select ref(v) from DescripteurVedette v where v.libelle = 'Film') 
					  )
					)					
				     );
				     
insert into DescripteurVedette values ('Indication de classement des films','Catégories établies pour identifier le classement des films 
									      par catégories en fonction de l âge minimum requis pour les voir',
		                        (select ref(c) from Concept c where c.libelle = 'Cinéma'), null, null
		                      );								  
