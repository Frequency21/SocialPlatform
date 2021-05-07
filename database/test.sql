DROP TABLE Komment CASCADE CONSTRAINTS;
DROP TABLE Felhasznalo CASCADE CONSTRAINTS;
DROP TABLE Csoport CASCADE CONSTRAINTS;
DROP TABLE Poszt CASCADE CONSTRAINTS;
DROP TABLE Uzenet CASCADE CONSTRAINTS;
DROP TABLE Meghivas CASCADE CONSTRAINTS;
DROP TABLE Kategoria CASCADE CONSTRAINTS;
DROP TABLE Fenykep CASCADE CONSTRAINTS;
/*-------------------------------------------*/
DROP TABLE Tagja CASCADE CONSTRAINTS;
DROP TABLE Ismeros CASCADE CONSTRAINTS;
/*-------------------------------------------*/
DROP TYPE NEVTIPUS;
DROP TYPE ERTEKELES;
/

CREATE TYPE NEVTIPUS AS OBJECT
(
    keresztnev VARCHAR(100),
    vezeteknev VARCHAR(100)
);
/

CREATE TYPE ERTEKELES AS OBJECT
(
    like_szamlalo    NUMBER,
    dislike_szamlalo NUMBER
);
/

CREATE TABLE Felhasznalo
(
    ID           NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    jelszo       VARCHAR2(100) NOT NULL,
    email        VARCHAR2(128) NOT NULL UNIQUE,
    nev          NEVTIPUS      NOT NULL,
    csatl_dat    DATE          NOT NULL,
    szul_dat     DATE          NOT NULL,
    munka_iskola VARCHAR2(64),
    picture      VARCHAR2(300),
    isAdmin      NUMBER(1, 0)  NOT NULL
);
/


CREATE TABLE Csoport
(
    csoport_id NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    leiras     VARCHAR2(500),
    nev        VARCHAR2(200) NOT NULL UNIQUE,
    tulaj_id   NUMBER        NOT NULL,
    CONSTRAINT FK_Csoport_Felhasznalo
        FOREIGN KEY (tulaj_id)
            REFERENCES Felhasznalo (ID)
                ON DELETE CASCADE
);
/

CREATE TABLE Poszt
(
    id             NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    idopont        DATE           not null,
    szerzo_id      NUMBER,
    csoport_id     NUMBER,
    felhasznalo_id NUMBER,
    szoveg         VARCHAR2(1000) NOT NULL,
    ertekeles      ERTEKELES      NOT NULL,
    isPublic       NUMBER(1, 0)   NOT NULL,
    CONSTRAINT fk_poszt_hirfolyam_csoport
        FOREIGN KEY (csoport_id)
            REFERENCES Csoport (csoport_id)
                ON DELETE CASCADE,
    CONSTRAINT fk_poszt_hirfolyam
        FOREIGN KEY (felhasznalo_id)
            REFERENCES Felhasznalo (ID)
                ON DELETE CASCADE,
    CONSTRAINT fk_szerzo_id
        FOREIGN KEY (szerzo_id)
            REFERENCES Felhasznalo (ID)
                ON DELETE CASCADE
);
/

CREATE TABLE Komment
(
    id             NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    idopont        DATE           not null,
    komment_iro_id NUMBER,
    poszt_id       NUMBER,
    szoveg         VARCHAR2(1000) NOT NULL,
    ertekeles      ERTEKELES      NOT NULL,
    isPublic       NUMBER(1, 0)   NOT NULL,
    CONSTRAINT fk_komment_poszt
        FOREIGN KEY (poszt_id)
            REFERENCES Poszt (id)
                ON DELETE CASCADE,
    CONSTRAINT fk_komment_felhasznalo
        FOREIGN KEY (komment_iro_id)
            REFERENCES Felhasznalo (ID)
                ON DELETE CASCADE
);
/

