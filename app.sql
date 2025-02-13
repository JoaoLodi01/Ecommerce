select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '1'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
     41 ms

2025-02-13T17:23:25.0790 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492782, CONCURRENCY | WAIT | READ_WRITE)

Statement 7174:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '1'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:25.2810 (6900:0000000001D8A718) TRACE_INIT
    SESSION_1 IBE_13/02/2025 17:23:24
    

2025-02-13T17:23:25.2810 (6900:0000000001D8A718) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - INVENTARIO.FDB (ATT_289889, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:14808
        (TRA_15419722, CONCURRENCY | NOWAIT | READ_WRITE)

2025-02-13T17:23:25.2910 (6900:0000000001D8A718) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - INVENTARIO.FDB (ATT_289889, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:14808
        (TRA_15419722, CONCURRENCY | NOWAIT | READ_WRITE)

Statement 113302:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/13 16:28:25.0000' and '2025/02/13 17:23:25.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))
      0 ms

2025-02-13T17:23:25.2910 (6900:0000000001D8A718) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - INVENTARIO.FDB (ATT_289889, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:14808
        (TRA_15419722, CONCURRENCY | NOWAIT | READ_WRITE)

Statement 113302:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/13 16:28:25.0000' and '2025/02/13 17:23:25.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-13T17:23:25.2910 (6900:0000000001D8A718) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - INVENTARIO.FDB (ATT_289889, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:14808

Statement 113302:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/13 16:28:25.0000' and '2025/02/13 17:23:25.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-13T17:23:25.2910 (6900:0000000001D8A718) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - INVENTARIO.FDB (ATT_289889, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:14808

Statement 113302:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/13 16:28:25.0000' and '2025/02/13 17:23:25.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-13T17:23:25.2910 (6900:0000000001D8A718) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - INVENTARIO.FDB (ATT_289889, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:14808
        (TRA_15419722, CONCURRENCY | NOWAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-13T17:23:25.6570 (6900:0000000001D8D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7174:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '1'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:25.6620 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492782, CONCURRENCY | WAIT | READ_WRITE)

Statement 7176:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      4 ms

2025-02-13T17:23:25.6620 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492782, CONCURRENCY | WAIT | READ_WRITE)

Statement 7176:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-13T17:23:25.6640 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7172:
-------------------------------------------------------------------------------
Select * from ttemp where campo4 = 'INVENTARIO'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TTEMP NATURAL)

2025-02-13T17:23:25.6650 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7174:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '1'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:25.8550 (6900:0000000001D8D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7170:
-------------------------------------------------------------------------------
Select * from testoque where codaplicacaoproduto <> '09' and codaplicacaoproduto <> '07' and cast(datahoracadastro as date) <= '12/31/2024' order by Controle
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TESTOQUE ORDER PK_TESTOQUE)

2025-02-13T17:23:25.8560 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7170:
-------------------------------------------------------------------------------
Select * from testoque where codaplicacaoproduto <> '09' and codaplicacaoproduto <> '07' and cast(datahoracadastro as date) <= '12/31/2024' order by Controle
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TESTOQUE ORDER PK_TESTOQUE)

2025-02-13T17:23:25.8560 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7176:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-13T17:23:25.8560 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492782, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-13T17:23:25.8580 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492785, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:25.8580 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492785, CONCURRENCY | WAIT | READ_WRITE)

Statement 7177:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-13T17:23:25.8580 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492785, CONCURRENCY | WAIT | READ_WRITE)

Statement 7177:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "117938"
param1 = integer, "1"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "96034010"
param4 = varchar(500), "ROLO LA 23CM  2773 S/R 19MM. ATLAS"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896380193165"
param7 = bigint(*, -4), "83.0000"
param8 = bigint(*, -4), "26.7180"
param9 = bigint(*, -4), "2217.5940"


2025-02-13T17:23:25.8580 (6900:0000000001D8D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492785, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-13T17:23:25.8590 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7177:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-13T17:23:25.8590 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492785, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-13T17:23:25.8690 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492786, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:25.8820 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492786, CONCURRENCY | WAIT | READ_WRITE)

Statement 7179:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '3'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      4 ms

2025-02-13T17:23:25.8820 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492786, CONCURRENCY | WAIT | READ_WRITE)

