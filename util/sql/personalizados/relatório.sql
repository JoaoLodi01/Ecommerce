SELECT
    'CAIXA' as "Origem",
    cx.documento as "Documento",
    cx.descricaolancamento as "Descrição",
    cx.valorsaida as "Valor pago",
    cx.datahoracadastro as "Data da movimentação"

FROM
    tcaixa cx

WHERE
    cx.valorentrada <= 0

UNION ALL

SELECT
    'PAGAR' as "Origem",
    bc.documento as "Documento",
    pg.descricaolancamento as "Descrição",
    bc.valorsaida as "Valor pago",
    bc.datahoracadastro as "Data da movimentação"

FROM
    tmovbanco bc

INNER JOIN
    tpagar pg on pg.documento = bc.documento

WHERE
    pg.datapagamento BETWEEN '2025-05-11' AND '2025-05-11' 
;