DROP TABLE Komment CASCADE CONSTRAINTS;
DROP TABLE Felhasznalo CASCADE CONSTRAINTS;
DROP TABLE Csoport CASCADE CONSTRAINTS;
DROP TABLE Poszt CASCADE CONSTRAINTS;
DROP TABLE Uzenet CASCADE CONSTRAINTS;
DROP TABLE Meghivas CASCADE CONSTRAINTS;
DROP TABLE Fenykepalbum CASCADE CONSTRAINTS;
DROP TABLE Kategoria CASCADE CONSTRAINTS;
DROP TABLE Fenykep CASCADE CONSTRAINTS;
/*-------------------------------------------*/
DROP TABLE Tagja CASCADE CONSTRAINTS;
DROP TABLE Ismeros CASCADE CONSTRAINTS;
/*-------------------------------------------*/
DROP TYPE NEVTIPUS;
DROP TYPE ERTEKELES;

CREATE TYPE NEVTIPUS AS OBJECT
(
    keresztnev VARCHAR(28),
    vezeteknev VARCHAR(28)
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
    jelszo       VARCHAR2(32)                   NOT NULL,
    email        VARCHAR2(128)                  NOT NULL UNIQUE,
    nev          NEVTIPUS                       NOT NULL,
    csatl_dat    TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    szul_dat     DATE                           NOT NULL,
    munka_iskola VARCHAR2(64),
    picture      BLOB,
    isAdmin      NUMBER(1, 0)                   NOT NULL
);
/


CREATE TABLE Csoport
(
    csoport_id NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    leiras     VARCHAR2(128),
    nev        VARCHAR2(16) NOT NULL UNIQUE,
    tulaj_id   NUMBER       NOT NULL,
    CONSTRAINT FK_Csoport_Felhasznalo
        FOREIGN KEY (tulaj_id)
        REFERENCES Felhasznalo (ID)
        ON DELETE CASCADE
);
/

