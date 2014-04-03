;Insertion des adresses pour chacune des boutiques
INSERT INTO Adresse(id_adresse ,code_postal,ville,rue,pays) VALUES (1,"95150","TAVERNY","4 place de la liberté","FRANCE");
INSERT INTO Adresse(id_adresse ,code_postal,ville,rue,pays) VALUES (2,"75018","PARIS","Avenue FOCH","FRANCE");
INSERT INTO Adresse(id_adresse ,code_postal,ville,rue,pays) VALUES (3,"95330","DOMONT","95 rue de l'europe","FRANCE");
INSERT INTO Adresse(id_adresse ,code_postal,ville,rue,pays) VALUES (4,"13001","MARSEILLE","95 chaussée Jules César","FRANCE");

;Insertion des boutiques
INSERT INTO Boutique(numboutique,adresse) VALUES(1,1);
INSERT INTO Boutique(numboutique,adresse) VALUES(2,2);
INSERT INTO Boutique(numboutique,adresse) VALUES(3,3);
INSERT INTO Boutique(numboutique,adresse) VALUES(4,4);

;Insertion des causes
INSERT INTO Cause(nom) VALUES ("périmé");
INSERT INTO Cause(nom) VALUES ("erreur de livraison");

;Insertion des remises
INSERT INTO Remise(nom_remise,prix_max,prix_min,taux) VALUES ("Remise3%",229,381,3);
INSERT INTO Remise(nom_remise,prix_max,prix_min,taux) VALUES ("Remise5%",381,1220,5);
INSERT INTO Remise(nom_remise,prix_max,prix_min,taux) VALUES ("Remise5%",1220,9999.99,7);