Statement 7179:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde f
rom titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '3'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.0970 (6900:0000000001D8D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7179:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '3'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.0970 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7179:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '3'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.0980 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492786, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.0990 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492787, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.1030 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492787, CONCURRENCY | WAIT | READ_WRITE)

Statement 7180:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '4'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      2 ms

2025-02-13T17:23:26.1040 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492787, CONCURRENCY | WAIT | READ_WRITE)

Statement 7180:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '4'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.1710 (6900:0000000001D8D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7180:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '4'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.1710 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7180:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '4'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.1710 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492787, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.1720 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492788, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.1720 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492788, CONCURRENCY | WAIT | READ_WRITE)

Statement 7181:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-13T17:23:26.1720 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492788, CONCURRENCY | WAIT | READ_WRITE)

Statement 7181:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-13T17:23:26.1730 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7181:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-13T17:23:26.1730 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492788, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.1730 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492789, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.1730 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492789, CONCURRENCY | WAIT | READ_WRITE)

Statement 7182:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-13T17:23:26.1740 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492789, CONCURRENCY | WAIT | READ_WRITE)

Statement 7182:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "117939"
param1 = integer, "4"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "39169090"
param4 = varchar(500), "MOLDURA  H  40MM X 50 MM THERMO-FLEX"
param5 = varchar(500), "MT"
param6 = varchar(500), "5412938509725"
param7 = bigint(*, -4), "1.0000"
param8 = bigint(*, -4), "8.4000"
param9 = bigint(*, -4), "8.4000"


2025-02-13T17:23:26.1740 (6900:0000000001D8D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492789, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-13T17:23:26.1740 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7182:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-13T17:23:26.1740 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492789, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.1760 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492790, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.1780 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR
\Master\GR.exe:16704
        (TRA_96492790, CONCURRENCY | WAIT | READ_WRITE)

Statement 7183:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '10'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-13T17:23:26.1780 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492790, CONCURRENCY | WAIT | READ_WRITE)

Statement 7183:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '10'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.2300 (6900:0000000001D8D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7183:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '10'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.2300 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7183:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '10'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.2300 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492790, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.2330 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492791, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.2360 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492791, CONCURRENCY | WAIT | READ_WRITE)

Statement 7184:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '11'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      2 ms

2025-02-13T17:23:26.2360 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492791, CONCURRENCY | WAIT | READ_WRITE)

Statement 7184:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '11'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.3350 (6900:0000000001D8D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7184:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '11'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.3350 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7184:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque =
 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '11'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.3350 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492791, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.3350 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492792, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.3360 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492792, CONCURRENCY | WAIT | READ_WRITE)

Statement 7185:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-13T17:23:26.3360 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492792, CONCURRENCY | WAIT | READ_WRITE)

Statement 7185:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-13T17:23:26.3360 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7185:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-13T17:23:26.3360 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492792, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.3370 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492793, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.3370 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492793, CONCURRENCY | WAIT | READ_WRITE)

Statement 7186:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-13T17:23:26.3370 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492793, CONCURRENCY | WAIT | READ_WRITE)

Statement 7186:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "117940"
param1 = integer, "11"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "73269090"
param4 = varchar(500), "GARFO 23CM 330/23SR SEM ROSCA  ATLAS"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896380192045"
param7 = bigint(*, -4), "12.0000"
param8 = bigint(*, -4), "3.7107"
param9 = bigint(*, -4), "44.5284"


2025-02-13T17:23:26.3370 (6900:0000000001D8D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492793, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-13T17:23:26.3380 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7186:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-13T17:23:26.3380 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492793, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.3400 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492794, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.3420 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492794, CONCURRENCY | WAIT | READ_WRITE)

Statement 7187:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '12'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-13T17:23:26.3420 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492794, CONCURRENCY | WAIT | READ_WRITE)

Statement 7187:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '12'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.4390 (6900:0000000001D8D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7187:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '12'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.4390 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7187:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '12'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.4390 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492794, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.4410 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492795, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.4430 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492795, CONCURRENCY | WAIT | READ_WRITE)

Statement 7188:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '13'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-13T17:23:26.4430 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492795, CONCURRENCY | WAIT | READ_WRITE)

