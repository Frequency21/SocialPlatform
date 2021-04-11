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

CREATE TABLE Felhasznalo (
    ID              NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    jelszo          VARCHAR2(10) NOT NULL,
    nev             NEVTIPUS NOT NULL,
    csatl_dat       TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    szul_dat        DATE NOT NULL,
    munka_iskola    VARCHAR(10),
    picture         BLOB,
    isAdmin         NUMBER(1,0) NOT NULL
);
/
CREATE TABLE Hirfolyam(
    ID              NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY
);
/

CREATE TABLE Csoport(
    csoport_id      NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    leiras          VARCHAR(25),
    nev             VARCHAR(10) NOT NULL,
    tulaj_id        NUMBER NOT NULL,
    hirfolyam_id    NUMBER NOT NULL,
    FOREIGN KEY (hirfolyam_id) REFERENCES Hirfolyam(ID),
    FOREIGN KEY (tulaj_id) REFERENCES Felhasznalo(ID)
);
/

CREATE TABLE Poszt(
    idopont         TIMESTAMP WITH LOCAL TIME ZONE PRIMARY KEY,
    hirfolyam_id    NUMBER NOT NULL,
    felhasznalo_id  NUMBER NOT NULL,
    szoveg          VARCHAR(25) NOT NULL,
    ertekeles       ERTEKELES,
    isPublic        NUMBER(1,0) NOT NULL,
    FOREIGN KEY (hirfolyam_id) REFERENCES Hirfolyam(ID),
    FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID)
);
/

CREATE TABLE Komment (
    idopont         TIMESTAMP WITH LOCAL TIME ZONE PRIMARY KEY,
    felhasznalo_id  NUMBER NOT NULL,
    poszt_id        TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    szoveg          VARCHAR(25) NOT NULL,
    ertekeles       ERTEKELES NOT NULL,
    isPublic        NUMBER(1,0) NOT NULL,
    FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID),
    FOREIGN KEY (poszt_id) REFERENCES Poszt(idopont)
);
/

CREATE TABLE Uzenet(
    idopont         TIMESTAMP WITH LOCAL TIME ZONE PRIMARY KEY,
    /* Itt átneveztem a Felhasználó_id-t kuldo-re. */
    kuldo_id        NUMBER NOT NULL,
    cimzett_id      NUMBER NOT NULL,
    szoveg          NCHAR(25),
    FOREIGN KEY (kuldo_id) REFERENCES Felhasznalo(ID),
    FOREIGN KEY (cimzett_id) REFERENCES Felhasznalo(ID)
);
/

CREATE TABLE Meghivas(
    felhasznalo_id  NUMBER NOT NULL,
    cimzett_id      NUMBER NOT NULL,
    csoport_id      NUMBER NOT NULL,
    idopont         TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    isAccepted      NUMBER(1,0) NOT NULL,
    FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID),
    FOREIGN KEY (cimzett_id) REFERENCES Felhasznalo(ID),
    FOREIGN KEY (csoport_id) REFERENCES Csoport(csoport_id)
);
/

/*FÉNYKÉPES RÉSZ KEZDETE*/
CREATE TABLE Fenykepalbum(
    /*Itt meg a sima id-t neveztem át album_id-ra*/
    album_id        NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    felhasznalo_id  NUMBER NOT NULL,
    FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID)
);
/

CREATE TABLE Kategoria(
    nev             NCHAR(10) PRIMARY KEY,
    fenykepalbum_id NUMBER,
    FOREIGN KEY (fenykepalbum_id) REFERENCES Fenykepalbum(album_id)
);
/

CREATE TABLE Fenykep(
    kep_id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    kep             BLOB NOT NULL,
    nev             NCHAR(10) NOT NULL,
    kategoria_id    NCHAR(10) NOT NULL,
    FOREIGN KEY (kategoria_id) REFERENCES Kategoria(nev)
);
/
