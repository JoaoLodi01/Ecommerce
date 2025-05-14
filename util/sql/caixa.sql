select
    codespecie,
    especie,
    sum(valorpago) total

from(
    select

    codespecie,
    especie,
    valorpago,
    nfce.dataemissao data,
    cast(nfce.horasaidaentrada as time) horario,
    nfce.codoperador codfuncionario,
    nfce.centrocusto,
    form.tipolancamentofinanceiro tipo

    from tformapagamentonfce form
    inner join tvendanfce nfce
    on form.codnfce = nfce.controle

    where (codnfce in(select controle from tvendanfce
        where (protocolocancelamento is null)
        and nfce.protocolocancelamento is null
        and nfce.inutilizada is null
        and (nfce.statusenvio like '%Autorizado o uso da NF-e%'
        or nfce.statusenvio like '%Emitida em contingência%')
        and nfce.sat <> 'SIM' )

    )

    union all

    select

    form.codespecie,
    form.especie,
    valorpago,
    nm.dataemissao data,
    cast(nm.horafaturada as time) horario,
    nm.codfuncionario codfuncionario,
    nm.centrocusto,
    form.tipolancamentofinanceiro tipo

    from tformapagamentonotamanual form
    inner join tnotaconsumidor nm
    on form.codnotamanual = nm.controle

    where nm.cancelado <> 'SIM'
    and nm.datafaturada is not null
    AND NM.FATURADA = 'SIM'

    union all

    select

    tca.codespecie,
    tca.especie,
    (tca.valorentrada - tca.valorsaida) valorpago,
    cast(tca.datahoracadastro as date) data,
    cast(tca.datahoracadastro as time) horario,
    tca.codfuncionario codfuncionario,
    tca.centrocusto,
    'CAIXA' tipo

    from tcaixa tca
    inner join treceber tre on
    tca.codreceber = tre.controle

    where tca.controle is null                                        

)a

where data between '11.05.2025' and '11.05.2025'

and centrocusto = 'JENNIFER'


group by codespecie, especie

having sum(valorpago) > 0

order by codespecie