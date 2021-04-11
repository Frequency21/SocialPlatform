SET SERVEROUTPUT ON
DECLARE 
   type namesarray IS VARRAY(10) OF VARCHAR2(16); 
   type tarray IS VARRAY(2) OF VARCHAR2(11); 
   names namesarray := namesarray('Komment', 'Felhasznalo', 'Hirfolyam', 'Csoport', 'Poszt','Uzenet','Meghivas','Fenykepalbum','Kategoria','Fenykep');
   marks tarray := tarray('NEVTIPUS','ERTEKELES'); 
   total integer;
   parancs VARCHAR2(80);
   tbl_exists PLS_INTEGER;
   tp_exists PLS_INTEGER;
BEGIN  
   total := names.count; 
   FOR i in 1 .. total LOOP
        SELECT COUNT(*) INTO tbl_exists FROM user_tables WHERE table_name = 'names(i)';
        IF tbl_exists = 1 then
            parancs := 'DROP TABLE ' || names(i) || ' CASCADE CONSTRAINTS';
            EXECUTE IMMEDIATE parancs;
        END IF;
   END LOOP;
   
   total := marks.count; 
   FOR j in 1 .. total LOOP
        SELECT COUNT(*) INTO tp_exists FROM user_types WHERE type_name = 'marks(j)';
        IF tp_exists = 1 then
            parancs := 'DROP TYPE ' || marks(j);
            EXECUTE IMMEDIATE parancs;
        END IF;
    END LOOP;
   
    EXECUTE IMMEDIATE '
        CREATE TYPE NEVTIPUS AS OBJECT (
            keresztnev VARCHAR(10),
            vezeteknev VARCHAR(10)
        );

        CREATE TYPE ERTEKELES AS OBJECT (
            like_szamlalo    NUMBER,
            dislike_szamlalo NUMBER
        );

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

        CREATE TABLE Hirfolyam(
            ID              NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY
        );

        CREATE TABLE Csoport(
            csoport_id      NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
            leiras          VARCHAR(25),
            nev             VARCHAR(10) NOT NULL,
            tulaj_id        NUMBER NOT NULL,
            hirfolyam_id    NUMBER NOT NULL,
            FOREIGN KEY (hirfolyam_id) REFERENCES Hirfolyam(ID),
            FOREIGN KEY (tulaj_id) REFERENCES Felhasznalo(ID)
        );

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

        CREATE TABLE Uzenet(
            idopont         TIMESTAMP WITH LOCAL TIME ZONE PRIMARY KEY,
            kuldo_id        NUMBER NOT NULL,
            cimzett_id      NUMBER NOT NULL,
            szoveg          NCHAR(25),
            FOREIGN KEY (kuldo_id) REFERENCES Felhasznalo(ID),
            FOREIGN KEY (cimzett_id) REFERENCES Felhasznalo(ID)
        );

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

        CREATE TABLE Fenykepalbum(
            album_id        NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
            felhasznalo_id  NUMBER NOT NULL,
            FOREIGN KEY (felhasznalo_id) REFERENCES Felhasznalo(ID)
        );

        CREATE TABLE Kategoria(
            nev             NCHAR(10) PRIMARY KEY,
            fenykepalbum_id NUMBER,
            FOREIGN KEY (fenykepalbum_id) REFERENCES Fenykepalbum(album_id)
        );

        CREATE TABLE Fenykep(
            kep_id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            kep             BLOB NOT NULL,
            nev             NCHAR(10) NOT NULL,
            kategoria_id    NCHAR(10) NOT NULL,
            FOREIGN KEY (kategoria_id) REFERENCES Kategoria(nev)
        );
    
    COMMIT;';

END; 
/
