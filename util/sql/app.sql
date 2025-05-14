SELECT
    nfce.dataemissao as "Data de emissão",
    nfce.controle as "Controle",
    nfce.valordesconto as "Desconto",
    nfce.valordescontoitem as "Desconto no item",
    nfce.valortotalnfce as "Total",
    form.valorpago as "Valor pago",
    form.especie as "Espécie"

FROM
    tvendanfce nfce

INNER JOIN
    tformapagamentonfce form on form.codnfce = nfce.controle

WHERE
    nfce.dataemissao BETWEEN '05-11-2025' AND '05-11-2025' AND
    nfce.protocolocancelamento IS NULL AND
    (nfce.statusenvio like '%Autorizado o uso da NF-e%'
    or nfce.statusenvio like '%Emitida em contingência%') AND
    form.valorpago > 0

ORDER BY
    nfce.dataemissao,
    nfce.valordesconto,
    nfce.valordescontoitem,
    nfce.valortotalnfce

