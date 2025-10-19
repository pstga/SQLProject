--Creare tabele
CREATE TABLE Client (
  id NUMBER PRIMARY KEY,
  nume VARCHAR2(100) NOT NULL,
  nr_telefon VARCHAR2(20),
  email VARCHAR2(100) NOT NULL UNIQUE,
  zi_nastere DATE
);

CREATE TABLE Curier (
  id_curier NUMBER PRIMARY KEY,
  nume VARCHAR2(100) NOT NULL,
  nr_telefon VARCHAR2(20),
  ore_munca NUMBER,
  salariu NUMBER(10,2)
);

CREATE TABLE Comanda (
  id_comanda NUMBER PRIMARY KEY,
  id NUMBER NOT NULL,
  id_curier NUMBER NOT NULL,
  data DATE DEFAULT SYSDATE,

  CONSTRAINT fk_client FOREIGN KEY (id) REFERENCES Client(id),
  CONSTRAINT fk_curier FOREIGN KEY (id_curier) REFERENCES Curier(id_curier)
);

CREATE TABLE RecordLabel (
  id_casa NUMBER PRIMARY KEY,
  nume VARCHAR2(100) NOT NULL,
  tara VARCHAR2(50)
);

CREATE TABLE Produs (
  id_produs NUMBER PRIMARY KEY,
  nume VARCHAR2(100) NOT NULL,
  cantitate NUMBER NOT NULL,
  pret NUMBER(10,2) NOT NULL
);

CREATE TABLE Album (
  id_produs NUMBER PRIMARY KEY,
  id_casa NUMBER,
  artist VARCHAR2(100),
  nr_discuri NUMBER,
  FOREIGN KEY (id_produs) REFERENCES Produs(id_produs),
  FOREIGN KEY (id_casa) REFERENCES RecordLabel(id_casa)
);

CREATE TABLE Vinyl (
  id_produs NUMBER PRIMARY KEY,
  id_casa NUMBER,
  artist VARCHAR(100),
  varianta NUMBER,
  FOREIGN KEY (id_produs) REFERENCES Produs(id_produs),
  FOREIGN KEY (id_casa) REFERENCES RecordLabel(id_casa)
);

CREATE TABLE Instrument (
  id_produs NUMBER PRIMARY KEY,
  tip VARCHAR2(50),
  material VARCHAR2(50),
  FOREIGN KEY (id_produs) REFERENCES Produs(id_produs)
);

CREATE TABLE Factura (
    id_comanda INT PRIMARY KEY,
    pret DECIMAL(10, 2) NOT NULL,
    mod_de_plata VARCHAR(20) DEFAULT 'ramburs' CHECK (mod_de_plata IN ('ramburs', 'card')),
    FOREIGN KEY (id_comanda) REFERENCES comanda(id_comanda)
);

CREATE TABLE orderWindow (
    id_comanda INT,
    id_produs INT,
    cantitate INT NOT NULL CHECK (cantitate >= 1),
    PRIMARY KEY (id_comanda, id_produs),
    FOREIGN KEY (id_comanda) REFERENCES comanda(id_comanda),
    FOREIGN KEY (id_produs) REFERENCES produs(id_produs)
);

CREATE TABLE Nota (
    id INT,
    id_produs INT,
    nota INT CHECK (nota BETWEEN 1 AND 10),
    FOREIGN KEY (id) REFERENCES Client(id),
    FOREIGN KEY (id_produs) REFERENCES Produs(id_produs)
);

