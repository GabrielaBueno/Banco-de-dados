SELECT
	set_nome AS 'Nome Setor',
    SUM(cot_voltot) AS 'Volume Financeiro Total'
FROM 
	setor 
    NATURAL JOIN subsetor
    NATURAL JOIN segmento
    NATURAL JOIN empresa
    NATURAL JOIN acao
    NATURAL JOIN cotacao
GROUP BY set_codigo;
