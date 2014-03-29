DROP DATABASE IF EXISTS DB;
CREATE DATABASE DB DEFAULT CHARACTER SET utf8;
USE DB;
	
CREATE TABLE Adresse(
id_adresse integer(100) auto_increment PRIMARY KEY,
code_postal VARCHAR(5) not null,
ville VARCHAR(60) not null,
rue VARCHAR(100) not null,
pays VARCHAR(60) not null
)ENGINE=INNODB;

-- OK
CREATE TABLE Boutique(
numboutique Integer(4) PRIMARY KEY
)ENGINE=InnoDB;
  
-- OK
CREATE TABLE Cause(
nom VARCHAR(60) PRIMARY KEY not null
)ENGINE=InnoDB;
  
CREATE TABLE Commande(
numcommande Integer(8) not null primary key,
total decimal(8,2) not null,
commentaire VARCHAR(200) not null,
frais_livraison decimal(8,2) not null,
total_remise decimal(8,2) not null
)ENGINE=InnoDB;
  
-- A vérifier
CREATE TABLE Type_Colis(
nom_colis VARCHAR(60) not null primary key,
poids_supporter DECIMAL(5,2) not null,
nombre_boite_possible Integer(2) not null
)ENGINE=InnoDB;	
	
CREATE TABLE Colis(
identifiant integer(7) not null primary key,
date_envoie Integer(20) not null,
type VARCHAR(60) not null,
constraint FK_COLIS_TYPE foreign key (type) references Type_Colis(nom_colis)
)ENGINE=InnoDB;
  
CREATE TABLE Document(
numero integer(7) not null primary key,
contenu TEXT(400) not null,
date_creation date not null
)ENGINE=InnoDB;

CREATE TABLE Bon_Livraison(
numerodocument integer(7) primary key,
numeroLivraison Integer(7) not null,
CONSTRAINT FK_Bon_Livraison_numerodocument FOREIGN KEY (numerodocument) REFERENCES DOCUMENT(numero)
)ENGINE=InnoDB;

CREATE TABLE Facture(
numerodocument integer(7) primary key,
numfacture integer(7) not null,
CONSTRAINT FK_FACTURE_DOCUMENT FOREIGN KEY (numerodocument) REFERENCES DOCUMENT(numero)
)ENGINE=InnoDB;
  
CREATE TABLE Locaux_de_stock(
numero Integer(5) not null primary key
)ENGINE=InnoDB;
  	
CREATE TABLE Couloir(
numero Integer(5) not null,
numlocal Integer(5) not null,
cout Integer(5) not null,
CONSTRAINT PK_TRAVEE PRIMARY KEY(numero,numlocal),
CONSTRAINT FK_TRAVEE_ETAGERE FOREIGN KEY (numlocal) REFERENCES Locaux_de_stock(numero)
)ENGINE=InnoDB;

-- A vérifier
CREATE TABLE Travee(
numero Integer(5) not null,
numcouloir Integer(5) not null,
numlocal Integer(5) not null,
CONSTRAINT PK_TRAVEE PRIMARY KEY(numero,numcouloir,numlocal),
CONSTRAINT FK_TRAVEE_COULOIR FOREIGN KEY (numcouloir,numlocal) REFERENCES Couloir(numero,numlocal)
)ENGINE=InnoDB;
	
CREATE TABLE Etagere(
numero Integer(5) not null,
numtravee integer(5) not null,
numcouloir integer(5) not null,
numlocal integer(5) not null,
constraint PK_Etagere Primary key (numero,numtravee,numcouloir,numlocal),
constraint FK_Etagere foreign key (numtravee,numcouloir,numlocal) References Travee(numero,numcouloir,numlocal)
)ENGINE=InnoDB;	
	
