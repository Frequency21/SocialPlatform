-- insert statements
-- developers
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'oli@gmail.com', NEVTIPUS('Kiss', 'Olivér'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'egyetem', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'ralf@gmail.com', NEVTIPUS('Burza', 'Ralf'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'egyetem', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'etele@gmail.com', NEVTIPUS('Balogh', 'Etele'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'egyetem', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'taylor@gmail.com', NEVTIPUS('Mária', 'Magdolna'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'reptér', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'deny@gmail.com', NEVTIPUS('Szent', 'Péter'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'vasút', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'yndi@gmail.com', NEVTIPUS('Anna', 'Konda'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'kórház', 1);
/

commit;
/

INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Számítógép alkatrészek, adok-veszek','Hardverapró',2);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Adatbázis alapú redszerek helyesírása','Adatb2',1);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Cryptovaluták nyaggatása','Brave New World',3);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('SZTE legjobbjai, a jelszó meg: ******','SZTE4EVER',2);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Lelkisegélyszolgálat az egyetemisták ért','Cryout a hero',2);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Brühühűűűűűű, még nagyon sok mindent kell legépelnem','Suffer 2gether',2);
commit;
/

INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(1, 2);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(1, 3);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(1, 5);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(1, 6);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(2, 3);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(2, 6);
INSERT INTO Ismeros(felhasznalo1_id, felhasznalo2_id) VALUES(7,12);
insert into ismeros(felhasznalo1_id, felhasznalo2_id) VALUES (2, 3);
insert into ismeros(felhasznalo1_id, felhasznalo2_id) VALUES (3, 6);
insert into ismeros(felhasznalo1_id, felhasznalo2_id) VALUES (1, 4);
insert into ismeros(felhasznalo1_id, felhasznalo2_id) VALUES (2, 5);
insert into ismeros(felhasznalo1_id, felhasznalo2_id) VALUES (5, 6);
COMMIT;
/

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 1, null, 2, 'boldog születésnapot', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 1, null, 2, 'Go to hell', ERTEKELES(6,4), 0);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 2, null, 1, 'köszi :*', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 2, null, 1, 'jó az új pulcsid', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 1, null, 2, 'köszi pervollal mosom', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 3, null, 4, 'akarsz hallani egy Gyurcsány viccet?', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 4, null, 3, 'kösz nem', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 5, null, 6, 'mi lesz a vacsi?', ERTEKELES(1,2), 1);

commit;
/

insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) values (systimestamp, 1, 2, 'olah');
insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) values (systimestamp, 2, 1, 'chirio');
insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) values (systimestamp, 1, 2, 'occam házi megvan már? :tireddolife:');
insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) values (systimestamp, 2, 1, ':peposuicide:');
insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) values (systimestamp, 1, 3, 'olah');
insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) values (systimestamp, 3, 1, 'chirio');
insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) values (systimestamp, 1, 3, 'prolog zh-ra készültél már?');
insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) values (systimestamp, 3, 1, ':peposuicide:');
