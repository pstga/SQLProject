--in urma feedback-ului primit am adaugat/modificat subpunctul a) de la cerinta 13 astfel incat sa contina o subcerere cu EXISTS
SELECT *
FROM CURIER cu
WHERE EXISTS (
  SELECT 1
  FROM COMANDA co
  JOIN ORDERWINDOW ow ON co.id_comanda = ow.id_comanda
  JOIN CLIENT c ON co.id = c.id
  JOIN NOTA n ON c.id = n.id AND ow.id_produs = n.id_produs
  WHERE co.id_curier = cu.id_curier
    AND n.nota = 9
);