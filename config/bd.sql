DROP DATABASE IF EXISTS DB;
CREATE DATABASE DB DEFAULT CHARACTER SET utf8;
USE DB;
	
CREATE TABLE Adresse(
id_adresse integer(10) auto_increment PRIMARY KEY,
code_postal VARCHAR(5) not null,
ville VARCHAR(60) not null,
rue VARCHAR(100) not null,
pays VARCHAR(60) not null
)ENGINE=INNODB;

-- OK
CREATE TABLE Boutique(
numboutique Integer(4) PRIMARY KEY,
adresse integer(10)
)ENGINE=InnoDB;
  
-- OK
CREATE TABLE Cause(
nom VARCHAR(60) PRIMARY KEY not null
)ENGINE=InnoDB;

  
CREATE TABLE Remise(
nom_remise VARCHAR(60) not null PRIMARY KEY,
prix_max DECIMAL(6,2) not null,
prix_min DECIMAL(6,2) not null,
taux DECIMAL(4,2) not null
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

CREATE TABLE Langue(
langue VARCHAR(60) not null primary key
)ENGINE=InnoDB;

-- OK
CREATE TABLE Moyen_Paiement(
moyenpaiement VARCHAR(30) not null PRIMARY KEY
)ENGINE=InnoDB;

CREATE TABLE Compte(
numcompte integer(7) not null primary key,
motpasse VARCHAR(40) not null,
etat VARCHAR(20) not null,
id_personne integer(6) not null
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
administrateur integer(7),
internaute integer(7),
CONSTRAINT FK_PERSONNE_ADMINISTRATEUR FOREIGN KEY (administrateur) REFERENCES Compte(numcompte),
CONSTRAINT FK_PERSONNE_INTERNAUTE FOREIGN KEY (internaute) REFERENCES Compte(numcompte),
CONSTRAINT FK_FACTURATION FOREIGN KEY (adresse_facturation) REFERENCES Adresse(id_adresse),
CONSTRAINT FK_LIVRAISON FOREIGN KEY (adresse_facturation) REFERENCES Adresse(id_adresse) 
)ENGINE=InnoDB;

ALTER TABLE Compte ADD constraint fk_COMPTE_PERSONNE foreign key (id_personne) references Personne(identifiant);
	
CREATE TABLE Commande(
numcommande Integer(8) not null primary key,
total decimal(8,2) not null,
commentaire VARCHAR(200) not null,
frais_livraison decimal(8,2) not null,
total_remise decimal(8,2) not null,
nom_remise varchar(60),
adresse_facturation integer(10),
adresse_livraison integer(10),
numero_facture integer(10),
numero_boutique integer(4) default -1,
langue varchar(60) not null,
moyen_paiement varchar(30) not null,
num_payeur integer(8) not null,
CONSTRAINT FK_COMMANDE_PERSONNE FOREIGN KEY(num_payeur) REFERENCES Personne(identifiant),
constraint FK_COMMANDE_MPAIEMENT FOREIGN KEY (moyen_paiement) references Moyen_Paiement(moyenpaiement),
constraint FK_COMMANDE_LANGUE FOREIGN KEY (langue) references Langue(langue),
constraint FK_COMMANDE_BOUTIQUE FOREIGN KEY (numero_boutique) references Boutique(numboutique),
constraint FK_COMMANDE_FACTURE FOREIGN KEY (numero_facture) references Facture(numerodocument),
constraint FK_COMMANDE_FACTURATION FOREIGN KEY (adresse_facturation) references Adresse(id_adresse),
constraint FK_COMMANDE_LIVRAISON FOREIGN KEY (adresse_livraison) references Adresse(id_adresse),
constraint FK_COMMANDE_REMISE FOREIGN KEY (nom_remise) References Remise(nom_remise)
)ENGINE=InnoDB;
  
-- A vérifier
CREATE TABLE Type_Colis(
nom_colis VARCHAR(60) not null primary key,
poids_supporter DECIMAL(5,2) not null,
nombre_boite_possible Integer(2) not null
)ENGINE=InnoDB;	
  
CREATE TABLE Locaux_de_stock(
numero Integer(5) not null primary key,
adresse Integer(10) not null,
constraint FK_LOCAUX_ADRESSE Foreign key (adresse) references Adresse(id_adresse)
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
numero Integer(10) not null primary key,
positionLibre TINYINT(1) not null,
numetagere integer(5) not null,
numtravee integer(5) not null,
numcouloir integer(5) not null,
numlocal integer(5) not null,
constraint FK_Emplacement_Stock foreign key (numetagere,numtravee,numcouloir, numlocal) references Etagere(numero,numtravee,numcouloir, numlocal)
)ENGINE=InnoDB;
  
CREATE TABLE Liste_Etat_Commande(
Etat VARCHAR(60) not null primary key
)ENGINE=InnoDB;

CREATE TABLE Historique_Etat(
idcommande integer(8) not null,
date TIMESTAMP not null,
etat varchar(60) not null,
constraint PK_HISTOETAT Primary key(idcommande,date,etat),
constraint FK_HISTOETAT_COMMANDE Foreign key (idcommande) references Commande(numcommande),
constraint FK_LISTETAT_COMMANDE Foreign key (etat) references Liste_Etat_Commande(etat)
)ENGINE=InnoDB;

CREATE TABLE Historique_Compte(
numcompte integer(7) not null, 
date TIMESTAMP not null,
etat VARCHAR(80) not null,
descriptions VARCHAR(80) not null,
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
reference Integer(10) not null primary key,
nom VARCHAR(60) not null,
poids DECIMAL(4,2) not null,
nombreboite Integer(8) not null,
stock_reserve Integer(4) not null,
stock_reel Integer(4) not null,
description VARCHAR(60) not null,
num_coffret integer(20)
)ENGINE=InnoDB;

CREATE TABLE Lots(
numero Integer(10) not null primary key,
num_produit integer(10) not null,
date_fabrication DATE not null,
date_peromption DATE not null,
emplacement Integer(20) not null,
constraint FK_LOTS_PRODUIT FOREIGN KEY (num_produit) References Produit(reference),
constraint FK_LOTS_EMPLACEMENT FOREIGN KEY (emplacement) References Emplacement_Stock(numero)
)ENGINE=InnoDB;

-- ok 
CREATE TABLE Coffret(
reference Integer(10) PRIMARY KEY,
CONSTRAINT FK_COFFRET_PRODUIT FOREIGN KEY (reference) REFERENCES Produit(reference)
)ENGINE=InnoDB;

ALTER TABLE Produit ADD constraint FK_PRODUIT_COFFRET Foreign key (num_coffret) references Coffret (reference);

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
num_destinataire integer(8),
num_livraison integer(7),
CONSTRAINT FK_SOUSCOMMANDE_LIVRAISON FOREIGN KEY(num_livraison) REFERENCES Bon_Livraison(numerodocument),
CONSTRAINT FK_SOUSCOMMANDE_PERSONNE FOREIGN KEY(num_destinataire) REFERENCES Personne(identifiant),
CONSTRAINT PK_SOUSCOMMANDE PRIMARY KEY(numcommande,numsouscommande),
CONSTRAINT FK_SOUSCOMMANDE FOREIGN KEY(numcommande) REFERENCES COMMANDE(numcommande) 
)ENGINE=InnoDB;