CREATE TABLE Uzenet
(
    id         NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    idopont    DATE   not null,
    kuldo_id   NUMBER not null,
    cimzett_id NUMBER NOT NULL,
    szoveg     VARCHAR2(1000),
    CONSTRAINT fk_uzenet_kuldo
        FOREIGN KEY (kuldo_id) REFERENCES Felhasznalo (ID)
            ON DELETE CASCADE,
    CONSTRAINT fk_uzenet_cimzett
        FOREIGN KEY (cimzett_id) REFERENCES Felhasznalo (ID)
            ON DELETE CASCADE
);
/

CREATE TABLE Meghivas
(
    felhasznalo_id NUMBER,
    cimzett_id     NUMBER,
    csoport_id     NUMBER,
    idopont        DATE         NOT NULL,
    isAccepted     NUMBER(1, 0) NOT NULL,
    CONSTRAINT pk_meghivas_id PRIMARY KEY (felhasznalo_id, cimzett_id, csoport_id, idopont),
    CONSTRAINT fk_meghivas_felhasznalo
        FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo (ID)
            ON DELETE CASCADE,
    CONSTRAINT fk_meghivas_cimzett
        FOREIGN KEY (cimzett_id) REFERENCES Felhasznalo (ID)
            ON DELETE CASCADE,
    CONSTRAINT fk_meghivas_csoport
        FOREIGN KEY (csoport_id) REFERENCES Csoport (csoport_id)
            ON DELETE CASCADE
);
/

CREATE TABLE Tagja
(
    felhasznalo_id NUMBER,
    csoport_id     NUMBER,
    CONSTRAINT pk_tagja_id PRIMARY KEY (felhasznalo_id, csoport_id),
    CONSTRAINT fk_tagja_felhasznalo
        FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo (ID)
            ON DELETE CASCADE,
    CONSTRAINT fk_tagja_csoport
        FOREIGN KEY (csoport_id)
            REFERENCES Csoport (csoport_id)
                ON DELETE CASCADE
);
/

CREATE TABLE Ismeros
(
    felhasznalo1_id NUMBER,
    felhasznalo2_id NUMBER,
    CONSTRAINT pk_ismeros_id
        PRIMARY KEY (felhasznalo1_id, felhasznalo2_id),
    CONSTRAINT fk_ismeros_ki
        FOREIGN KEY (felhasznalo1_id) REFERENCES Felhasznalo (ID)
            ON DELETE CASCADE,
    CONSTRAINT fk_ismeros_kinek
        FOREIGN KEY (felhasznalo2_id) REFERENCES Felhasznalo (ID)
            ON DELETE CASCADE
);
/

CREATE TABLE Kategoria
(
    nev     VARCHAR2(200),
    felh_id NUMBER,
    CONSTRAINT fk_kategoria_fenykepalbum
        FOREIGN KEY (felh_id) REFERENCES Felhasznalo (ID)
            ON DELETE CASCADE,
    CONSTRAINT pk_kategoria
        PRIMARY KEY (nev, felh_id)
);
/

CREATE TABLE Fenykep
(
    kep_id  NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    kep     VARCHAR2(300) NOT NULL,
    kep_nev VARCHAR2(200),
    kat_nev VARCHAR2(200),
    felh_id NUMBER,
    CONSTRAINT fk_fenykep_kategoria
        FOREIGN KEY (kat_nev, felh_id) REFERENCES Kategoria (nev, felh_id)
            ON DELETE CASCADE
);
/


-- SELECT ID as "id", csatl_dat as "csatl", email as "email", f.nev.keresztnev as "knev", f.nev.vezeteknev as "vnev"
-- FROM felhasznalo f;


/*
felhasználó hírfolyamán található posztok
*/
create or replace view felh_poszt as
select f.id id,
       szerzo.picture szerzo_profil_kep,
       idopont,
       szerzo_id,
       szerzo.nev.vezeteknev || ' ' || szerzo.nev.keresztnev szerzo_nev,
       szoveg,
       ertekeles,
       isPublic
FROM felhasznalo f
         inner join
     poszt p
     on
         f.id = p.felhasznalo_id
         inner join felhasznalo szerzo
                    on
                        p.szerzo_id = szerzo.id;
/

COMMIT;
/
