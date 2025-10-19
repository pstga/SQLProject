--selecteaza toate comenzile cu albume livrate de curieri cu salariul de peste 3000 de lei
SELECT c.nume
FROM Client c
JOIN Comanda com ON c.id = com.id
JOIN OrderWindow ow ON com.id_comanda = ow.id_comanda
JOIN Album a ON ow.id_produs = a.id_produs
JOIN Curier cu ON com.id_curier = cu.id_curier
WHERE cu.salariu > 3000;

--selecteaza si sorteaza descrescatori comenzile in functie de numarul de produse comandate in fiecare
SELECT o.id_comanda
FROM (
    SELECT id_comanda, SUM(cantitate) AS total_produse
    FROM OrderWindow
    GROUP BY id_comanda
) o
ORDER BY o.total_produse DESC;

--id ul clientilor care au comandat in total mai mult de 5 produse
SELECT c.id, COUNT(DISTINCT com.id_comanda) AS nr_comenzi
FROM Client c
JOIN Comanda com ON c.id = com.id
JOIN (
    SELECT id_comanda, SUM(cantitate) AS total
    FROM OrderWindow
    GROUP BY id_comanda
) ow ON com.id_comanda = ow.id_comanda
GROUP BY c.id
HAVING SUM(ow.total) > 5;


--se afiseaza clientii ce au plasat cel putin 2 comenzi si se afiseaza varsta lor (daca au data de nastere inregistrata), ultima comanda si gradul de fidelitate
WITH clienti_comenzi AS (
  SELECT
    c.id,
    INITCAP(c.nume) AS nume,
    COUNT(com.id_comanda) AS nr_comenzi,
    MAX(com.data) AS ultima_comanda,
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM c.zi_nastere) AS varsta
  FROM Client c
  JOIN Comanda com ON c.id = com.id
  GROUP BY c.id, c.nume, c.zi_nastere
)
SELECT
  id AS "ID Client",
  nume AS "Nume Client",
  nr_comenzi AS "Număr Comenzi",
  TO_CHAR(ultima_comanda, 'DD Mon YYYY') AS "Ultima Comandă",
  varsta AS "Vârstă",
  CASE
    WHEN nr_comenzi >= 10 THEN 'VIP'
    WHEN nr_comenzi >= 5 THEN 'Frecvent'
    ELSE 'Ocazional'
  END AS "Categorie Client"
FROM clienti_comenzi
WHERE nr_comenzi >= 2
ORDER BY nr_comenzi DESC;

--se afiseaza varsta clientului, sau "Necunoscut" daca este null
SELECT
  id AS "ID Client",
  INITCAP(nume) AS "Nume Client",
  NVL(
    TO_CHAR(zi_nastere, 'DD Month YYYY', 'NLS_DATE_LANGUAGE = ENGLISH'),
    'Necunoscută'
  ) AS "Zi de Naștere",
  CASE
    WHEN zi_nastere IS NULL THEN 'Vârstă necunoscută'
    ELSE TO_CHAR(TRUNC(MONTHS_BETWEEN(SYSDATE, zi_nastere) / 12)) || ' ani'
  END AS "Vârstă"
FROM Client
ORDER BY "Nume Client";

--update uri si delete uri

--se ofera o reducere de 10% la produsele ce nu au fost comandate
UPDATE Produs
SET pret = pret * 0.9
WHERE id_produs NOT IN (
  SELECT DISTINCT id_produs
  FROM OrderWindow
);

--se sterg albumele lansate de o casa de discuri bazata in Germania
DELETE FROM Album
WHERE id_produs IN (
  SELECT a.id_produs
  FROM Album a
  JOIN RecordLabel rl ON a.id_casa = rl.id_casa
  WHERE rl.tara = 'Germania'
);

--schimba modul de plata in “card” pentru clientii cu ziua de nastere in luna curenta
UPDATE Factura
SET mod_de_plata = 'card'
WHERE id_comanda IN(
  SELECT id
  FROM Client
  WHERE EXTRACT(MONTH FROM zi_nastere) = EXTRACT(MONTH FROM SYSDATE)
);

commit;