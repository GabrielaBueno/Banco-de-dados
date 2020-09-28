SELECT
	GOV_CODIGO AS 'Sigla nível de Governança',
    GOV_NOME AS 'Nome nível de Governança',
    COUNT(EMP_CODIGO) AS 'Quantidade de empresas participantes'
FROM 
	governanca NATURAL JOIN empresa
GROUP BY GOV_CODIGO
HAVING COUNT(EMP_CODIGO) > 20
ORDER BY GOV_CODIGO;

