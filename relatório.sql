SELECT
    'CAIXA' as "Origem",
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
    pg.descricaolancamento as "Descrição",
    bc.valorsaida as "Valor pago",
    bc.datahoracadastro as "Data da movimentação"

FROM
    tmovbanco bc

INNER JOIN
    tpagar pg on pg.documento = bc.documento

WHERE
    bc.valorentrada <= 0
;