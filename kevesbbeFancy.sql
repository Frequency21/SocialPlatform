/*Valaki, aki nincs annyira rajta a szopó vagonon, megtudja majd csinálni az
'IF EXISTS'-es DROP-ot, nekem mingid, azt dobja, hogy:
ORA-00933: az SQL parancs nem megfelelően ér véget
00933. 00000 -  "SQL command not properly ended"

Ennek az az oka, hogy a DROP TABLE IF EXISTS az nem létező ORACLE-ben.*/
DROP TABLE Komment CASCADE CONSTRAINTS;
DROP TABLE Felhasznalo CASCADE CONSTRAINTS;
DROP TABLE Hirfolyam CASCADE CONSTRAINTS;
DROP TABLE Csoport CASCADE CONSTRAINTS;
DROP TABLE Poszt CASCADE CONSTRAINTS;
DROP TABLE Uzenet CASCADE CONSTRAINTS;
DROP TABLE Meghivas CASCADE CONSTRAINTS;
DROP TABLE Fenykepalbum CASCADE CONSTRAINTS;
DROP TABLE Kategoria CASCADE CONSTRAINTS;
DROP TABLE Fenykep CASCADE CONSTRAINTS;
DROP TABLE Tagja CASCADE CONSTRAINTS;
DROP TABLE Ismeros CASCADE CONSTRAINTS;
DROP TYPE NEVTIPUS;
DROP TYPE ERTEKELES;

CREATE TYPE NEVTIPUS AS OBJECT (
    keresztnev VARCHAR(10),
    vezeteknev VARCHAR(10)
);
/

CREATE TYPE ERTEKELES AS OBJECT (
    like_szamlalo    NUMBER,
    dislike_szamlalo NUMBER
);
/


CREATE TABLE Hirfolyam(
    ID              NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY
);
/

CREATE TABLE Felhasznalo (
    ID              NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    jelszo          VARCHAR2(32) NOT NULL,
    nev             NEVTIPUS NOT NULL,
    csatl_dat       TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    szul_dat        DATE NOT NULL,
    munka_iskola    VARCHAR2(64),
    picture         BLOB,
    isAdmin         NUMBER(1,0) NOT NULL
);
/


CREATE TABLE Csoport(
    csoport_id      NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    leiras          VARCHAR2(128),
    nev             VARCHAR2(16) NOT NULL,
    tulaj_id        NUMBER NOT NULL,
    CONSTRAINT FK_Csoport_Felhasznalo FOREIGN KEY (tulaj_id) REFERENCES Felhasznalo(ID)
);
/

CREATE TABLE Poszt(
    idopont         TIMESTAMP WITH LOCAL TIME ZONE PRIMARY KEY,
    hirfolyam_id    NUMBER NOT NULL,
    felhasznalo_id  NUMBER NOT NULL,
    szoveg          VARCHAR2(128) NOT NULL,
    ertekeles       ERTEKELES NOT NULL,
    isPublic        NUMBER(1,0) NOT NULL,
    CONSTRAINT fk_poszt_hirfolyam FOREIGN KEY (hirfolyam_id) REFERENCES Hirfolyam(ID),
    CONSTRAINT fk_poszt_felhasznalo FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID)
);
/

CREATE TABLE Komment (
    idopont         TIMESTAMP WITH LOCAL TIME ZONE PRIMARY KEY,
    felhasznalo_id  NUMBER NOT NULL,
    poszt_id        TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    szoveg          VARCHAR2(64) NOT NULL,
    ertekeles       ERTEKELES NOT NULL,
    isPublic        NUMBER(1,0) NOT NULL,
    CONSTRAINT fk_komment_felhasznalo FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID),
    CONSTRAINT fk_komment_poszt FOREIGN KEY (poszt_id) REFERENCES Poszt(idopont)
);
/

CREATE TABLE Uzenet(
    idopont         TIMESTAMP WITH LOCAL TIME ZONE PRIMARY KEY,
    /* Itt átneveztem a Felhasználó_id-t kuldo-re. */
    kuldo_id        NUMBER NOT NULL,
    cimzett_id      NUMBER NOT NULL,
    szoveg          VARCHAR2(256),
    CONSTRAINT fk_uzenet_kuldo FOREIGN KEY (kuldo_id) REFERENCES Felhasznalo(ID),
    CONSTRAINT fk_uzenet_cimzett FOREIGN KEY (cimzett_id) REFERENCES Felhasznalo(ID)
);
/

CREATE TABLE Meghivas(
    felhasznalo_id  NUMBER NOT NULL,
    cimzett_id      NUMBER NOT NULL,
    csoport_id      NUMBER NOT NULL,
    idopont         TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    isAccepted      NUMBER(1,0) NOT NULL,
    CONSTRAINT fk_meghivas_felhasznalo FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID),
    CONSTRAINT fk_meghivas_cimzett FOREIGN KEY (cimzett_id) REFERENCES Felhasznalo(ID),
    CONSTRAINT fk_meghivas_csoport FOREIGN KEY (csoport_id) REFERENCES Csoport(csoport_id)
);
/

CREATE TABLE Tagja(
    felhasznalo_id  NUMBER NOT NULL,
    csoport_id      NUMBER NOT NULL,
    CONSTRAINT fk_tagja_felhasznalo FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID),
    CONSTRAINT fk_tagja_csoport FOREIGN KEY (csoport_id) REFERENCES Csoport(csoport_id)
);
/

