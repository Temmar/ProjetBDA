/*
  Permet de cree un concept
  Va cree un concept puis le descripteur vedette associe
  puis modifira le concept pour mettre a jour le lien
*/

create or replace procedure createConcept (nomConcept varchar, nomDescripteur varchar, description varchar) 
is
  descr_ok varchar(50);
  
  nom_concept exception;
    
  begin

      if nomConcept is not null then
        insert into CONCEPT values (nomConcept , null);
        createDescripteurVedette(nomDescripteur, description, nomConcept);
        update CONCEPT set ref_decripteurVedette = (select ref(c) from DescripteurVedette c where libelle = nomDescripteur) where libelle = nomConcept;
      else
        raise nom_concept;
      end if;
  
    COMMIT;

    EXCEPTION
    WHEN nom_concept then
        dbms_output.put_line('Le nom du concept est null');
    WHEN OTHERS THEN
            raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
            ROLLBACK;
  
end;


/*
  Fonction de creation d'un descripteur vedette
    Va cree le descripteur vedette et mettre le lien vers le concept referent
*/
create or replace procedure createDescripteurVedette(nom varchar, description varchar, nomConcept varchar)
is
  -- les differents cas d'erreurs possible a gerer
  descr_existe exception;
  descr_nom_null exception;
  concept_null exception; 
  
begin
  
  if nomConcept is not null then
    if nom is not null then
      insert into descripteurVedette values (nom, description, (select ref(c) from CONCEPT c where libelle = nomConcept), null, null);
    else
        raise descr_nom_null;
    end if;
  else 
    raise concept_null;
  end if;
  COMMIT;
   
   exception 
     WHEN descr_nom_null then
        dbms_output.put_line('Nom Manquant pour le descripteur');
     WHEN concept_null then
        dbms_output.put_line('Aucun concept a referencer pour le descripteur');
     WHEN OTHERS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        ROLLBACK;
        
end;