CREATE TABLE Poszt
(
    idopont        TIMESTAMP WITH LOCAL TIME ZONE,
    szerzo_id      NUMBER,
    csoport_id     NUMBER,
    felhasznalo_id NUMBER,
    szoveg         VARCHAR2(128) NOT NULL,
    ertekeles      ERTEKELES     NOT NULL,
    isPublic       NUMBER(1, 0)  NOT NULL,
    CONSTRAINT pk_poszt_id
        PRIMARY KEY (idopont, szerzo_id),
    CONSTRAINT fk_poszt_hirfolyam_csoport
        FOREIGN KEY (csoport_id)
        REFERENCES Csoport (csoport_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_poszt_hirfolyam_szerzo
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
    idopont        TIMESTAMP WITH LOCAL TIME ZONE,
    komment_iro_id NUMBER,
    poszt_felh_id  NUMBER                         NOT NULL,
    poszt_idopont  TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    szoveg         VARCHAR2(64)                   NOT NULL,
    ertekeles      ERTEKELES                      NOT NULL,
    isPublic       NUMBER(1, 0)                   NOT NULL,
    CONSTRAINT pk_komment_id PRIMARY KEY (idopont, komment_iro_id),
    CONSTRAINT fk_komment_poszt
        FOREIGN KEY (poszt_idopont, poszt_felh_id)
        REFERENCES Poszt (idopont, szerzo_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_komment_felhasznalo
        FOREIGN KEY (komment_iro_id)
        REFERENCES Felhasznalo (ID)
        ON DELETE CASCADE
);
/

CREATE TABLE Uzenet
(
    idopont    TIMESTAMP WITH LOCAL TIME ZONE,
    kuldo_id   NUMBER,
    cimzett_id NUMBER NOT NULL,
    szoveg     VARCHAR2(256),
    CONSTRAINT pk_uzenet_id PRIMARY KEY (idopont, kuldo_id),
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
    idopont        TIMESTAMP WITH LOCAL TIME ZONE,
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

/*FĂ‰NYKĂ‰PES RĂ‰SZ KEZDETE*/
CREATE TABLE Fenykepalbum
(
    album_id NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    tulaj_id NUMBER NOT NULL,
    CONSTRAINT fk_fenykepalbum_tulajdonos
        FOREIGN KEY (tulaj_id) REFERENCES Felhasznalo (ID)
        ON DELETE CASCADE
);
/

CREATE TABLE Kategoria
(
    nev             VARCHAR2(16) PRIMARY KEY,
    fenykepalbum_id NUMBER,
    CONSTRAINT fk_kategoria_fenykepalbum
        FOREIGN KEY (fenykepalbum_id) REFERENCES Fenykepalbum (album_id)
        ON DELETE CASCADE
);
/

CREATE TABLE Fenykep
(
    kep_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    kep          BLOB         NOT NULL,
    nev          VARCHAR2(16) NOT NULL,
    kategoria_id VARCHAR2(16) NOT NULL,
    CONSTRAINT fk_fenykep_kategoria
        FOREIGN KEY (kategoria_id) REFERENCES Kategoria (nev)
        ON DELETE CASCADE
);
/

-- insert statements
-- developers
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'oli@gmail.com', NEVTIPUS('Kiss', 'Olivér'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'egyetem', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'ralf@gmail.com', NEVTIPUS('Burza', 'Ralf'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'egyetem', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'etele@gmail.com', NEVTIPUS('Balogh', 'Etele'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'egyetem', 1);
/

SELECT ID as "id", csatl_dat as "csatl", email as "email", f.nev.keresztnev as "knev", f.nev.vezeteknev as "vnev" FROM felhasznalo f;

-- generated values

/*
/*Felhasználók*/
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('simonpeter@gmail.com','1q2w3e4r',NEVTIPUS('Taylor','Kiss'),SYSTIMESTAMP,TO_DATE('1973/10/13', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('amy82@smith.com','1q2w3e4r',NEVTIPUS('Deny','Burza'),SYSTIMESTAMP,TO_DATE('1992/05/02', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('thompsontrevor@smith.info','1q2w3e4r',NEVTIPUS('Yndiliadrin','Balogh'),SYSTIMESTAMP,TO_DATE('2003/12/05', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('celina20@daniel.net','1q2w3e4r',NEVTIPUS('Anna','Szabó'),SYSTIMESTAMP,TO_DATE('1977/01/03', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('gregory70@simmons-garrett.org','1q2w3e4r',NEVTIPUS('Randy','Sárközi'),SYSTIMESTAMP,TO_DATE('1974/07/22', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('valeria50@gmail.com','1q2w3e4r',NEVTIPUS('Dóra','Royer'),SYSTIMESTAMP,TO_DATE('1983/01/03', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('evajuhasz@gmail.com','1q2w3e4r',NEVTIPUS('Judit','Balla'),SYSTIMESTAMP,TO_DATE('2004/10/14', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('jacksonpaul@moore-harris.net','1q2w3e4r',NEVTIPUS('Jeanne','Seguin'),SYSTIMESTAMP,TO_DATE('1988/10/01', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('joseph34@white-harper.biz','1q2w3e4r',NEVTIPUS('Tibor','Le Goff'),SYSTIMESTAMP,TO_DATE('1974/03/15', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('zoltan20@hotmail.com','1q2w3e4r',NEVTIPUS('Sándor','Gallegos'),SYSTIMESTAMP,TO_DATE('1986/06/29', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('gonzalessean@yahoo.com','1q2w3e4r',NEVTIPUS('Nicole','Tóth'),SYSTIMESTAMP,TO_DATE('1981/04/09', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('ferencgaspar@kiss.net','1q2w3e4r',NEVTIPUS('Margit','Roberts'),SYSTIMESTAMP,TO_DATE('1988/10/18', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('alainbrun@delaunay.fr','1q2w3e4r',NEVTIPUS('Kelly','Kovács'),SYSTIMESTAMP,TO_DATE('2020/12/24', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('watkinsdustin@stewart-smith.com','1q2w3e4r',NEVTIPUS('Kristin','Baron'),SYSTIMESTAMP,TO_DATE('2007/05/13', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('rreed@hotmail.com','1q2w3e4r',NEVTIPUS('Kim','Máté'),SYSTIMESTAMP,TO_DATE('2001/05/07', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('alexandra05@parker.com','1q2w3e4r',NEVTIPUS('Jennifer','Hajdu'),SYSTIMESTAMP,TO_DATE('1970/03/17', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('charlotteleblanc@lemaitre.fr','1q2w3e4r',NEVTIPUS('Gina','Burns'),SYSTIMESTAMP,TO_DATE('1973/03/24', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('allison38@brooks.com','1q2w3e4r',NEVTIPUS('Tibor','Horváth'),SYSTIMESTAMP,TO_DATE('1999/08/28', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('malletisabelle@blot.com','1q2w3e4r',NEVTIPUS('Yves','Patel'),SYSTIMESTAMP,TO_DATE('2015/06/05', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('jeanneroche@chauvet.com','1q2w3e4r',NEVTIPUS('Clayton','Hughes'),SYSTIMESTAMP,TO_DATE('1977/01/30', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('michael23@montgomery-hall.org','1q2w3e4r',NEVTIPUS('Clémence','Rácz'),SYSTIMESTAMP,TO_DATE('2003/06/16', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('margit90@hotmail.com','1q2w3e4r',NEVTIPUS('Victoria','Stewart'),SYSTIMESTAMP,TO_DATE('2016/04/13', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('tami15@kennedy-watts.org','1q2w3e4r',NEVTIPUS('Gergő','Varga'),SYSTIMESTAMP,TO_DATE('1980/01/04', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('williamsoncameron@yahoo.com','1q2w3e4r',NEVTIPUS('Jérôme','Leroy'),SYSTIMESTAMP,TO_DATE('1970/06/24', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('nemethkatalin@sipos.hu','1q2w3e4r',NEVTIPUS('Samuel','Martin'),SYSTIMESTAMP,TO_DATE('1998/12/20', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('istvan57@yahoo.com','1q2w3e4r',NEVTIPUS('Lauren','Tóth'),SYSTIMESTAMP,TO_DATE('1970/05/05', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('bmuller@buisson.org','1q2w3e4r',NEVTIPUS('Mária','Cline'),SYSTIMESTAMP,TO_DATE('1983/01/12', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('edouard37@wanadoo.fr','1q2w3e4r',NEVTIPUS('Olivier','Bogdán'),SYSTIMESTAMP,TO_DATE('2000/08/30', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('maggie73@barbe.fr','1q2w3e4r',NEVTIPUS('Patrick','Ford'),SYSTIMESTAMP,TO_DATE('1978/03/12', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('bernadett18@farkas.org','1q2w3e4r',NEVTIPUS('Shane','Bernard'),SYSTIMESTAMP,TO_DATE('2010/03/05', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('dwaynerich@bennett.com','1q2w3e4r',NEVTIPUS('Manon','Rollins'),SYSTIMESTAMP,TO_DATE('1992/02/16', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('levente96@hotmail.com','1q2w3e4r',NEVTIPUS('Augustin','Becker'),SYSTIMESTAMP,TO_DATE('1989/07/25', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('rchauvin@gautier.fr','1q2w3e4r',NEVTIPUS('Marguerite','Campos'),SYSTIMESTAMP,TO_DATE('2008/02/17', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('hopkinsmicheal@yahoo.com','1q2w3e4r',NEVTIPUS('Zoltán','Novák'),SYSTIMESTAMP,TO_DATE('2009/09/10', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('wle-goff@begue.net','1q2w3e4r',NEVTIPUS('Denise','Deschamps'),SYSTIMESTAMP,TO_DATE('2019/04/16', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('jakabrozalia@sandor.com','1q2w3e4r',NEVTIPUS('Ilona','Bodnár'),SYSTIMESTAMP,TO_DATE('1989/09/13', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('davidilles@hotmail.com','1q2w3e4r',NEVTIPUS('Roland','Clark'),SYSTIMESTAMP,TO_DATE('2006/05/19', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('paul15@romero.net','1q2w3e4r',NEVTIPUS('Orsolya','Boutin'),SYSTIMESTAMP,TO_DATE('1979/03/13', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('zsomborboros@hotmail.com','1q2w3e4r',NEVTIPUS('Anna','Wright'),SYSTIMESTAMP,TO_DATE('2005/10/04', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('paulinejoseph@laposte.net','1q2w3e4r',NEVTIPUS('Zsuzsanna','Cooper'),SYSTIMESTAMP,TO_DATE('1977/01/18', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('benedeknagy@lukacs.net','1q2w3e4r',NEVTIPUS('Diane','Papp'),SYSTIMESTAMP,TO_DATE('2017/08/01', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('coletaylor@gaines-woodard.biz','1q2w3e4r',NEVTIPUS('Jérôme','Louis'),SYSTIMESTAMP,TO_DATE('1996/01/21', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('edward87@morris-chung.net','1q2w3e4r',NEVTIPUS('Dawn','Chartier'),SYSTIMESTAMP,TO_DATE('2011/04/11', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('samuelhunt@yahoo.com','1q2w3e4r',NEVTIPUS('Walter','Lee'),SYSTIMESTAMP,TO_DATE('1972/11/29', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('magyarbarbara@kovacs.net','1q2w3e4r',NEVTIPUS('Édith','Szabó'),SYSTIMESTAMP,TO_DATE('1971/01/19', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('genevieve27@noos.fr','1q2w3e4r',NEVTIPUS('Émilie','Conner'),SYSTIMESTAMP,TO_DATE('1979/08/09', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('manonraymond@orange.fr','1q2w3e4r',NEVTIPUS('Charlotte','Renard'),SYSTIMESTAMP,TO_DATE('1971/01/27', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('tgros@hebert.com','1q2w3e4r',NEVTIPUS('Sébastien','Jónás'),SYSTIMESTAMP,TO_DATE('1981/06/16', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('shannonwilson@gmail.com','1q2w3e4r',NEVTIPUS('Julie','White'),SYSTIMESTAMP,TO_DATE('1990/01/08', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('philippeaurore@de.com','1q2w3e4r',NEVTIPUS('Phillip','Dupuis'),SYSTIMESTAMP,TO_DATE('2014/08/26', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('mirandabrian@yahoo.com','1q2w3e4r',NEVTIPUS('Ralph','Magyar'),SYSTIMESTAMP,TO_DATE('1974/06/29', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('xlemonnier@lamy.net','1q2w3e4r',NEVTIPUS('Ray','Mcfarland'),SYSTIMESTAMP,TO_DATE('1977/07/04', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('zlefebvre@sfr.fr','1q2w3e4r',NEVTIPUS('Dávid','Hardy'),SYSTIMESTAMP,TO_DATE('2021/01/01', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('dupontdorothee@meunier.fr','1q2w3e4r',NEVTIPUS('Tara','Tóth'),SYSTIMESTAMP,TO_DATE('1977/07/17', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('olahgyula@balog.com','1q2w3e4r',NEVTIPUS('Alexandria','Williams'),SYSTIMESTAMP,TO_DATE('2016/12/29', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('szabiribert@hotmail.com','1q2w3e4r',NEVTIPUS('Éric','Robin'),SYSTIMESTAMP,TO_DATE('1976/04/10', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('janosnagy@nagy.info','1q2w3e4r',NEVTIPUS('Marguerite','King'),SYSTIMESTAMP,TO_DATE('2003/09/29', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('lecomtesusanne@besson.fr','1q2w3e4r',NEVTIPUS('Kelsey','Clement'),SYSTIMESTAMP,TO_DATE('2006/09/03', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('jbonneau@gomez.fr','1q2w3e4r',NEVTIPUS('Gilles','Szabó'),SYSTIMESTAMP,TO_DATE('2003/01/02', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('susan55@mccall.com','1q2w3e4r',NEVTIPUS('Shaun','Simmons'),SYSTIMESTAMP,TO_DATE('1970/11/05', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('banksjohn@hotmail.com','1q2w3e4r',NEVTIPUS('Christopher','Horváth'),SYSTIMESTAMP,TO_DATE('2003/05/23', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('crossi@pereira.fr','1q2w3e4r',NEVTIPUS('Kaitlin','Legendre'),SYSTIMESTAMP,TO_DATE('1995/10/20', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('joseph06@hotmail.com','1q2w3e4r',NEVTIPUS('Ildikó','Gillet'),SYSTIMESTAMP,TO_DATE('2006/09/15', 'yyyy/mm/dd'),0);
INSERT INTO Felhasznalo(email,jelszo,nev,csatl_dat,szul_dat,isAdmin) VALUES('varadimiklis@hotmail.com','1q2w3e4r',NEVTIPUS('Brian','Williams'),SYSTIMESTAMP,TO_DATE('2018/04/30', 'yyyy/mm/dd'),0);


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


/*Üzenetek*/
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,36,47,'This interest positive owner. Sense check direction new community.Not could task they appear husband.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,16,63,'Médecin paraître juste remplacer vif vivre impossible inquiétude. Feuille vivre parfois arracher fond.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,9,25,'Nouveau fonction mort malgré. Distance notre fuir erreur soulever malheur dos troubler. Passé début accomplir côté bord mari patron.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,45,60,'Debitis illo aspernatur velit eos aliquid quae. Recusandae harum ipsam. Nulla consectetur dolore iste ipsum.Qui nemo minus adipisci. Dignissimos incidunt maxime accusantium quisquam itaque deserunt.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,39,51,'Project figure financial minute memory amount alone message. One involve night employee anyone want.Wish economy at take air. Light employee any happen. Also raise likely play image.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,53,48,'Petit dabord prier emporter. Poète montagne absolument phrase instinct suivant surveiller.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,55,41,'Recent great movement where nearly happy. Discuss guess nor feeling. Trial activity him.Save doctor simple turn political manage. Some natural sense recognize hope seek today.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,1,39,'Perspiciatis odio consectetur rem.Commodi corporis recusandae odio est quos harum.Atque eius pariatur cumque. Facilis excepturi voluptatem pariatur.Animi ratione temporibus blanditiis fugiat.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,23,9,'Whose thought sure example he. Order suggest push everybody. Government hope day question range develop history. But however order.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,49,20,'Behind wind affect lose surface vote night. Expect positive tree contain send husband attorney.Movie sometimes simply myself soldier example along. Member skin admit inside affect.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,30,40,'Nemo sunt officia deserunt nobis rerum id laborum. Dicta consequatur modi provident voluptates. Tenetur vitae a.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,43,13,'Health course suggest reduce together knowledge change. Add produce beat past often mother collection.Article friend nearly water family hold often. Cultural somebody floor politics.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,7,53,'Prix aussitôt lune jeune étrange. Mêler décrire côté pareil casser métier titre.Avec hésiter lune exemple second. Voilà amuser tache machine long plein rire. Consulter ton court accomplir.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,13,30,'Economy know much customer least. Under which on civil. Leader consider action sing. Girl look bank example.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,45,49,'Eum ducimus odio aspernatur veritatis. Dolorem tempora ipsa expedita dolorum. Est officiis natus blanditiis eligendi tenetur.Adipisci quod minima rem.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,28,3,'Quis illum dignissimos optio. Ullam cum mollitia libero sunt. Fugiat voluptates sapiente cumque.Quis impedit libero. Quis numquam reprehenderit incidunt ullam officiis eos. Nisi officia vitae.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,30,58,'Turn general entire certainly. Data admit realize occur minute. Four from eye market enough whether.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,45,60,'Word value on stop ago value lawyer. Because bag cultural our country away between. Maybe determine sure blue expect down director. Place writer first lawyer.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,52,15,'Rapporter réalité fond rond grâce pays. Atteindre obéir compte magnifique elle. Espoir frais professeur miser apporter école arrivée.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,19,20,'Assumenda neque adipisci dolor consequatur. Eligendi vitae id optio. Ipsum nemo cumque autem quaerat.Exercitationem asperiores id quia. Provident architecto exercitationem fugiat exercitationem.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,33,56,'Falloir race livre famille retirer. Port précipiter retenir ferme parfois essayer commencement livrer. Apparence commander vous faux amener montagne.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,13,58,'School police article. Able feel without play protect.Help player beat soon agency past find especially. And executive tax design ready store against.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,28,38,'Court accent volonté quarante. De jeune fort patron toute. Tandis Que impression habiter deviner raconter coeur noire.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,6,59,'Quam reiciendis mollitia molestiae corporis. Voluptate voluptatibus provident saepe quis eveniet officiis laborum. Itaque eveniet nobis molestias. Doloribus quibusdam eum nesciunt inventore.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,11,29,'Drame prochain ancien créer endormir. Recherche morceau pas crainte contenir.Foule argent étoile difficile. Sauver sembler nous fait paysan. Cacher rencontrer nombreux commander absence empêcher.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,17,30,'Price yard reduce director. Address success little opportunity.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,4,64,'Direction jouer recommencer longtemps long flot. Ombre chute question nombreux juger lit.Chasser secret aussitôt autant voie consulter. Haine colline six acte si. Rôle assez égal un éclater.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,58,59,'Autant entourer sujet flamme frère plaisir huit produire. Fête ventre passage dangereux chemin éviter chute. Obliger or importance parole salut droite ordre.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,41,9,'Et provident odio nam quasi ut ipsum. Totam accusamus deserunt quis. Vitae corporis magnam porro.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,50,52,'Possimus dolorem iure commodi amet nemo. Sed pariatur ad natus.Sint dolores itaque sed iusto quam voluptatem. Repudiandae amet tenetur ab nihil explicabo.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,16,8,'Floor save theory look father apply. Manager down toward significant away.Benefit box quality give around night sister nature. Growth moment blue pick because modern.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,26,58,'Nobis optio eligendi necessitatibus a praesentium eligendi. Ullam autem minus quisquam.Nemo dignissimos doloribus ab esse facere incidunt. Similique dolores exercitationem magni et quos.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,32,18,'Mind fear herself series style. Probably word region writer talk attack. Room require difficult teacher future wish. Yes hand exist amount ten be option.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,58,33,'Skin society for director. Industry near it. Property wait want popular suffer should. Century player land what.Later everyone never letter wind group. Way now particular sense.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,36,10,'Monde matin faible train blanc fumée. Porter accord prêter planche éteindre fort inviter. Exprimer secrétaire porte.Corde trente delà fait envelopper. Lune là terrain disposer cause tendre.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,54,64,'Regard agent écarter pour chaleur gauche annoncer précéder. Conclure pitié livrer partir trente. Quoi se force lire avant titre.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,64,51,'Poète autant nous est y menacer enfermer. Larme voler arrière toit horizon.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,21,30,'Appel tromper hiver secrétaire franc cesse. Beau dont abandonner étoile naissance. Jaune ennemi fil composer. Souhaiter signe impression poursuivre autorité rose installer.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,34,60,'Back evidence project billion. Reality check section hour gun body herself name.Style strong television through radio air. School myself capital off.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,4,7,'Deviner marché doigt chemin certain pitié soir. Promettre fine clair tache brûler depuis de. Grand odeur arracher. Haut souvenir marquer vide changement dont queue.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,39,10,'Big natural everything. Money magazine mind along foreign than popular.Heavy future help. Company small traditional reveal again. Government past boy though firm enter first.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,35,55,'Extraordinaire élever épaule pourquoi reculer. Espèce moins faveur été déclarer angoisse. Déposer détruire lit cent mari.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,18,37,'Gris étudier rouge autrefois ami demain. Sang déclarer ci tirer marier.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,64,50,'Room send form position bill dream.Father race see six fund old. Enjoy keep far. Receive it week without. Education exist view cut go series it.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,37,19,'Provident nostrum magni fuga nemo libero. Quo quia fugiat eius commodi nostrum exercitationem. Corrupti nisi nulla temporibus quas.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,43,60,'Exercitationem suscipit officia repudiandae vitae. Consectetur voluptatem ipsam quis natus. Soluta non eligendi neque. Ratione esse esse quibusdam eaque.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,60,35,'Cupiditate incidunt debitis vel ratione sed blanditiis. Quo porro reiciendis totam.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,56,48,'Existence événement cinq selon maison rien forme. Votre saint ligne coucher chemise. Pain inviter quant à petit partir.Tuer soulever blanc je réserver fils. Spectacle derrière forcer exécuter.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,3,30,'Prêt vrai créer or puissant composer. Oeuvre rêve élever nature petit.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,24,34,'Dicta beatae amet laborum blanditiis. Inventore fugiat saepe in illo officiis illum suscipit. Eius harum incidunt sunt.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,35,25,'Major early necessary surface decide window. Course same see style technology.Edge film clearly building language. Nice space oil blood.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,32,62,'Green idea able note reality. Candidate agreement story stage Republican almost. Nearly wrong national heavy per special newspaper upon.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,39,25,'Voluptate earum nostrum eius explicabo sed molestiae. Et soluta provident cupiditate debitis atque odio voluptates. Eaque neque voluptatum distinctio.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,32,50,'Tête toucher inventer paysan vrai blanc. Pain entourer mourir robe aide pièce vaste prière.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,4,25,'Corrupti eum commodi cumque quia necessitatibus optio. Dignissimos doloribus nesciunt ab quisquam.Iste inventore veritatis voluptatibus officiis cupiditate. Ea eum ex id sapiente delectus dolor.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,55,56,'Magnam deleniti dolorem similique. Magnam molestias repellendus fugit soluta qui ratione natus. Consequuntur veritatis aliquam.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,40,35,'Numquam architecto quis impedit. Omnis nesciunt facilis assumenda quae pariatur error. Quia deserunt odit.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,41,32,'Positive group myself because free career. Property herself why suggest director.Kitchen friend fire lawyer. Job choose quickly decide end.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,37,41,'Minus soluta sequi eum doloribus aliquid ipsam illum. Error possimus rerum eaque quas. Nisi voluptate iure vitae itaque sequi nulla quis. Minima odit soluta sed cupiditate nulla.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,43,25,'Mollitia pariatur voluptatem eum exercitationem harum culpa. Mollitia est odit.Deserunt cum laboriosam occaecati dicta. Dicta consequatur possimus.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,62,50,'Ville lequel saluer profond. Violent supérieur beaucoup fils police subir.Réunir vieil pont entretenir dangereux alors. Abri six soleil changer. Soulever ah lier du politique rose.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,54,7,'Quod ipsum accusamus quis blanditiis. Est laboriosam cum corporis vel sunt corporis. Fugiat molestias totam fugit consequatur.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,47,56,'Sint molestias nostrum voluptate nam consequatur. Occaecati ipsum cupiditate ducimus magnam aspernatur.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,12,18,'Étudier dessiner bande fine. Source passer tuer sommeil renoncer. Tendre exister énorme attirer manier vraiment.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,62,63,'Départ lit moins abattre violence puissance patron froid. Étoile enfin prévenir complet.Tourner reposer vers perte million race résoudre relation. Tête lutter envie.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,32,7,'Expedita quidem dolorum ratione deserunt.Eveniet soluta deleniti. Consectetur culpa consectetur ut vero quam voluptate id. Odio qui enim nisi dolorem.Dolore sint perferendis.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,12,62,'Rerum soluta aperiam inventore delectus. Facere nam molestias laborum veniam. Ab excepturi cum harum saepe error exercitationem quidem.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,6,8,'Specific us program name sit drug type. Impact language significant performance attorney market. Free really side newspaper. Lawyer hold a good remain. Station fly get beat brother official writer.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,57,45,'Veritatis assumenda ipsam. Nam suscipit nihil vero nam hic. Delectus debitis ipsum.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,12,27,'Hier jamais mériter lendemain seconde grain armer. Intention causer tourner deviner contraire tantôt. Corps immobile hasard distinguer que tirer tache.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,64,26,'Neque molestias autem nesciunt quis nobis. Earum vitae voluptatum laudantium iste non dolore aperiam. Sit dolorem totam quae error ipsum. Praesentium cupiditate quis vel velit unde.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,7,61,'Mollitia ipsum amet cum eveniet sint. Distinctio corrupti quas occaecati magnam doloribus esse.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,63,50,'Decide concern born doctor news wall. Eat especially need rise guy sort might return. Indeed production ability. Record else yes address ability. Suffer article her player trade tell think.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,14,1,'Short several generation important hit cut. Study apply their both occur either. Since Mr provide woman music yeah situation. May management none affect well behind. Matter foot model today.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,11,10,'Same quite challenge call wife here success goal. Claim friend matter maintain discussion entire car. Lose civil among. Let hour couple serious. Structure small use phone.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,58,40,'Believe both left. Reflect it do treatment organization smile. Two reveal of sport account education economy.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,60,46,'Cinquante pencher docteur autre épaule battre. Blanc printemps plusieurs histoire plonger fusil rêve. Ramener rue vie.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,36,34,'Middle song before small meeting. Money you front someone role community. Be eight or among read recent step move.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,25,40,'Consulter lettre éternel vite déclarer. Rond aller défaut obéir monter cabinet ramasser. Durer honte mémoire.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,57,11,'Supérieur faveur livre sommet. Rappeler que rentrer réel. Tout subir tout point magnifique examiner. Environ rien gros. Produire paupière en gagner battre terrain désormais.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,63,52,'Ea culpa possimus. Corrupti error aperiam distinctio. Sit voluptate aut. Deleniti suscipit ex assumenda quae veniam. Assumenda assumenda maiores nostrum natus.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,33,56,'Voluptatibus saepe suscipit mollitia autem. Eveniet assumenda nesciunt harum. Optio debitis in. Aspernatur ipsa assumenda. Occaecati voluptatibus veritatis minima asperiores numquam.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,37,7,'Fait pauvre solitude soudain six disparaître franchir riche. Non suivre joue pouvoir. Article si marche temps ombre expression.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,9,8,'Vérité secret durant seconde vous. Souhaiter deux inconnu. Livrer disparaître général rapporter fait. Rassurer poids proposer réel chaise phrase femme.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,7,62,'May social ask experience upon action give. Far even total food. American nice you. Pm improve yourself security. Gun claim sense seek. Ground company business send suddenly.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,2,14,'Treatment concern teacher should whether us rather. Rich send quite major board somebody letter something. Describe guy lay level. Young start understand instead cost suddenly inside matter.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,60,2,'Quae aut excepturi laboriosam illum tempora delectus. Est molestiae dolor eos accusamus totam ducimus.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,15,30,'Tough party form. Real customer too pay establish summer. Tonight charge above yard stage meet. Need impact piece management mother few.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,40,1,'Training administration course carry a order evidence. Safe trade message ago appear happy three. Husband fight offer think measure through fill daughter. Hard structure education set house site see.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,7,2,'Ratione necessitatibus eligendi recusandae est soluta. Minus accusamus incidunt. Quaerat eius saepe amet laudantium occaecati. Dolores impedit velit. Soluta deleniti deleniti delectus.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,34,58,'Quidem adipisci necessitatibus accusantium. Numquam quo aliquid ab iure. Dolore natus voluptatem sit itaque.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,61,46,'Acheter traiter courant y. Ombre rapport répandre dautres silence vite fait. Étendre fenêtre humain lequel. Enfance haine grand peau lèvre éloigner autre habiller.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,61,46,'Pleurer prêter changer enfant. Terminer propos de mode quand. Année ministre dégager plaire entrée. Posséder sein souffrance si.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,40,57,'Baby campaign already power protect school. Also character may. Hard arm human world growth. Star card it require I.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,48,28,'Cum ipsa ea officiis autem. Ipsa modi hic eveniet quibusdam vel. Nostrum vel excepturi voluptatem.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,44,22,'Appartement semaine puissant hôtel connaître ciel système. Surtout mine vif larme inspirer vaincre fenêtre. Crise certain personne exprimer croix.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,8,10,'Sueur victime selon histoire. Étaler quelquun campagne. Désigner sien certes. Parce Que immobile causer parmi. Seigneur réduire ah traîner passé. Sec bien fort un.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,54,50,'Ab excepturi quas rem facere corporis ea sit. Placeat blanditiis officiis harum.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,53,26,'Group although make drop product. Past along tell clearly those any. Above somebody fill. Generation message serious federal arrive certainly partner. She short age without.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,28,17,'Other cause per within today girl. Message this quite notice main. Keep whether situation.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,11,4,'Age put Mr most build. Cultural physical act billion especially war really. Ahead while see benefit management weight return. According above official long total better.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,21,8,'Jeter larme mari portier. Animal fauteuil dent nouveau enfance curiosité. Ce nuit distance remplir sept.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,51,46,'Let behavior knowledge general among. Really authority whom he talk under various anything. You past fact effort throughout fall. Money discover large official. Too seek rise in chair true bag.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,13,57,'Laugh along rule long. Western particular find including picture necessary article. Concern care want memory long.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,4,23,'Ipsam voluptas aut culpa similique alias qui. Dicta dignissimos aperiam placeat suscipit sapiente molestiae.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,2,10,'From lawyer family. Large although yourself statement many interview recent. Doctor attack maybe administration develop.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,47,37,'Étranger plaindre échapper dire son faveur. Rejeter briller croiser court. Espace figurer président profond chasse muet presser son.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,59,56,'Culpa quia repellendus eius optio. Dolore animi ad cum similique autem quod. Officia tempore consectetur quo reiciendis. Nisi excepturi beatae doloremque quasi.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,16,17,'Suddenly war effort coach add spend respond. Letter writer write third side.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,21,61,'Himself imagine camera fall up my example attorney. Test begin chair design civil resource painting. Term ability they pick relate daughter control.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,54,22,'Aliquid architecto suscipit architecto placeat distinctio ratione. Officia unde eligendi reprehenderit minus nemo quas. Voluptatem iusto animi quibusdam. Magni odit consectetur atque numquam.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,20,7,'Esse eum minima consequatur illum.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,55,44,'Transformer rejeter dautres chien. Large gros ordre autre. Crier aussitôt sans glisser or. Sourd ami près marche. Vivant victime fauteuil. De plaine âge tromper oreille exposer naître.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,23,35,'Fort on écarter doucement masse. Causer envelopper protéger pluie. Vif vide craindre table auteur mémoire ramener roche. Malheur maître anglais nuit. Empire détruire sembler accent.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,40,43,'Quam exercitationem voluptates velit. Iusto magnam alias amet cupiditate tempora.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,7,57,'Huge seem into let quickly account. Actually color national. Thus wonder tell listen. Store behavior put let relate entire establish loss. Occur remember human think another process.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,26,12,'Dignissimos cumque repellat alias molestiae placeat laborum. Itaque similique quibusdam iste fuga beatae. Harum provident libero nostrum.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,61,52,'Test like stock him where much left home. Talk anything trouble main. International trip middle agent sort. Present animal water huge bank seven.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,62,63,'Détruire riche rassurer ah. AujourdHui traîner habitude très présenter rappeler voie. Politique veiller voici entretenir longtemps grand produire transformer.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,64,4,'Voluptas architecto pariatur. Sapiente tempora minima maxime.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,26,29,'Esse cum amet architecto reprehenderit sed. Adipisci aperiam sint minima.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,26,48,'Id quae ullam placeat. Vitae dignissimos quis exercitationem. Cumque nobis accusamus consequatur asperiores. Aspernatur harum laboriosam ducimus veritatis. Esse qui doloribus culpa.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,23,9,'Possimus id occaecati accusamus magni. Ullam reprehenderit ab. Accusamus adipisci atque eum. Minima omnis itaque error numquam et. Rem quod ut ipsa. Sunt harum quis porro.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,22,53,'Patron dix rapport habiter préparer. Feu conseil rêver. Froid aujourdhui rare tâche. Parler souvenir fois bras vous. Tôt perdre savoir lettre aimer certain amour.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,4,10,'Illum sequi adipisci incidunt. Possimus provident in quia. Similique unde vero officiis molestias minima laudantium.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,27,64,'Incidunt adipisci harum cumque expedita ducimus a. Sint nobis excepturi neque. Dolore vitae dolorem praesentium vel iusto quaerat.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,45,30,'Dolores quae provident id. Veritatis quo beatae unde quis odio aut. In corporis aliquid quibusdam. Distinctio laboriosam quisquam enim nam. Aspernatur quis necessitatibus itaque qui quae doloribus.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,6,17,'Tempora aperiam exercitationem animi exercitationem illum accusantium. Recusandae voluptatibus blanditiis asperiores. Molestias adipisci laboriosam omnis iure illo.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,51,47,'Tranquille fin premier rare. Muet nous espace gagner trace cruel riche disparaître. Défaut aussitôt droit après immense courant. Douleur bas chercher meilleur.');
INSERT INTO Uzenet(idopont,kuldo_id,cimzett_id,szoveg) VALUES(SYSTIMESTAMP,42,64,'Particular bar able. Religious line serve right edge. Degree list miss Congress think hear. Protect soldier color serious film. If technology pretty investment feeling really police.');

COMMIT;
/
