DROP TABLE Komment CASCADE CONSTRAINTS;
DROP TABLE Felhasznalo CASCADE CONSTRAINTS;
DROP TABLE Csoport CASCADE CONSTRAINTS;
DROP TABLE Poszt CASCADE CONSTRAINTS;
DROP TABLE Uzenet CASCADE CONSTRAINTS;
DROP TABLE Meghivas CASCADE CONSTRAINTS;
DROP TABLE Fenykepalbum CASCADE CONSTRAINTS;
DROP TABLE Kategoria CASCADE CONSTRAINTS;
DROP TABLE Fenykep CASCADE CONSTRAINTS;
/*------------------------------------*/
DROP TABLE Tagja CASCADE CONSTRAINTS;
DROP TABLE Ismeros CASCADE CONSTRAINTS;
/*-----------------------------------*/
DROP TYPE NEVTIPUS;
DROP TYPE ERTEKELES;

CREATE TYPE NEVTIPUS AS OBJECT (
    keresztnev VARCHAR(28),
    vezeteknev VARCHAR(28)
);
/

CREATE TYPE ERTEKELES AS OBJECT (
    like_szamlalo    NUMBER,
    dislike_szamlalo NUMBER
);
/

CREATE TABLE Felhasznalo (
    ID              NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    jelszo          VARCHAR2(32) NOT NULL,
    email           VARCHAR2(128) NOT NULL,
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
    idopont         TIMESTAMP WITH LOCAL TIME ZONE,
    csoport_id      NUMBER,
    szerzo_id       NUMBER,
    felhasznalo_id  NUMBER NOT NULL,
    szoveg          VARCHAR2(128) NOT NULL,
    ertekeles       ERTEKELES NOT NULL,
    isPublic        NUMBER(1,0) NOT NULL,
    CONSTRAINT pk_poszt_id PRIMARY KEY(idopont,felhasznalo_id),
    CONSTRAINT fk_poszt_hirfolyam_csopi FOREIGN KEY (csoport_id) REFERENCES Csoport(csoport_id),
    CONSTRAINT fk_poszt_hirfolyam_szerzo FOREIGN KEY (szerzo_id) REFERENCES Felhasznalo(ID),
    CONSTRAINT fk_poszt_felhasznalo FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID)
);
/

CREATE TABLE Komment (
    idopont         TIMESTAMP WITH LOCAL TIME ZONE,
    felhasznalo_id  NUMBER NOT NULL,
    poszt_iro_id    NUMBER NOT NULL,
    poszt_idopont   TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    szoveg          VARCHAR2(64) NOT NULL,
    ertekeles       ERTEKELES NOT NULL,
    isPublic        NUMBER(1,0) NOT NULL,
    CONSTRAINT pk_komment_id PRIMARY KEY(idopont,felhasznalo_id),
    FOREIGN KEY (poszt_iro_id, poszt_idopont) REFERENCES Poszt(felhasznalo_id,idopont),
    CONSTRAINT fk_komment_felhasznalo FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID)
);
/

CREATE TABLE Uzenet(
    idopont         TIMESTAMP WITH LOCAL TIME ZONE PRIMARY KEY,
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
    CONSTRAINT pk_meghivas_id PRIMARY KEY(felhasznalo_id, cimzett_id, csoport_id, idopont),
    CONSTRAINT fk_meghivas_felhasznalo FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID),
    CONSTRAINT fk_meghivas_cimzett FOREIGN KEY (cimzett_id) REFERENCES Felhasznalo(ID),
    CONSTRAINT fk_meghivas_csoport FOREIGN KEY (csoport_id) REFERENCES Csoport(csoport_id)
);
/

CREATE TABLE Tagja(
    felhasznalo_id  NUMBER NOT NULL,
    csoport_id      NUMBER NOT NULL,
    CONSTRAINT pk_tagja_id PRIMARY KEY (felhasznalo_id,csoport_id),
    CONSTRAINT fk_tagja_felhasznalo FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID),
    CONSTRAINT fk_tagja_csoport FOREIGN KEY (csoport_id) REFERENCES Csoport(csoport_id)
);
/

CREATE TABLE Ismeros(
    felhasznalo1_id NUMBER NOT NULL,
    felahsznalo2_id NUMBER NOT NULL,
    CONSTRAINT pk_ismeros_id PRIMARY KEY (felhasznalo1_id,felhasznalo2_id),
    CONSTRAINT fk_tagja_felhasznalo FOREIGN KEY (felhasznalo1_id) REFERENCES Felhasznalo(ID),
    CONSTRAINT fk_tagja_felhasznalo FOREIGN KEY (felhasznalo2_id) REFERENCES Felhasznalo(ID)
);
/

/*FÉNYKÉPES RÉSZ KEZDETE*/
CREATE TABLE Fenykepalbum(
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




COMMIT;
/