--Inserare date
INSERT INTO Client (id, nume, nr_telefon, email, zi_nastere)
VALUES (1,'Gigel Ionescu', '0722123456', 'gigel.ionescu@gmail.com', 1983-01-01);
INSERT INTO Client (id, nume, nr_telefon, email, zi_nastere)
VALUES (2,'Petrica Marinescu', '0722233445', 'petrica.marinescu@gmail.com', 1999-12-26);
INSERT INTO Client (id, nume, nr_telefon, email, zi_nastere)
VALUES (3,'Strutul Modest', '0700556677', 'strutul.modest@gmail.com', 1981-12-02);
INSERT INTO Client (id, nume, nr_telefon, email)
VALUES (4,'Britney Spears', '412-222-5555', 'hitmebabyonemoretime@gmail.com');
INSERT INTO Client (id, nume, nr_telefon, email)
VALUES (5,'Batman', '0724504188', 'liliacul.salvator@gmail.com');
INSERT INTO Client (id, nume, nr_telefon, email, zi_nastere)
VALUES (6,'Ioana Grigore', '0769888444', 'ioana.grigore@gmail.com', 1974-05-12);
INSERT INTO Client (id, nume, nr_telefon, email)
VALUES (7,'Camil Petrescu', '0719601988', 'patullui.procust@gmail.com');
INSERT INTO Client (id, nume, nr_telefon, email)
VALUES (8,'Ion AlGlanetasului', '0754332331', 'ion.din.pripas@yahoo.com');
INSERT INTO Client (id, nume, nr_telefon, email)
VALUES (9,'Marius Andrei', '0711235813', 'marius.andrei@yahoo.com');
INSERT INTO Client (id, nume, nr_telefon, email)
VALUES (10,'Andreea Maria', '0716778990', 'andreea.maria@gmail.com');

INSERT INTO Curier (id_curier, nume, nr_telefon, ore_munca, salariu) VALUES
(1, 'Alina Vasile', '0744566778', 25, 4000.00);
INSERT INTO Curier (id_curier, nume, nr_telefon, ore_munca, salariu) VALUES
(2, 'Corleone Brat', '0783445112', 30, 4020.00);
INSERT INTO Curier (id_curier, nume, nr_telefon, ore_munca, salariu) VALUES
(3, 'Maricica Paraschiv', '0722123456', 28, 4000.00);
INSERT INTO Curier (id_curier, nume, nr_telefon, ore_munca, salariu) VALUES
(4, 'Eduardo CelMic', '0724500600', 24, 3800.00);
INSERT INTO Curier (id_curier, nume, nr_telefon, ore_munca, salariu) VALUES
(5, 'Mickey Mouse', '0723888765', 26, 3900.00);
INSERT INTO Curier (id_curier, nume, nr_telefon, ore_munca, salariu) VALUES
(6, 'Curierul Fan', '0724448765', 40, 4200.00);
INSERT INTO Curier (id_curier, nume, nr_telefon, ore_munca, salariu) VALUES
(7, 'Andrei Ionescu', '0723123456', 40, 3900.00);
INSERT INTO Curier (id_curier, nume, nr_telefon, ore_munca, salariu) VALUES
(8, 'Maria Popa', '0734987654', 35, 3000.00);
INSERT INTO Curier (id_curier, nume, nr_telefon, ore_munca, salariu) VALUES
(9, 'Vlad Dumitrescu', '0755123987', 20, 1800.00);
INSERT INTO Curier (id_curier, nume, nr_telefon, ore_munca, salariu) VALUES
(10, 'Adi CelCeLivreaza', '0725678465', 25, 3900.00);


INSERT INTO Comanda (id_comanda, id, id_curier, data)
VALUES (1, 1, 10, TO_DATE('2025-04-15', 'YYYY-MM-DD'));
INSERT INTO Comanda (id_comanda, id, id_curier)
VALUES (2, 2, 7);
INSERT INTO Comanda (id_comanda, id, id_curier)
VALUES (3, 1, 7);
INSERT INTO Comanda (id_comanda, id, id_curier, data)
VALUES (4, 4, 2, TO_DATE('2024-12-01', 'YYYY-MM-DD'));
INSERT INTO Comanda (id_comanda, id, id_curier)
VALUES (5, 5, 8);
INSERT INTO Comanda (id_comanda, id, id_curier)
VALUES (6, 6, 1);
INSERT INTO Comanda (id_comanda, id, id_curier)
VALUES (7, 7, 10);
INSERT INTO Comanda (id_comanda, id, id_curier)
VALUES (8, 8, 6);
INSERT INTO Comanda (id_comanda, id, id_curier, data)
VALUES (9, 3, 7, TO_DATE('2025-05-01', 'YYYY-MM-DD'));
INSERT INTO Comanda (id_comanda, id, id_curier, data)
VALUES (10, 6, 2, TO_DATE('2025-04-15', 'YYYY-MM-DD'));

