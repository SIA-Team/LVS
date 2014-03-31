CREATE TABLE Activite_Compte(
date Integer(20) not null,
etat Integer(20) not null,
description Integer(20) not null,
pays Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Adresse(
code_postal Integer(20) not null,
ville Integer(20) not null,
rue Integer(20) not null,
pays Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Article(
refarticle Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Bon_Livraison(
numeroLivraison Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Boutique(
numboutique Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Cause(
nom Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Coffret(
Coffret Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Commande(
numcommande Integer(20) not null,
total Integer(20) not null,
commentaire Integer(20) not null,
frais_livraison Integer(20) not null,
total_remise Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Compte(
motpasse Integer(20) not null,
etat Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Colis:date_envoie(
Colis:date_envoie Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Couloir(
numero Integer(20) not null,
coï¿½t Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Document(
contenu Integer(20) not null,
date_creation Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Emplacement_Stock(
numero Integer(20) not null,
positionLibre Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Etagere(
numero Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Facture(
numeroFacture Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Formule_de_livraison(
nom_condition Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Moyen_Paiement(
moyenpaiement Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Historique_Compte(
date Integer(20) not null,
etat Integer(20) not null,
descriptions Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Historique_Etat(
date Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Langue(
langue Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Liste_Etat_Commande(
Etat Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Locaux_de_stock(
numero Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Lots(
numero Integer(20) not null,
date_fabrication Integer(20) not null,
date_peromption Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Personne(
identifiant Integer(20) not null,
telephone Integer(20) not null,
emailclient Integer(20) not null,
etat Integer(20) not null,
envoie_email Integer(20) not null,
envoie_catalogue Integer(20) not null,
adresse_facturation Integer(20) not null,
adresse_Livraison Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Personne_Morale(
SIRET Integer(20) not null,
denomination Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Personne_Physique(
nom Integer(20) not null,
prenom Integer(20) not null,
date_naissance Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Prestataire_Logistique(
denomination Integer(20) not null,
nomcontact Integer(20) not null,
telephone Integer(20) not null,
mail Integer(20) not null,
poids_min Integer(20) not null,
poids_max Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Prix(
prix Integer(20) not null,
date Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Produit(
reference Integer(20) not null,
nom Integer(20) not null,
poids Integer(20) not null,
nombreboite Integer(20) not null,
stock_reserve Integer(20) not null,
stock_reel Integer(20) not null,
description Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Produit_Simple(
Produit_Simple Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Profils(
identifiant Integer(20) not null,
nom Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Quantite_Produit(
id_commande integer(7) not null,
id_produit integer(7) not null,
quantite Integer(20) not null,
constraint pk_quantite_produit primary key (id_commande,id_produit),
constraint fk_quantite_produit_commande foreign key (id_commande) references Commande(numero),
constraint fk_quantite_produit_produit foreign key (id_produit) references Produit(numero)
)ENGINE=InnoDB;
  
CREATE TABLE Remise(
nom_remise VARCHAR(60) not null PRIMARY KEY,
prix_max DECIMAL(5,2) not null,
prix_min DECIMAL(5,2) not null,
taux DECIMAL(4,2) not null,
)ENGINE=InnoDB;
 
--A vérifier 
CREATE TABLE Retour(
numcommande Integer(8) not null,
numero integer(5) not null auto_increment PRIMARY KEY,
CONSTRAINT FK_RETOUR_COMMANDE FOREIGN KEY (numcommande) REFERENCES Commande(numero)
)ENGINE=InnoDB;

--A vérifier 
CREATE TABLE Sous-Commande(
numcommande integer(5) not null,
numsouscommande integer(5) not null,
nom VARCHAR(60) not null,
prenom VARCHAR(60) not null,
total DECIMAL(7,2) not null,
CONSTRAINT PK_SOUSCOMMANDE PRIMARY KEY(numcommande,numsouscommande),
CONSTRAINT FK_SOUSCOMMANDE FOREIGN KEY(numcommande) REFERENCES COMMANDE(numcommande) 
)ENGINE=InnoDB;
  
--A vérifier
CREATE TABLE Travee(
numero Integer(5) not null,
numcouloir Integer(5) not null,
numlocal Integer(5) not null,
CONSTRAINT PK_TRAVEE PRIMARY KEY(numero,numcouloir),
CONSTRAINT FK_TRAVEE_ETAGERE FOREIGN KEY (numcouloir,numlocal) REFERENCES Couloir(numero,numlocal)
)ENGINE=InnoDB;
  
--A vérifier
CREATE TABLE Type_Colis(
nom_colis VARCHAR(60) not null primary key,
poids_supporter DECIMAL(5,2) not null,
nombre_boite_possible Integer(2) not null,
)ENGINE=InnoDB;
 
--A vérifier
CREATE TABLE Type_Compte(
nom VARCHAR(60) not null PRIMARY KEY,
)ENGINE=InnoDB;