Statement 7188:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRO
DUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '13'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.7120 (6900:0000000001D8D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7188:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '13'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.7120 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7188:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '13'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.7120 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492795, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.7130 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492796, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.7130 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492796, CONCURRENCY | WAIT | READ_WRITE)

Statement 7189:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-13T17:23:26.7130 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492796, CONCURRENCY | WAIT | READ_WRITE)

Statement 7189:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-13T17:23:26.7130 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7189:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-13T17:23:26.7130 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492796, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.7140 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492797, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.7140 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492797, CONCURRENCY | WAIT | READ_WRITE)

Statement 7190:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-13T17:23:26.7140 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492797, CONCURRENCY | WAIT | READ_WRITE)

Statement 7190:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "117941"
param1 = integer, "13"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "32081010"
param4 = varchar(500), "PRETO SEMI BRILHO 3511 KISALUX 3000 LITRO"
param5 = varchar(500), "LT"
param6 = varchar(500), "7891466229448"
param7 = bigint(*, -4), "11.0000"
param8 = bigint(*, -4), "16.6970"
param9 = bigint(*, -4), "183.6670"


2025-02-13T17:23:26.7140 (6900:0000000001D8D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492797, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-13T17:23:26.7140 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7190:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-13T17:23:26.7150 (6900:0000000001D8D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492797, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-13T17:23:26.7170 (6900:0000000001D8D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492798, CONCURRENCY | WAIT | READ_WRITE)

2025-02-13T17:23:26.7210 (6900:0000000001D8D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492798, CONCURRENCY | WAIT | READ_WRITE)

Statement 7191:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '15'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      3 ms

2025-02-13T17:23:26.7210 (6900:0000000001D8D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704
        (TRA_96492798, CONCURRENCY | WAIT | READ_WRITE)

Statement 7191:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '15'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.7880 (6900:0000000001D8D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7191:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from titemvendanfce infc inner join tvendanfce nfc on nfc.controle = infc.codnfce where nfc.dataemissao > '12/31/2024'
        and infc.codproduto = est.controle and infc.cancelado <> 'SIM' and infc.CODAPLICACAOPRODUTO <> '09' and infc.enviada = 'SIM' and infc.ambiente = '1'
        and infc.ambiente = '1'),0) +
    coalesce((select sum(qtde) as qtde from TITENNOTACONSUMIDOR inc inner join TNOTACONSUMIDOR nc on nc.controle = inc.CODNOTACONSUMIDOR where nc.dataemissao > '12/31/2024'
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.confirmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '15'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (INF INDEX (ENVIADA_TITENSVENDANFE), NF INDEX (PK_TVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-13T17:23:26.7880 (6900:0000000001D8D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - IMPRESSAO.FDB (ATT_6152594, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:16704

Statement 7191:
-------------------------------------------------------------------------------
select
    cast(coalesce(est.qtde,0) as decimal(15,4)) -
    ((coalesce((select sum(qtde) as qtde from titemcompra ic inner join tcompra cmp on cmp.controle = ic.codcompra where cmp.datarecebimento > '12/31/2024'
        and ic.codproduto = est.controle and ic.confirmado= 'SIM' AND cmp.TIPOOPERACAO = '0' and cmp.movimentaestoque = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemordemproducao io inner join tordemproducao op on op.controle = io.codproducao where op.datafinal > '12/31/2024'
        and io.codproduto = est.controle and io.situacao = 'FINALIZADA'),0) +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '0' and enviada  = 'SIM'  and inf.movimentaestoque = 'SIM'
        and CODAPLICACAOPRODUTO <> '09' and ambiente = '1'),0))) +
    (coalesce((select sum(qtde) as qtde from titemvendaecf iec inner join tvendaecf ecf on ecf.controle = iec.codvendaecf where iec.dataecf > '12/31/2024'
        and iec.codproduto = est.controle  and iec.cancelado = 'NÃO'),0)  +
    coalesce((select sum(qtdecomercial) as qtde from titensvendanfe inf inner join tvendanfe nf on nf.controle = inf.codnfe where nf.dataemissao > '12/31/2024'
        and inf.codproduto = est.controle and inf.cancelado <> 'SIM' AND nf.TIPOOPERACAO = '1' and enviada  = 'SIM' and inf.movimentaestoque = 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
        and inf.movimentaestoque = 'SIM' and 

IBE> Trace session IBE_13/02/2025 17:23:24 terminated.