CREATE TABLE Emplacement_Stock(
numero Integer(20) not null primary key,
positionLibre TINYINT(1) not null,
numetagere integer(5) not null,
numtravee integer(5) not null,
numcouloir integer(5) not null,
numlocal integer(5) not null,
constraint FK_Emplacement_Stock foreign key (numetagere,numtravee,numcouloir, numlocal) references Etagere(numero,numtravee,numcouloir, numlocal)
)ENGINE=InnoDB;
  
-- OK
CREATE TABLE Moyen_Paiement(
moyenpaiement VARCHAR(30) not null PRIMARY KEY
)ENGINE=InnoDB;
  
CREATE TABLE Langue(
langue VARCHAR(60) not null primary key
)ENGINE=InnoDB;
  
CREATE TABLE Liste_Etat_Commande(
Etat VARCHAR(60) not null primary key
)ENGINE=InnoDB;

CREATE TABLE Historique_Etat(
idcommande integer(8) not null,
date Integer(20) not null,
etat varchar(60) not null,
constraint PK_HISTOETAT Primary key(idcommande,date,etat),
constraint FK_HISTOETAT_COMMANDE Foreign key (idcommande) references Commande(numcommande)
)ENGINE=InnoDB;

CREATE TABLE Lots(
numero Integer(20) not null primary key,
date_fabrication Integer(20) not null,
date_peromption Integer(20) not null,
emplacement Integer(20) not null,
constraint FK_LOTS_EMPLACEMENT FOREIGN KEY (emplacement) References Emplacement_Stock(numero)
)ENGINE=InnoDB;
  
-- OK
CREATE TABLE Personne(
identifiant Integer(6) not null PRIMARY KEY AUTO_INCREMENT,
telephone VARCHAR(10) not null,
emailclient VARCHAR(60) not null,
etat ENUM ('BLOQUER','EN ATTENTE DE CONFIRMATION', 'ACTIF','FERME') not null default 'EN ATTENTE DE CONFIRMATION',
envoie_email ENUM('OUI','NON') not null default 'OUI',
envoie_catalogue ENUM('OUI','NON') not null default 'OUI',
adresse_facturation Integer(10) not null,
adresse_livraison Integer(10) not null,
CONSTRAINT FK_FACTURATION FOREIGN KEY (adresse_facturation) REFERENCES Adresse(id_adresse),
CONSTRAINT FK_LIVRAISON FOREIGN KEY (adresse_facturation) REFERENCES Adresse(id_adresse) 
)ENGINE=InnoDB;

  
CREATE TABLE Compte(
numcompte integer(7) not null primary key,
motpasse VARCHAR(40) not null,
etat VARCHAR(20) not null,
id_personne integer(6) not null,
constraint fk_COMPTE_PERSONNE foreign key (id_personne) references Personne(identifiant)
)ENGINE=InnoDB;

CREATE TABLE Historique_Compte(
numcompte integer(7) not null, 
date Integer(20) not null,
etat Integer(20) not null,
descriptions Integer(20) not null,
constraint PK_HISTOCOMPTE Primary key (numcompte,date),
constraint FK_HISTOCOMPTE foreign key (numcompte) references Compte(numcompte)
)ENGINE=InnoDB;
  
  
-- OK
CREATE TABLE Personne_Morale(
identifiant Integer(6) not null PRIMARY KEY,
SIRET VARCHAR(60) not null,
denomination VARCHAR(60) not null,
CONSTRAINT HE_PERSONNE_MORALE FOREIGN KEY (identifiant) REFERENCES Personne(identifiant)
)ENGINE=InnoDB;
  
-- ok
CREATE TABLE Prestataire_Logistique(
denomination VARCHAR(60) PRIMARY KEY,
nomcontact VARCHAR(60) not null,
telephone VARCHAR(10) not null,
mail VARCHAR(60) not null,
poids_min Decimal(5,2) not null,
poids_max Decimal(5,2) not null
)ENGINE=InnoDB;

CREATE TABLE Formule_de_livraison(
nom_condition Integer(20) not null primary key,
prestataire VARCHAR(60) not null,
constraint FK_FORMULE_PRESTATAIRE Foreign key (prestataire) references Prestataire_Logistique (denomination)
)ENGINE=InnoDB;
  
