select
        (vendaliquida) totalcaixa,
        sangria,
        suprimento

        from(

        select
                sum(sangria) sangria,
                sum(suprimento) suprimento,
                sum(transferencia) transferencia,
                sum(recebimentos) recebimentos,
                sum(vendaliquida) vendaliquida

                from(

                select
                    (valorsaida) as sangria,
                    0 suprimento,
                    0 transferencia,
                    0 recebimentos,
                    0 vendaliquida,
                    cast(datahoracadastro as date) data,
                    Cast(datahoracadastro as time) horario,
                    tca.codfuncionario codfuncionario,
                    tca.centrocusto centrocusto
                from
                    tcaixa tca
                where
                    origem = 'SANGRIA NFCE'

                union all

                select
                    0 sangria,
                    (valorentrada) as suprimento,
                    0 transferencia,
                    0 recebimentos,
                    0 vendaliquida,
                    cast(datahoracadastro as date) data,
                    Cast(datahoracadastro as time) horario,
                    tca.codfuncionario codfuncionario,
                    tca.centrocusto centrocusto
                from
                    tcaixa tca
                where
                    origem = 'SUPRIMENTO NFCE'

                union all

                select
                    0 sangria,
                    0 suprimento,
                    0 as transferencia,
                    0 recebimentos,
                    0 vendaliquida,
                    cast(datahoracadastro as date) data,
                    Cast(datahoracadastro as time) horario,
                    codfuncionario codfuncionario,
                    centrocusto centrocusto
                from
                    tcaixa                                                                    

                union all

                select
                0 sangria,
                0 suprimento,
                0 transferencia,
                (valorentrada - valorsaida) as recebimentos,
                0 vendaliquida,
                Cast(datahoracadastro as date) data,
                Cast(datahoracadastro as time) horario,
                codfuncionario codfuncionario,
                centrocusto centrocusto

            from tcaixa

            where
                codreceber IS NOT NULL
                and (origem not like '%SANGRIA%') AND (origem not like '%SUPRIMENTO%')

            union all

            Select
                0 sangria,
                0 suprimento,
                0 transferencia,
                0 recebimentos,
                coalesce((valortotalnfce), 0) as vendaliquida,
                nfce.dataemissao data ,
                nfce.horasaidaentrada horario,
                nfce.codoperador codfuncionario,
                nfce.centrocusto centrocusto

            from tvendanfce nfce

            where
                (statusenvio = 'Emitida em contingência' or protocolo is not null)
                and sat = 'NÃO'

                )a

            where data between '11.05.2025' and '11.05.2025'
            
            and centrocusto = 'JENNIFER'

    )b 
    [13/05/2025 12:40:46.69 - 00:00:00]: NFCe - 1º parte do fechamento por período: select
    sum(vendabruta + vendabrutanfce) vendabruta,
    sum(canceladas + canceladasnfce) canceladas,
    sum(descontos + descontosnfce) descontos,
    sum(acrescimos + acrescimosnfce) acrescimos,
    sum(recebimentos) recebimentos,
    sum(taxaservico + taxaserviconfce) taxaservico,
    sum(vendaliquida + vendaliquidanfce) vendaliquida,
    sum(valorcondicao + valorcondicaonfce) valorcondicao

    from(

    select
    nm.totalbruto vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 as descontosnfce,
    0 acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida,
    0 vendaliquidanfce,
    cast(nm.dataehoracadastro as date) data,
    cast(nm.dataehoracadastro as time) horario,
    nm. codfuncionario,
    nm.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tnotaconsumidor nm


    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    nm.totalnota as canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 as descontosnfce,
    0 acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida,
    0 vendaliquidanfce,
    cast(nm.dataehoracadastro as date) data,
    cast(nm.dataehoracadastro as time) horario,
    nm. codfuncionario,
    nm.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tnotaconsumidor nm


    where nm.cancelado = 'SIM'

    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    coalesce((nm.desconto), 0) as descontos,
    0 as descontosnfce,
    0 acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida,
    0 vendaliquidanfce,
    cast(nm.dataehoracadastro as date) data,
    cast(nm.dataehoracadastro as time) horario,
    nm. codfuncionario,
    nm.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tnotaconsumidor nm

    where
    nm.cancelado <> 'SIM'
    and faturada = 'SIM'

    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 as descontosnfce,
    coalesce((nm.outrosvalores), 0) as acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida,
    0 vendaliquidanfce,
    cast(nm.dataehoracadastro as date) data,
    cast(nm.dataehoracadastro as time) horario,
    nm. codfuncionario,
    nm.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tnotaconsumidor nm

    where nm.cancelado <> 'SIM'
    and faturada = 'SIM'

    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 as descontosnfce,
    0 as acrescimos,
    0 acrescimosnfce,
    (valorentrada - valorsaida) as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida ,
    0 vendaliquidanfce,
    Cast(datahoracadastro as date) data,
    Cast(datahoracadastro as time) horario,
    codfuncionario codfuncionario,
    centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tcaixa tca

    where
    codreceber IS NOT NULL 
    and (tca.origem not like '%SANGRIA%') AND (tca.origem not like '%SUPRIMENTO%')

    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 as descontosnfce,
    0 as acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    coalesce(taxaservico, 0) as taxaserviconfce,
    0 vendaliquida ,
    0 vendaliquidanfce,
    Cast(tc.datafechamento as date) data,
    Cast(tc.horafechamento as time) horario,
    nfce.codoperador codfuncionario,
    nfce.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tvendanfce nfce
    inner join tcomanda tc
    on nfce.codcomanda = tc.controle

    where
    tc.datafechamento is not null
    and nfce.protocolo is not null
    and nfce.protocolocancelamento is null
    and nfce.statusenvio = 'Autorizado o uso da NF-e'

    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 as descontosnfce,
    0 as acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    coalesce(taxaservico, 0) as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida ,
    0 vendaliquidanfce,
    Cast(tc.datafechamento as date) data,
    Cast(tc.horafechamento as time) horario,
    nm.codfuncionario codfuncionario,
    nm.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tnotaconsumidor nm
    inner join tcomanda tc
    on nm.codmodulo = tc.controle

    where
    nm.modulo = 'COMANDAS'
    and nm.datafaturada is not null
    and nm.cancelado <> 'SIM'

    union all

    Select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 as descontosnfce,
    0 as acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    coalesce((nm.totalnota), 0) as vendaliquida,
    0 vendaliquidanfce,
    cast(nm.dataehoracadastro as date) data,
    cast(nm.dataehoracadastro as time) horario,
    nm. codfuncionario,
    nm.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tnotaconsumidor nm

    where nm.cancelado <> 'SIM'
    and faturada = 'SIM'
    and nm.datafaturada is not null

    union all

    select
    0 vendabruta,
    (nfce.valortotalnfce + nfce.valordesconto - nfce.valoroutros) vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 as descontosnfce,
    0 acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida,
    0 vendaliquidanfce,
    cast(nfce.dataemissao as date) data,
    cast(nfce.horasaidaentrada as time) horario,
    nfce.codoperador codfuncionario,
    nfce.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tvendanfce nfce

    where nfce.dataemissao is not null

    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    nfce.valortotalnfce as canceladasnfce,
    0 as descontos,
    0 as descontosnfce,
    0 acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida,
    0 vendaliquidanfce,
    cast(nfce.dataehoracadastro as date) data,
    cast(nfce.dataehoracadastro as time) horario,
    nfce. codfuncionario,
    nfce.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tvendanfce nfce

    where nfce.dataehoracancelamento is not null
    and nfce.inutilizada is null

    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    nfce.valordesconto descontosnfce,
    0 acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida,
    0 vendaliquidanfce,
    cast(nfce.dataehoracadastro as date) data,
    cast(nfce.dataehoracadastro as time) horario,
    nfce. codfuncionario,
    nfce.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tvendanfce nfce

    where nfce.valordesconto > 0
    and nfce.protocolocancelamento is null
    and nfce.inutilizada is null
    and (nfce.statusenvio like '%Autorizado o uso da NF-e%'
    or nfce.statusenvio like '%Emitida em contingência%')
    and nfce.sat <> 'SIM'

    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 descontosnfce,
    0 acrescimos,
    nfce.valoroutros acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida,
    0 vendaliquidanfce,
    cast(nfce.dataehoracadastro as date) data,
    cast(nfce.dataehoracadastro as time) horario,
    nfce. codfuncionario,
    nfce.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tvendanfce nfce

    where nfce.valoroutros > 0
    and nfce.protocolocancelamento is null
    and nfce.inutilizada is null
    and (nfce.statusenvio like '%Autorizado o uso da NF-e%'
    or nfce.statusenvio like '%Emitida em contingência%')
    and nfce.sat <> 'SIM'

    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 descontosnfce,
    0 acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida,
    nfce.valortotalnfce vendaliquidanfce,
    cast(nfce.dataemissao as date) data,
    cast(nfce.horasaidaentrada as time) horario,
    nfce.codoperador codfuncionario,
    nfce.centrocusto centrocusto,
    0 as valorcondicao,
    0 as valorcondicaonfce

    from tvendanfce nfce

    where protocolocancelamento is null
    and nfce.inutilizada is null
    and (nfce.statusenvio like '%Autorizado o uso da NF-e%'
    or nfce.statusenvio like '%Emitida em contingência%')
    and nfce.sat <> 'SIM'

    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 descontosnfce,
    0 acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida,
    0 vendaliquidanfce,
    cast(nfce.dataemissao as date) data,
    cast(nfce.horasaidaentrada as time) horario,
    nfce.codoperador codfuncionario,
    nfce.centrocusto centrocusto,
    0 as valorcondicao,
    CASE WHEN FORM.tipolancamentofinanceiro = '' THEN FORM.valorpago ELSE 0 END as valorcondicaonfce

    from tvendanfce nfce
    inner join tformapagamentonfce form
    on nfce.controle = form.codnfce

    where protocolocancelamento is null
    and nfce.inutilizada is null
    and (nfce.statusenvio like '%Autorizado o uso da NF-e%'
    or nfce.statusenvio like '%Emitida em contingência%')
    and nfce.sat <> 'SIM'

    union all

    select
    0 vendabruta,
    0 vendabrutanfce,
    0 canceladas,
    0 canceladasnfce,
    0 as descontos,
    0 descontosnfce,
    0 acrescimos,
    0 acrescimosnfce,
    0 as recebimentos,
    0 as taxaservico,
    0 as taxaserviconfce,
    0 vendaliquida,
    0 vendaliquidanfce,
    cast(nm.dataehoracadastro as date) data,
    cast(nm.dataehoracadastro as time) horario,
    nm. codfuncionario,
    nm.centrocusto centrocusto,
    CASE WHEN FORMNM.tipolancamentofinanceiro = '' THEN FORMNM.valorpago ELSE 0 END as valorcondicao,
    0 as valorcondicaonfce

    from tnotaconsumidor nm
    inner join tformapagamentonotamanual formnm
    on nm.controle = formnm.codnotamanual

    where nm.cancelado <> 'SIM'
    and nm.datafaturada is not null

    )a

    where data between '11.05.2025' and '11.05.2025' and ( (vendabruta = 0 and canceladas = 0) or (vendabruta <> 0 or canceladas <> 0))

    and centrocusto = 'JENNIFER'


    [13/05/2025 12:40:46.69 - 00:00:00]: NFCe - 2º parte do fechamento por período: select
    sum(sangria) sangria,
    sum(suprimento) suprimento,
    sum(transferencia) transferencia,
    sum(totalcaixa) totalcaixa

    from(

    select
    (valorsaida) as sangria,
    0 suprimento,
    0 transferencia,
    0 totalcaixa,
    cast(datahoracadastro as date) data,
    Cast(datahoracadastro as time) horario,
    tca.codfuncionario codfuncionario,
    tca.centrocusto centrocusto
    from
    tcaixa tca
    where
    origem = 'SANGRIA NOTA MANUAL' or (origem = 'SANGRIA NFCE')

    union all

    select
    0 sangria,
    (valorentrada) as suprimento,
    0 transferencia,
    0 totalcaixa,
    cast(datahoracadastro as date) data,
    Cast(datahoracadastro as time) horario,
    tca.codfuncionario codfuncionario,
    tca.centrocusto centrocusto
    from
    tcaixa tca
    where
    origem = 'SUPRIMENTO NOTA MANUAL' or (origem = 'SUPRIMENTO NFCE')

    union all

    select
    0 sangria,
    0 suprimento,
    (VALORSAIDA) as transferencia,
    0 totalcaixa,
    cast(datahoracadastro as date) data,
    Cast(datahoracadastro as time) horario,
    codfuncionario codfuncionario,
    centrocusto centrocusto
    from
    tcaixa tca
    where
    origem = 'TRANSFERÊNCIA NOTA MANUAL' or (origem = 'TRANSFERÊNCIA NFCE')

    union all

    select
    0 sangria,
    0 suprimento,
    0 transferencia,
    (tca.valorentrada - tca.valorsaida) totalcaixa,
    cast(datahoracadastro as date) data,
    Cast(datahoracadastro as time) horario,
    tca.codfuncionario codfuncionario,
    tca.centrocusto centrocusto
    from
    tcaixa tca
    left join
    tnotaconsumidor nm
    on
    tca.codmodulo = nm.controle
    where
    (((tca.origem = 'NOTA CONSUMIDOR') or (tca.origem = 'SANGRIA NOTA MANUAL') or (tca.origem = 'SUPRIMENTO NOTA MANUAL')) or (tca.codreceber is not null))
    or (tca.origem = 'VENDA NFCE' or (tca.origem = 'SANGRIA NFCE') or (TCA.ORIGEM = 'SUPRIMENTO NFCE'))
    and tca.controle is not null

    )a

    where data between '11.05.2025' and '11.05.2025'

    and centrocusto = 'JENNIFER'
    [13/05/2025 12:40:46.70 - 00:00:00]: NFCe - 3º parte do fechamento por período: select
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
            and nfce.sat <> 'SIM' ))

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
    [13/05/2025 12:40:46.75 - 00:00:00.0427898]: NFCe - 4º parte do fechamento por período: select
    tca.datahoracadastro,
    tca.valorentrada,
    tca.descricaolancamento                                                            
    from
    (
    select
    cast(tca.datahoracadastro as date) as data,
    cast(tca.datahoracadastro as time) as horario,
    tca.datahoracadastro,
    tca.valorentrada,
    tca.descricaolancamento,
    tca.codfuncionario codfuncionario,
    tca.centrocusto centrocusto
    from
    tcaixa tca

    where tca.origem = 'SUPRIMENTO NOTA MANUAL'                                
    or tca.origem = 'SUPRIMENTO NFCE'
    ) as tca
                            
    where data between '11.05.2025' and '11.05.2025'

    and centrocusto = 'JENNIFER'
    [13/05/2025 12:40:46.75 - 00:00:00]: NFCe - 5º parte do fechamento por período: select
                                tca.datahoracadastro,
                                tca.valorsaida,
                                tca.descricaolancamento
                            from
                            (
                                select
                                    cast(tca.datahoracadastro as date) as data,
                                    cast(tca.datahoracadastro as time) as horario,
                                    tca.datahoracadastro,
                                    tca.valorsaida,
                                    tca.descricaolancamento,
                                    tca.codfuncionario codfuncionario,
                                    tca.centrocusto centrocusto
                                from
                                    tcaixa tca
                                    
                                    where tca.origem = 'SANGRIA NOTA MANUAL'
                                    or (tca.origem = 'SANGRIA NFCE')
                            ) as tca
                            
                            where data between '11.05.2025' and '11.05.2025'
                            
                            and centrocusto = 'JENNIFER'
    [13/05/2025 12:40:46.76 - 00:00:00]: NFCe - 6º parte do fechamento por período: select
                                    dataehoracancelamento,
                                    valortotalnfce,
                                    valorproduto,
                                    chavenfce,
                                    justificativacancelamento,
                                    protocolocancelamento

                                    from(

                                        select
                                            dataehoracancelamento,
                                            valortotalnfce,
                                            valorproduto,
                                            chavenfce,
                                            justificativacancelamento,
                                            protocolocancelamento,
                                            nfce.dataemissao as data,
                                            nfce.horasaidaentrada as horario,
                                            nfce.codoperador codfuncionario,
                                            nfce.centrocusto centrocusto

                                        from tvendanfce nfce

                                        where
                                            protocolocancelamento is not null
                                            

                                            )a

                                    where data between '11.05.2025' and '11.05.2025'
                                    
                                    and centrocusto = 'JENNIFER'
    [13/05/2025 12:40:46.77 - 00:00:00.0010009]: NFCe - 7º parte do fechamento por período: select
    centrocusto,
    sum(valorentrada) total

    from(

    select
    tca.centrocusto,
    sum(tca.valorentrada - tca.valorsaida) valorentrada,
    cast(tca.datahoracadastro as date) data,
    cast(tca.datahoracadastro as time) horario,
    tca.codfuncionario codfuncionario
    from
    tcaixa tca
    left join tnotaconsumidor nm
    on
    tca.codmodulo = nm.controle
    left join tvendanfce nfce
    on tca.codnfce = nfce.controle

    where
    (((tca.origem = 'NOTA CONSUMIDOR') or (tca.origem = 'SANGRIA NOTA MANUAL') or (tca.origem = 'SUPRIMENTO NOTA MANUAL'))) or (tca.origem = 'VENDA NFCE' or (tca.origem = 'SANGRIA NFCE') or (TCA.ORIGEM = 'SUPRIMENTO NFCE'))                            

    group by
    tca.centrocusto,
    data,
    horario,
    codfuncionario

    )a

    where data between '11.05.2025' and '11.05.2025'

    and centrocusto = 'JENNIFER'
                                
    group by centrocustO
    [13/05/2025 12:40:46.77 - 00:00:00]: NFCe - 8º parte do fechamento por período: select
    sum(vendasCanceladas + vendasCanceladasnfce) vendasCanceladas,
    sum(itensCancelados + itensCanceladosnfce) itensCancelados,
    sum(emitidas + emitidasnfce) emitidas,
    sum(inutilizadas) inutilizadas

    from(

    select
    0 vendasCanceladas,
    0 vendasCanceladasnfce,
    count(itnm.controle) itensCancelados,
    0 itensCanceladosnfce,
    0 emitidas,
    0 emitidasnfce,
    cast(nm.dataehoracadastro as date) data,
    cast(nm.dataehoracadastro as time) horario,
    nm.codfuncionario codfuncionario,
    nm.centrocusto centrocusto,
    0 inutilizadas

    from titennotaconsumidor itnm
    inner join tnotaconsumidor nm
    on itnm.codnotaconsumidor = nm.controle

    where itnm.cancelado = 'SIM'


    group by
    data,horario,codfuncionario, centrocusto, itensCanceladosnfce, vendasCanceladasnfce, emitidasnfce

    union all

    select
    count(nm.controle) vendasCanceladas,
    0 vendasCanceladasnfce,
    0 itensCancelados,
    0 itensCanceladosnfce,
    0 emitidas,
    0 emitidasnfce,
    cast(nm.dataehoracadastro as date) data,
    cast(nm.dataehoracadastro as time) horario,
    nm.codfuncionario codfuncionario,
    nm.centrocusto centrocusto,
    0 inutilizadas

    from tnotaconsumidor nm                        

    where nm.cancelado = 'SIM'
    and nm.faturada = 'SIM'


    group by
    data,horario,codfuncionario, centrocusto, itensCanceladosnfce, vendasCanceladasnfce, emitidasnfce

    union all

    select
    0 vendasCanceladas,
    0 vendasCanceladasnfce,
    0 itensCancelados,
    0 itensCanceladosnfce,
    count(nm.controle) emitidas,
    0 emitidasnfce,
    cast(nm.dataehoracadastro as date) data,
    cast(nm.dataehoracadastro as time) horario,
    nm.codfuncionario codfuncionario,
    nm.centrocusto centrocusto,
    0 inutilizadas
    from                                                        
    tnotaconsumidor nm

    where
    nm.faturada = 'SIM'
    and nm.datafaturada is not null
    and nm.cancelado <> 'SIM'


    group by
    data,horario,codfuncionario, centrocusto, itensCanceladosnfce, vendasCanceladasnfce, emitidasnfce

    union all

    select
    0 vendasCanceladas,
    0 vendasCanceladasnfce,
    0 itensCancelados,
    count(itnfce.controle) itensCanceladosnfce,
    0 emitidas,
    0 emitidasnfce,
    cast(nfce.dataemissao as date) data,
    cast(nfce.horasaidaentrada as time) horario,
    nfce.codoperador codfuncionario,
    nfce.centrocusto centrocusto,
    0 inutilizadas

    from tvendanfce nfce
    inner join titemvendanfce itnfce
    on nfce.controle = itnfce.codnfce

    where nfce.inutilizada is null
    and ITNFCE.cancelado = 'SIM'
    and ITNFCE.enviada = 'SIM'


    group by
    data,horario,codfuncionario, centrocusto, itensCancelados, vendasCanceladas, vendasCanceladasnfce, emitidasnfce

    union all

    select
    0 vendasCanceladas,
    count(nfce.controle) vendasCanceladasnfce,
    0 itensCancelados,
    0 itensCanceladosnfce,
    0 emitidas,
    0 emitidasnfce,
    cast(nfce.dataemissao as date) data,
    cast(nfce.horasaidaentrada as time) horario,
    nfce.codoperador codfuncionario,
    nfce.centrocusto centrocusto,
    0 inutilizadas

    from tvendanfce nfce                        

    where nfce.inutilizada is null
    and nfce.protocolocancelamento is not null
    and sat = 'NÃO'


    group by
    data,horario,codfuncionario, centrocusto, itensCancelados, vendasCanceladas, emitidasnfce

    union all

    select
    0 vendasCanceladas,
    0 vendasCanceladasnfce,
    0 itensCancelados,
    0 itensCanceladosnfce,
    0 emitidas,
    count(nfce.controle) emitidasnfce,
    cast(nfce.dataemissao as date) data,
    cast(nfce.horasaidaentrada as time) horario,
    nfce.codoperador codfuncionario,
    nfce.centrocusto centrocusto,
    0 inutilizadas

    from tvendanfce nfce                        

    where nfce.protocolocancelamento is null                                                            
    and nfce.inutilizada is null
    and (nfce.statusenvio like '%Autorizado o uso da NF-e%'
    or nfce.statusenvio like '%Emitida em contingência%')
    and nfce.sat <> 'SIM'


    group by
    data,horario,codfuncionario, centrocusto, itensCancelados, vendasCanceladas, vendasCanceladasnfce

    union all

    select
    0 vendasCanceladas,
    0 vendasCanceladasnfce,
    0 itensCancelados,
    0 itensCanceladosnfce,
    0 emitidas,
    0 emitidasnfce,
    cast(nfce.dataemissao as date) data,
    cast(nfce.horasaidaentrada as time) horario,
    nfce.codoperador codfuncionario,
    nfce.centrocusto centrocusto,
    count(nfce.controle) inutilizadas

    from tvendanfce nfce                        

    where nfce.inutilizada = 'SIM'
    and nfce.protocolocancelamento is null
    and nfce.sat = 'NÃO' 


    group by
    data,horario,codfuncionario, centrocusto, itensCancelados, vendasCanceladas, vendasCanceladasnfce

    )a

    where data between '11.05.2025' and '11.05.2025'

    and centrocusto = 'JENNIFER'
    [13/05/2025 12:40:46.78 - 00:00:00]: NFCe - 10º parte do fechamento por período: select
    centrocusto,
    sum(valorentrada) valorentrada,
    sum(valorsaida) valorsaida

    from(

    select
    tca.centrocusto CENTROCUSTO,
    (cast(coalesce(tca.valorentrada, 0) as float)) VALORENTRADA,
    (cast(coalesce(tca.valorsaida, 0) as float)) VALORSAIDA,
    cast(tca.datahoracadastro as date) data,
    cast(tca.datahoracadastro as time) horario,
    tca.codfuncionario codfuncionario
    from tcaixa tca                        

    WHERE
    (((tca.origem = 'NOTA CONSUMIDOR') or (tca.origem = 'SANGRIA NOTA MANUAL') or (tca.origem = 'SUPRIMENTO NOTA MANUAL'))) or (tca.origem = 'VENDA NFCE' or (tca.origem = 'SANGRIA NFCE') or (TCA.ORIGEM = 'SUPRIMENTO NFCE'))
    and tca.controle is not null

    )a

    where data between '11.05.2025' and '11.05.2025'

    and centrocusto = 'JENNIFER'

    group by centrocusto
    [13/05/2025 12:40:46.79 - 00:00:00]: NFCe - 11º parte do fechamento por período: select
    codreceber,
    documento,
    entrada,
    especie

    from(

    select
    tca.codreceber codreceber,
    tca.documento documento,
    tca.valorentrada entrada,
    tca.especie especie,
    cast(tca.datahoracadastro as date) data,
    cast(tca.datahoracadastro as time) horario,
    tca.codfuncionario codfuncionario,
    tca.centrocusto
    from
    tcaixa tca
    where
    tca.codreceber is not null                                                  
    and (tca.origem not like '%SANGRIA%') AND (tca.origem not like '%SUPRIMENTO%')

    )a

    where data between '11.05.2025' and '11.05.2025'

    and centrocusto = 'JENNIFER'
    [13/05/2025 12:40:46.79 - 00:00:00]: NFCe - 12º parte do fechamento por período: select
    especie,
    sum(entrada) total

    from(

    select
    tca.codreceber codreceber,
    tca.documento documento,
    tca.valorentrada entrada,
    tca.especie especie,
    cast(tca.datahoracadastro as date) data,
    cast(tca.datahoracadastro as time) horario,
    tca.codfuncionario codfuncionario,
    tca.centrocusto
    from
    tcaixa tca
    where
    tca.codreceber is not null                        
    and (tca.origem not like '%SANGRIA%') AND (tca.origem not like '%SUPRIMENTO%')

    )a

    where data between '11.05.2025' and '11.05.2025'

    and centrocusto = 'JENNIFER'

    group by especie
    [13/05/2025 12:40:46.80 - 00:00:00]: NFCe - 13º parte do fechamento por período: select
    codproduto,
    produto,
    sum(qtdevendida) qtdevendida,
    sum(totalliquido) totalliquido

    from(

    select
    it.codproduto codproduto,
    it.produto produto,
    (it.qtde) qtdevendida,
    (it.totaliquido) totalliquido,
    nm.dataemissao data,
    nm.horafaturada horario,
    nm.codfuncionario codfuncionario,
    nm.centrocusto centrocusto

    from titennotaconsumidor it
    inner join tnotaconsumidor nm
    on nm.controle = it.codnotaconsumidor

    where
    nm.cancelado <> 'SIM'
    and faturada = 'SIM'
    and nm.datafaturada is not null 

    union all

    select
    itnfce.codproduto codproduto,
    itnfce.produto produto,
    (itnfce.qtde) qtdevendida,
    (itnfce.valortotal) totalliquido,
    nfce.dataemissao data,
    cast(nfce.horasaidaentrada as time) horario,
    nfce.codoperador codfuncionario,
    nfce.centrocusto centrocusto

    from tvendanfce nfce
    inner join titemvendanfce itnfce
    on nfce.controle = itnfce.codnfce

    where
    nfce.protocolocancelamento is null                                                            
    and nfce.inutilizada is null
    and (nfce.statusenvio like '%Autorizado o uso da NF-e%'
    or nfce.statusenvio like '%Emitida em contingência%')
    and nfce.sat <> 'SIM'                            

    )a

    where data between '11.05.2025' and '11.05.2025'

    and centrocusto = 'JENNIFER'

    group by codproduto, produto
