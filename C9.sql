SELECT
	e.emp_codigo AS 'Codigo empresa',
    e.emp_nome AS	'Nome de pregão',
    COUNT(a.acao_codigo) AS 'Quantidade de ações'
FROM
	empresa e LEFT OUTER JOIN acao a
    ON e.emp_codigo = a.emp_codigo
GROUP BY e.emp_codigo
ORDER BY COUNT(a.acao_codigo);