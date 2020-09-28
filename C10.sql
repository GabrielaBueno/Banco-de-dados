SELECT
	ti.tind_nome AS 'Nome',
	count(i.ind_sigla) AS 'Quantidade de indices'
FROM
	tipo_indice ti LEFT OUTER JOIN indice i
    ON i.tind_codigo = ti.tind_codigo
GROUP BY
	ti.tind_codigo;