CREATE TABLE Produit(
reference Integer(20) not null primary key,
nom Integer(20) not null,
poids Integer(20) not null,
nombreboite Integer(20) not null,
stock_reserve Integer(20) not null,
stock_reel Integer(20) not null,
description Integer(20) not null
  
)ENGINE=InnoDB;

-- ok 
CREATE TABLE Coffret(
reference Integer(10) PRIMARY KEY,
CONSTRAINT FK_COFFRET_PRODUIT FOREIGN KEY (reference) REFERENCES Produit(reference)
)ENGINE=InnoDB;

CREATE TABLE Prix(
reference Integer(10) not null,
date Integer(20) not null,
prix Integer(20) not null,
CONSTRAINT PK_Prix primary key (reference,date),
CONSTRAINT FK_prix_produit FOREIGN KEY (reference) REFERENCES Produit(reference)
)ENGINE=InnoDB;

CREATE TABLE Produit_Simple(
reference Integer(10) PRIMARY KEY,
CONSTRAINT FK_PSIMPLE_PRODUIT FOREIGN KEY (reference) REFERENCES PRODUIT(reference)
)ENGINE=InnoDB;
  
CREATE TABLE Profils(
identifiant Integer(5) not null primary key,
nom VARCHAR(60) not null
)ENGINE=InnoDB;
  
CREATE TABLE Quantite_Produit(
id_commande integer(8) not null,
id_produit integer(20) not null,
quantite Integer(20) not null,
constraint pk_quantite_produit primary key (id_commande,id_produit),
constraint fk_quantite_produit_commande foreign key (id_commande) references Commande(numcommande),
constraint fk_quantite_produit_produit foreign key (id_produit) references Produit(reference)
)ENGINE=InnoDB;
  
CREATE TABLE Remise(
nom_remise VARCHAR(60) not null PRIMARY KEY,
prix_max DECIMAL(5,2) not null,
prix_min DECIMAL(5,2) not null,
taux DECIMAL(4,2) not null
)ENGINE=InnoDB;
 
-- A vérifier 
CREATE TABLE Retour(
numcommande Integer(8) not null,
numero integer(5) not null auto_increment PRIMARY KEY,
CONSTRAINT FK_RETOUR_COMMANDE FOREIGN KEY (numcommande) REFERENCES Commande(numcommande)
)ENGINE=InnoDB;

-- A vérifier 
CREATE TABLE Sous_Commande(
numcommande integer(5) not null,
numsouscommande integer(5) not null,
nom VARCHAR(60) not null,
prenom VARCHAR(60) not null,
total DECIMAL(7,2) not null,
CONSTRAINT PK_SOUSCOMMANDE PRIMARY KEY(numcommande,numsouscommande),
CONSTRAINT FK_SOUSCOMMANDE FOREIGN KEY(numcommande) REFERENCES COMMANDE(numcommande) 
)ENGINE=InnoDB;
  
-- A vérifier
CREATE TABLE Type_Compte(
nom VARCHAR(60) not null PRIMARY KEY
)ENGINE=InnoDB;

CREATE TABLE Appartenir(
	idprofil integer(7) not null,
	idpersonne integer(7) not null,
	constraint pk_appartenir primary key (idprofil,idpersonne),
	constraint fk_appartenir_profil foreign key (idprofil) references Profils(identifiant),
	constraint fk_appartenir_personne foreign key (idpersonne) references Personne(identifiant)
)ENGINE=Innodb;

CREATE TABLE Se_poser(
	numlots integer(7) not null,
	numemplacement integer(7) not null,
	constraint PK_SEPOSER PRIMARY KEY(numlots,numemplacement),
	constraint FK_SEPOSER_LOTS Foreign key (numlots) References Lots(numero),
	constraint FK_SEPOSER_EMPLACEMENT Foreign key (numemplacement) References Emplacement_Stock(numero)
)Engine=Innodb;
