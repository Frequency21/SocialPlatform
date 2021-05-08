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

INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(7, 1);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(7, 2);
INSERT INTO ISMEROS(felhasznalo1_id, felhasznalo2_id) VALUES(7, 3);
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