INSERT INTO RecordLabel (id_casa, nume, tara)
VALUES (1, 'Universal Music', 'USA');
INSERT INTO RecordLabel (id_casa, nume, tara)
VALUES (2, 'Sony Music', 'Japonia');
INSERT INTO RecordLabel (id_casa, nume, tara)
VALUES (3, 'Warner Music', 'UK');
INSERT INTO RecordLabel (id_casa, nume, tara)
VALUES (4, 'EMI', 'UK');
INSERT INTO RecordLabel (id_casa, nume, tara)
VALUES (5, 'Island Records', 'USA');
INSERT INTO RecordLabel (id_casa, nume, tara)
VALUES (6, 'Columbia Records', 'USA');
INSERT INTO RecordLabel (id_casa, nume, tara)
VALUES (7, 'Atlantic Records', 'USA');
INSERT INTO RecordLabel (id_casa, nume, tara)
VALUES (8, 'Capitol Records', 'USA');
INSERT INTO RecordLabel (id_casa, nume, tara)
VALUES (9, 'Def Jam Recordings', 'USA');
INSERT INTO RecordLabel (id_casa, nume, tara)
VALUES (10, 'BMG Rights Management', 'Germania');

INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (1, 'Alveolar', 160, 34.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (2, 'Visatori cu PLumb in Ochi', 30, 40.50);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (3, 'Arhitectul din Babel', 32, 44.55);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (4, 'ZABA', 60, 85.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (5, 'How To Be a Human Being', 57, 80.19);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (6, 'Dreamland', 70, 80.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (7, 'ILYSFM', 68, 82.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (8, 'The Open Door', 68, 28.35);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (9, 'Mezmerize', 90, 59.13);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (10, 'This is All Yours', 30, 51.03);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (11, 'Hot Pink', 20, 97.20);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (12, 'Sweetener', 80, 194.40);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (13, 'Dangerous Woman', 40, 162.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (14, 'MAYHEM', 200, 210.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (15, 'Artpop', 190, 200.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (16, 'IMPERA', 30, 105.30);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (17, 'Dreamland', 20, 110.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (18, 'Toxicity', 12, 105.30);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (19, 'Fear of the Dark', 70, 129.60);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (20, 'So Close To What', 5, 110.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (21, 'Chitara Electrica', 3, 1620.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (22, 'Chitara Acustica', 5, 1900.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (23, 'Chitara Electroacustica', 7, 1701.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (24, 'Chitara Clasica', 2, 1900.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (25, 'Bas Electric', 6, 1782.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (26, 'Vioara', 8, 4050.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (27, 'Clarinet', 2, 9720.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (28, 'Trompeta', 3, 6480.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (29, 'Saxofon', 4, 9000.00);
INSERT INTO Produs (id_produs, nume, cantitate, pret) VALUES (30, 'Pianina', 2, 10500.00);

INSERT INTO Album (id_produs, id_casa, artist, nr_discuri) VALUES (1, 2, 'E-An-Na', 1);
INSERT INTO Album (id_produs, id_casa, artist, nr_discuri) VALUES (2, 2, 'Alternosfera', 2);
INSERT INTO Album (id_produs, id_casa, artist, nr_discuri) VALUES (3, 1, 'Alternosfera', 1);
INSERT INTO Album (id_produs, id_casa, artist, nr_discuri) VALUES (4, 3, 'Glass Animals', 1);
INSERT INTO Album (id_produs, id_casa, artist, nr_discuri) VALUES (5, 6, 'Glass Animals', 1);
INSERT INTO Album (id_produs, id_casa, artist, nr_discuri) VALUES (6, 3, 'Glass Animals', 3);
INSERT INTO Album (id_produs, id_casa, artist, nr_discuri) VALUES (7, 8, 'Glass Animals', 2);
INSERT INTO Album (id_produs, id_casa, artist, nr_discuri) VALUES (9, 4, 'System of a Down', 1);
INSERT INTO Album (id_produs, id_casa, artist, nr_discuri) VALUES (10, 2, 'Alt-J', 1);

INSERT INTO Vinyl (id_produs, id_casa, artist, varianta) VALUES (11, 2, 'Doja Cat', NULL);
INSERT INTO Vinyl (id_produs, id_casa, artist, varianta) VALUES (12, 1, 'Ariana Grande', 3);
INSERT INTO Vinyl (id_produs, id_casa, artist, varianta) VALUES (13, 1, 'Ariana Grande', NULL);
INSERT INTO Vinyl (id_produs, id_casa, artist, varianta) VALUES (14, 4, 'Lady Gaga', 6);
INSERT INTO Vinyl (id_produs, id_casa, artist, varianta) VALUES (15, 6, 'Lady Gaga', NULL);
INSERT INTO Vinyl (id_produs, id_casa, artist, varianta) VALUES (16, 8, 'Ghost', NULL);
INSERT INTO Vinyl (id_produs, id_casa, artist, varianta) VALUES (17, 10, 'Glass Animals', 2);
INSERT INTO Vinyl (id_produs, id_casa, artist, varianta) VALUES (18, 3, 'System of a Down', NULL);
INSERT INTO Vinyl (id_produs, id_casa, artist, varianta) VALUES (19, 5, 'Iron Maiden', NULL);
INSERT INTO Vinyl (id_produs, id_casa, artist, varianta) VALUES (20, 7, 'Tate McRae', NULL);;

INSERT INTO instrument (id_produs, tip, material) VALUES (21, 'Corzi', 'Lemn, Plastic');
INSERT INTO instrument (id_produs, tip, material) VALUES (22, 'Corzi', 'Lemn');
INSERT INTO instrument (id_produs, tip, material) VALUES (23, 'Corzi', 'Lemn');
INSERT INTO instrument (id_produs, tip, material) VALUES (24, 'Corzi', 'Lemn');
INSERT INTO instrument (id_produs, tip, material) VALUES (25, 'Corzi', 'Lemn, Plastic');
INSERT INTO instrument (id_produs, tip, material) VALUES (26, 'Corzi', 'Lemn');
INSERT INTO instrument (id_produs, tip, material) VALUES (27, 'Suflat', 'Otel');
INSERT INTO instrument (id_produs, tip, material) VALUES (28, 'Suflat', 'Alama');
INSERT INTO instrument (id_produs, tip, material) VALUES (29, 'Suflat', NULL);
INSERT INTO instrument (id_produs, tip, material) VALUES (30, 'Corzi', NULL);

INSERT INTO Nota (id, id_produs, nota) VALUES (3, 3, 6);
INSERT INTO Nota (id, id_produs, nota) VALUES (4, 13, 5);
INSERT INTO Nota (id, id_produs, nota) VALUES (1, 20, 10);
INSERT INTO Nota (id, id_produs, nota) VALUES (5, 16, 1);
INSERT INTO Nota (id, id_produs, nota) VALUES (6, 14, 2);
INSERT INTO Nota (id, id_produs, nota) VALUES (6, 8, 8);
INSERT INTO Nota (id, id_produs, nota) VALUES (10, 21, 9);
INSERT INTO Nota (id, id_produs, nota) VALUES (3, 2, 9);
INSERT INTO Nota (id, id_produs, nota) VALUES (7, 5, 7);
INSERT INTO Nota (id, id_produs, nota) VALUES (32, 19, 8);

INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (1, 29, 1);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (2, 1, 1);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (3, 6, 3);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (4, 14, 1);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (4, 15, 1);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (5, 22, 1);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (5, 17, 2);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (6, 4, 4);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (7, 15, 1);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (8, 24, 1);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (9, 7, 2);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (9, 30, 1);
INSERT INTO OrderWindow (id_comanda, id_produs, cantitate) VALUES (10, 20, 3);

INSERT INTO Factura (id_comanda, pret, mod_de_plata) VALUES (1, 9000, 'ramburs');
INSERT INTO Factura (id_comanda, pret, mod_de_plata) VALUES (2, 65, 'ramburs');
INSERT INTO Factura (id_comanda, pret, mod_de_plata) VALUES (3, 240, 'card');
INSERT INTO Factura (id_comanda, pret, mod_de_plata) VALUES (4, 390, 'ramburs');
INSERT INTO Factura (id_comanda, pret, mod_de_plata) VALUES (7, 190, 'ramburs');
INSERT INTO Factura (id_comanda, pret, mod_de_plata) VALUES (8, 1900, 'card');
INSERT INTO Factura (id_comanda, pret, mod_de_plata) VALUES (9, 10664, 'ramburs');
INSERT INTO Factura (id_comanda, pret, mod_de_plata) VALUES (10, 330, 'ramburs');
--Verificare
SELECT * FROM Produs;

COMMIT;