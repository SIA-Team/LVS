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
quantite Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Remise(
nom_remise Integer(20) not null,
prix_max Integer(20) not null,
prix_min Integer(20) not null,
taux Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Retour(
numero Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Sous-Commande(
nom Integer(20) not null,
prenom Integer(20) not null,
total Integer(20) not null,
remise_total Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Travee(
numero Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Type_Colis(
nom_colis Integer(20) not null,
poids_supporter Integer(20) not null,
nombre_boite_possible Integer(20) not null,
  
)ENGINE=InnoDB;
  
CREATE TABLE Type_Compte(
nom Integer(20) not null,
  
)ENGINE=InnoDB;
