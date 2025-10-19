-- cerinta 14

--vizualizarea complexa: raport clienti pt total de suma cheltuita
CREATE VIEW raport_clienti AS
SELECT
    c.id AS id_client,
    c.nume AS nume_client,
    COUNT(DISTINCT o.id_comanda) AS nr_comenzi,
    SUM(f.pret) AS total_cheltuit
FROM CLIENT c
JOIN COMANDA o ON c.id = o.id
JOIN FACTURA f ON o.id_comanda = f.id_comanda
JOIN ORDERWINDOW ow ON o.id_comanda = ow.id_comanda
WHERE f.pret > 0
GROUP BY c.id, c.nume
HAVING SUM(f.pret) > 0;

--exemplu de lmd permis pe un tabel permanent
SELECT nume_client, total_cheltuit
FROM raport_clienti
WHERE total_cheltuit > 0
ORDER BY total_cheltuit;

--exemplu de lmd nepermis pe tabel: update
UPDATE raport_clienti
SET total_cheltuit = 0
WHERE id_client = 1;

--cerinta 15:

--vizualizare cu analiza top-n: primii 3 dupa pret total cheltuit
SELECT id, nume, total_cheltuit FROM (
    SELECT c.id, c.nume, SUM(f.pret) AS total_cheltuit
    FROM CLIENT c
    JOIN COMANDA o ON c.id = o.id
    JOIN FACTURA f ON o.id_comanda = f.id_comanda
    GROUP BY c.id, c.nume
    ORDER BY total_cheltuit DESC
) WHERE ROWNUM <= 3;

--vizualizare division: afisam cumparatorii ce au achizitionat toate produsele asociate cu casa de discuri cu id = 1
SELECT c.id, c.nume
FROM CLIENT c
WHERE NOT EXISTS (
    SELECT p.id_produs
    FROM PRODUS p
    JOIN ALBUM a ON p.id_produs = a.id_produs
    WHERE a.id_casa = 1
    AND NOT EXISTS (
        SELECT 1
        FROM COMANDA o
        JOIN ORDERWINDOW ow ON o.id_comanda = ow.id_comanda
        WHERE o.id = c.id AND ow.id_produs = p.id_produs
    )
);

-- interogare cu 4 tabele :toti curierii si fiecare comanda (produsul) livrat de acestia (null pentru cei ce n au livrat nimic, vor fi si ei afisati)
SELECT
    cur.id_curier,
    cur.nume AS nume_curier,
    o.id_comanda,
    f.pret AS pret_factura,
    p.nume AS nume_produs
FROM CURIER cur
LEFT JOIN COMANDA o ON cur.id_curier = o.id_curier
LEFT JOIN FACTURA f ON o.id_comanda = f.id_comanda
LEFT JOIN ORDERWINDOW ow ON o.id_comanda = ow.id_comanda
LEFT JOIN PRODUS p ON ow.id_produs = p.id_produs;

-- cerinta 16

-- interogare simpla pentru a exemplifica si explica arborele algebric relational
SELECT c.nume, SUM(f.pret) AS total_cheltuit
FROM CLIENT c
JOIN COMANDA o ON c.id = o.id
JOIN FACTURA f ON o.id_comanda = f.id_comanda
GROUP BY c.nume
HAVING SUM(f.pret) > 100;