CREATE TABLE Ismeros(
    felhasznalo1_id NUMBER NOT NULL,
    felahsznalo2_id NUMBER NOT NULL
);
/

/*FÉNYKÉPES RÉSZ KEZDETE*/
CREATE TABLE Fenykepalbum(
    /*Itt meg a sima id-t neveztem át album_id-ra*/
    album_id        NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    felhasznalo_id  NUMBER NOT NULL,
    CONSTRAINT fk_fenykepalbum_felhasznalo FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID)
);
/

CREATE TABLE Kategoria(
    nev             VARCHAR2(10) PRIMARY KEY,
    fenykepalbum_id NUMBER,
    CONSTRAINT fk_kategoria_fenykepalbum FOREIGN KEY (fenykepalbum_id) REFERENCES Fenykepalbum(album_id)
);
/

CREATE TABLE Fenykep(
    kep_id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    kep             BLOB NOT NULL,
    nev             VARCHAR2(10) NOT NULL,
    kategoria_id    VARCHAR2(10) NOT NULL,
    CONSTRAINT fk_fenykep_kategoria FOREIGN KEY (kategoria_id) REFERENCES Kategoria(nev)
);
/


/*Felhasználók*/
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Balogh','Etele'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Kiss','Olivér'),SYSTIMESTAMP,SYSTIMESTAMP,1);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Burza','Ralf'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Anikó','Hampton'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Pál','Kozma'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Krisztián','Anderson'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('László','Jones'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('László','Dixon'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Katalin','Robin'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Anna','Jourdan'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Perry','Auger'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Claudine','Montoya'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Andrew','Paris'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Mária','Chauveau'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Csaba','Devaux'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Attila','Bonnet'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Pauline','Balog'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Sarah','Collins'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Katalin','Lengyel'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Daniel','Boucher'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Raymond','Collins'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Virág','Moulin'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Gabriel','Vaillant'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Lorraine','Wilson'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('József','Sellers'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Stephanie','Balázs'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Gilbert','Lemaitre'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Lajos','Schmitt'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('René','Masse'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Katalin','Clerc'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Róbert','Sanders'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Anaïs','Harvey'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Donna','Daugherty'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Adrienne','Jacquot'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Erzsébet','Arnaud'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Mandy','Aubert'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Paul','Voisin'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Georges','Gonzalez'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Alexandria','Nixon'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Marcell','Burton'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Tracy','Ramirez'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Virginie','Gonzalez'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Richárd','Bogdán'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Etelka','Szabó'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Daniel','Schmitt'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Stephen','Dawson'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Miklós','Szabó'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Noël','Breton'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Amber','Blanc'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Gábor','Rousseau'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Gergely','Mckenzie'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Austin','Bouchet'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Lili','Sanchez'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Jacques','Fleury'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Benjamin','Guillot'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('János','Herve'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('András','Farkas'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Jessica','Tóth'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Heather','Nagy'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Nicholas','Masse'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Teresa','Lopez'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Sabrina','Stevenson'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('Éric','Jackson'),SYSTIMESTAMP,SYSTIMESTAMP,0);
INSERT INTO Felhasznalo(jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('1q2w3e4r',NEVTIPUS('James','Morris'),SYSTIMESTAMP,SYSTIMESTAMP,0);


/*Csoportok*/
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Számítógép alkatrészek, adok-veszek','Hardverapró',2);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Adatbázis alapú redszerek helyesírása','Adatb2',1);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Cryptovaluták nyaggatása','Brave New World',3);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('SZTE legjobbjai, a jelszó meg: ******','SZTE4EVER',2);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Lelkisegélyszolgálat az egyetemisták ért','Cryout a hero',2);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Brühühűűűűűű, még nagyon sok mindent kell legépelnem','Suffer 2gether',2);

/*Meghívások*/
INSERT INTO Meghivas(felhasznalo_id,cimzett_id,csoport_id,idopont,isAccepted) VALUES(1,2,1,SYSTIMESTAMP,0);
INSERT INTO Meghivas(felhasznalo_id,cimzett_id,csoport_id,idopont,isAccepted) VALUES(1,2,4,SYSTIMESTAMP,0);
INSERT INTO Meghivas(felhasznalo_id,cimzett_id,csoport_id,idopont,isAccepted) VALUES(2,3,4,SYSTIMESTAMP,1);
INSERT INTO Meghivas(felhasznalo_id,cimzett_id,csoport_id,idopont,isAccepted) VALUES(3,1,2,SYSTIMESTAMP,1);
INSERT INTO Meghivas(felhasznalo_id,cimzett_id,csoport_id,idopont,isAccepted) VALUES(1,2,6,SYSTIMESTAMP,0);
INSERT INTO Meghivas(felhasznalo_id,cimzett_id,csoport_id,idopont,isAccepted) VALUES(3,2,3,SYSTIMESTAMP,1);
INSERT INTO Meghivas(felhasznalo_id,cimzett_id,csoport_id,idopont,isAccepted) VALUES(2,1,3,SYSTIMESTAMP,0);

/*Posztok*/


/*Üzenetek*/

COMMIT;
/