CREATE TABLE Colis(
identifiant integer(7) not null primary key,
date_envoie DATE not null,
type VARCHAR(60) not null,
numcommande integer(5) not null,
numsouscommande integer(5) not null,
constraint FK_COLIS_SOUSCOMMANDE FOREIGN KEY(numcommande,numsouscommande) references Sous_Commande(numcommande,numsouscommande),
constraint FK_COLIS_TYPE foreign key (type) references Type_Colis(nom_colis)
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

CREATE TABLE Quantite_Retour(
	num_retour integer(8) not null,
	num_lots integer(8) not null,
	quantite integer(4) not null,
	constraint PK_QTRETOUR PRIMARY KEY (num_retour,num_lots),
	constraint FK_QTRETOUR_RETOUR Foreign key (num_retour) references Retour(numero),
	constraint FK_QTRETOUR_LOTS Foreign key (num_lots) references Lots(numero) 
)Engine=Innodb;

CREATE TABLE Quantite_Emballer(
	num_colis integer(7) not null,
	num_lots integer(8) not null,
	quantite integer(4) not null,
	constraint PK_QTEMBALLER PRIMARY KEY (num_colis,num_lots),
	constraint FK_QTEMBALLER_COLIS Foreign key (num_colis) references Colis(identifiant),
	constraint FK_QTEMBALLER_LOTS Foreign key (num_lots) references Lots(numero) 
)Engine=Innodb;

CREATE TABLE Avoir_Cause(
	numero_retour integer(5),
	nom_cause varchar(60),
	constraint PK_AVOIR_CAUSE PRIMARY KEY(numero_retour,nom_cause),
	constraint FK_ACAUSE_RETOUR FOREIGN KEY (numero_retour) references Retour(numero),
	constraint FK_ACAUSE_CAUSE FOREIGN KEY (nom_cause) references Cause(nom)
)

ALTER TABLE Boutique ADD CONSTRAINT FK_BOUTIQUE_ADRESSE FOREIGN KEY (adresse) REFERENCES Adresse(id_adresse);
