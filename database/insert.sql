INSERT INTO SOCIALDISTANCINGTM.FELHASZNALO (JELSZO, EMAIL, NEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN) VALUES ('12345', 'picilady@gmail.com', NEVTIPUS('Adamov', 'Afrodita'), TO_DATE('2021-05-08 16:06:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1997-09-19 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SZTE', 'http://localhost:8081/api/user/profile/1', 1);
INSERT INTO SOCIALDISTANCINGTM.FELHASZNALO (JELSZO, EMAIL, NEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN) VALUES ('12345', 'oli@gmail.com', NEVTIPUS('Kiss', 'Olivér'), TO_DATE('2021-05-08 16:06:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1997-08-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SZTE', 'http://localhost:8081/api/user/profile/2', 1);
INSERT INTO SOCIALDISTANCINGTM.FELHASZNALO (JELSZO, EMAIL, NEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN) VALUES ('12345', 'etele@gmail.com', NEVTIPUS('Etele', 'Balogh'), TO_DATE('2021-05-08 16:06:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2001-02-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SZTE', 'http://localhost:8081/api/user/profile/3', 1);
INSERT INTO SOCIALDISTANCINGTM.FELHASZNALO (JELSZO, EMAIL, NEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN) VALUES ('12345', 'ralf@gmail.com', NEVTIPUS('Burza', 'Ralf'), TO_DATE('2021-05-08 16:07:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1999-02-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'SZTE', 'http://localhost:8081/api/user/profile/4', 0);
INSERT INTO SOCIALDISTANCINGTM.FELHASZNALO (JELSZO, EMAIL, NEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN) VALUES ('12345', 'taylor@gmail.com', NEVTIPUS('Taylor', 'Sor'), TO_DATE('2021-05-08 16:08:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1997-08-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'backend', 'http://localhost:8081/api/user/profile/5', 1);
INSERT INTO SOCIALDISTANCINGTM.FELHASZNALO (JELSZO, EMAIL, NEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN) VALUES ('12345', 'yndiliadrion@gmail.com', NEVTIPUS('Yndi', 'Liadring'), TO_DATE('2021-05-08 16:08:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1999-04-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'frontend', 'http://localhost:8081/api/user/profile/6', 1);
INSERT INTO SOCIALDISTANCINGTM.FELHASZNALO (JELSZO, EMAIL, NEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN) VALUES ('12345', 'deny@gmail.com', NEVTIPUS('De', 'Ny'), TO_DATE('2021-05-08 16:09:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2001-04-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'frontend', 'http://localhost:8081/api/user/profile/7', 0);

INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'geralt@gmail.com', NEVTIPUS('Ríviai', 'Geralt'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'egyetem', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'hawk@gmail.com', NEVTIPUS('Stephen', 'Hawking'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'egyetem', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'einstein@gmail.com', NEVTIPUS('Albert', 'Einstein'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'egyetem', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'magdolna@gmail.com', NEVTIPUS('Mária', 'Magdolna'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'reptér', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'peter@gmail.com', NEVTIPUS('Szent', 'Péter'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'vasút', 1);
INSERT INTO Felhasznalo (jelszo, email, nev, csatl_dat, szul_dat, munka_iskola, isAdmin) VALUES ('12345', 'marie@gmail.com', NEVTIPUS('Marie', 'Curie'), SYSTIMESTAMP, TO_DATE('2020/04/21', 'yyyy/mm/dd'), 'kórház', 1);

INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Számítógép alkatrészek, adok-veszek','Hardverapró',2);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Adatbázis alapú redszerek helyesírása','Adatb2',1);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Cryptovaluták nyaggatása','Brave New World',3);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('SZTE legjobbjai, a jelszó meg: ******','SZTE4EVER',2);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Lelkisegélyszolgálat az egyetemisták ért','Cryout a hero',2);
INSERT INTO Csoport(leiras,nev,tulaj_id) VALUES('Brühühűűűűűű, még nagyon sok mindent kell legépelnem','Suffer 2gether',2);

INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(1, 2);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(1, 3);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(1, 4);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(1, 5);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(1, 6);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(2, 3);
insert into ismeros(felhasznalo1_id, felhasznalo2_id) VALUES(2, 5);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(2, 6);
insert into ismeros(felhasznalo1_id, felhasznalo2_id) VALUES(3, 6);
insert into ismeros(felhasznalo1_id, felhasznalo2_id) VALUES(5, 6);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 1, null, 2, 'boldog születésnapot', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 2, null, 1, 'köszi :*', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 2, null, 1, 'jó az új pulcsid', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 1, null, 2, 'köszi pervollal mosom', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 1, null, 2, 'Go to hell', ERTEKELES(6,4), 0);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 3, null, 4, 'akarsz hallani egy Gyurcsány viccet?', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 4, null, 3, 'kösz nem', ERTEKELES(1,2), 1);

insert into POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)
values (systimestamp, 5, null, 6, 'mi lesz a vacsi?', ERTEKELES(1,2), 1);

insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) VALUES(systimestamp, 10, 13, 'E=\gamma \dot mc^2');
insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) VALUES(systimestamp, 13, 10, 'what about Bose-Einstein condenstation?');
insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) VALUES(systimestamp, 10, 13, 'Time is relative');

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
