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
    qtde_apuracao
from
    testoque est
where 
    est.controle = '1'

-- CUSTO E OPÇÃO NÃO --

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

-- CUSTO MÉDIO E OPÇÃO NÃO -- 





















^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
     12 ms

2025-02-12T13:46:36.1150 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133427, CONCURRENCY | WAIT | READ_WRITE)

Statement 8188:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.1180 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8188:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.1180 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133427, CONCURRENCY | WAIT | READ_WRITE)

Statement 8189:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.1180 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133427, CONCURRENCY | WAIT | READ_WRITE)

Statement 8189:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.1180 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8185:
-------------------------------------------------------------------------------
Select * from ttemp where campo4 = 'INVENTARIO'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TTEMP NATURAL)

2025-02-12T13:46:36.1180 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8188:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.2570 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8183:
-------------------------------------------------------------------------------
Select * from testoque where codaplicacaoproduto <> '09' and codaplicacaoproduto <> '07' and cast(datahoracadastro as date) <= '12/31/2024' order by Controle
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TESTOQUE ORDER PK_TESTOQUE)

2025-02-12T13:46:36.2570 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8183:
-------------------------------------------------------------------------------
Select * from testoque where codaplicacaoproduto <> '09' and codaplicacaoproduto <> '07' and cast(datahoracadastro as date) <= '12/31/2024' order by Controle
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TESTOQUE ORDER PK_TESTOQUE)

2025-02-12T13:46:36.2570 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8189:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.2570 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133427, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.2580 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133431, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.2580 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133431, CONCURRENCY | WAIT | READ_WRITE)

Statement 8190:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.2580 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133431, CONCURRENCY | WAIT | READ_WRITE)

Statement 8190:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54089"
param1 = integer, "1"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "85234110"
param4 = varchar(500), "CHOCOLATE BOMBONS NEUGEBAWER"
param5 = varchar(500), "UN"
param6 = varchar(500), "7891330012015"
param7 = bigint(*, -4), "8.0000"
param8 = bigint(*, -4), "2.7903"
param9 = bigint(*, -4), "22.3224"


2025-02-12T13:46:36.2580 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133431, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.2580 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8190:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.2590 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133431, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.2600 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133432, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.2630 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133432, CONCURRENCY | WAIT | READ_WRITE)

Statement 8191:
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
    est.controle = '2'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.2630 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133432, CONCURRENCY | WAIT | READ_WRITE)

Statement 8191:
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
    est.controle = '2'
^^^^^^^^^^^^^^^^^^^^^
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.2650 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8191:
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
    est.controle = '2'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.2650 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8191:
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
    est.controle = '2'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.2650 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133432, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.2660 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133433, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.2660 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133433, CONCURRENCY | WAIT | READ_WRITE)

Statement 8192:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.2660 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133433, CONCURRENCY | WAIT | READ_WRITE)

Statement 8192:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.2660 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8192:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.2660 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133433, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.2670 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133434, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.2670 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133434, CONCURRENCY | WAIT | READ_WRITE)

Statement 8193:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.2670 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133434, CONCURRENCY | WAIT | READ_WRITE)

Statement 8193:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54090"
param1 = integer, "2"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "04012010"
param4 = varchar(500), "LEITE LONGA VIDA PIA INTEGRAL SWIFT 1LT"
param5 = varchar(500), "LT"
param6 = varchar(500), "7896348841480"
param7 = bigint(*, -4), "8.7000"
param8 = bigint(*, -4), "3.4020"
param9 = bigint(*, -4), "29.5974"


2025-02-12T13:46:36.2670 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133434, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.2670 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8193:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.2680 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133434, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.2800 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133435, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.2820 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133435, CONCURRENCY | WAIT | READ_WRITE)

Statement 8194:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.2820 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133435, CONCURRENCY | WAIT | READ_WRITE)

Statement 8194:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.2830 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8194:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.2830 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8194:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA
_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.2830 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133435, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.2830 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133436, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.2830 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133436, CONCURRENCY | WAIT | READ_WRITE)

Statement 8195:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.2830 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133436, CONCURRENCY | WAIT | READ_WRITE)

Statement 8195:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.2840 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8195:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.2840 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133436, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.2840 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133437, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.2840 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133437, CONCURRENCY | WAIT | READ_WRITE)

Statement 8196:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.2850 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133437, CONCURRENCY | WAIT | READ_WRITE)

Statement 8196:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54091"
param1 = integer, "3"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "04012010"
param4 = varchar(500), "LEITE LONGA VIDA PIA SEMI DESNAT. SWIFT 1LT"
param5 = varchar(500), "LT"
param6 = varchar(500), "7896348841497"
param7 = bigint(*, -4), "29.3100"
param8 = bigint(*, -4), "4.6500"
param9 = bigint(*, -4), "136.2915"


2025-02-12T13:46:36.2850 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133437, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.2850 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8196:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.2850 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133437, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.2950 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133438, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.2970 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133438, CONCURRENCY | WAIT | READ_WRITE)

Statement 8197:
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
    est.controle = '5'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.2970 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133438, CONCURRENCY | WAIT | READ_WRITE)

Statement 8197:
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
    est.controle = '5'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.2980 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8197:
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
    est.controle = '5'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.2980 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8197:
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
    est.controle = '5'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.2980 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133438, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.2980 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133439, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.2980 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133439, CONCURRENCY | WAIT | READ_WRITE)

Statement 8198:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.2990 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133439, CONCURRENCY | WAIT | READ_WRITE)

Statement 8198:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.2990 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8198:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.2990 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133439, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.2990 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133440, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3000 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133440, CONCURRENCY | WAIT | READ_WRITE)

Statement 8199:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.3000 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133440, CONCURRENCY | WAIT | READ_WRITE)

Statement 8199:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54092"
param1 = integer, "5"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "85234110"
param4 = varchar(500), "PEPINO EM CONSERVA SPORTE"
param5 = varchar(500), "UN"
param6 = varchar(500), "7898933680887"
param7 = bigint(*, -4), "15.0000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.3000 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133440, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.3000 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8199:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.3000 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133440, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3020 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133441, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3040 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133441, CONCURRENCY | WAIT | READ_WRITE)

Statement 8200:
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
        coalesce((select sum(qtdea
lterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '6'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.3040 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133441, CONCURRENCY | WAIT | READ_WRITE)

Statement 8200:
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
    est.controle = '6'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3110 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8200:
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
    est.controle = '6'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3120 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8200:
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
    est.controle = '6'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3120 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133441, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3120 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133442, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3120 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133442, CONCURRENCY | WAIT | READ_WRITE)

Statement 8201:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.3120 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133442, CONCURRENCY | WAIT | READ_WRITE)

Statement 8201:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3120 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8201:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3130 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133442, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3130 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133443, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3130 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133443, CONCURRENCY | WAIT | READ_WRITE)

Statement 8202:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.3140 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133443, CONCURRENCY | WAIT | READ_WRITE)

Statement 8202:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54093"
param1 = integer, "6"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "16010000"
param4 = varchar(500), "ODERICH SALSICHA VIENA 180G C/24"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896041110012"
param7 = bigint(*, -4), "56.0000"
param8 = bigint(*, -4), "3.7582"
param9 = bigint(*, -4), "210.4592"


2025-02-12T13:46:36.3140 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133443, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.3140 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8202:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.3140 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133443, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3160 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133444, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3170 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133444, CONCURRENCY | WAIT | READ_WRITE)

Statement 8203:
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
    est.controle = '7'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.3180 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133444, CONCURRENCY | WAIT | READ_WRITE)

Statement 8203:
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
    est.controle = '7'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3190 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8203:
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
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codprodu
to = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '7'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3190 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8203:
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
    est.controle = '7'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3190 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133444, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3200 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133445, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3200 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133445, CONCURRENCY | WAIT | READ_WRITE)

Statement 8204:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.3200 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133445, CONCURRENCY | WAIT | READ_WRITE)

Statement 8204:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3200 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8204:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3200 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133445, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3210 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133446, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3210 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133446, CONCURRENCY | WAIT | READ_WRITE)

Statement 8205:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.3210 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133446, CONCURRENCY | WAIT | READ_WRITE)

Statement 8205:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54094"
param1 = integer, "7"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "85234110"
param4 = varchar(500), "ERVILHA ODERICH 200G"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896041154016"
param7 = bigint(*, -4), "156.0000"
param8 = bigint(*, -4), "3.0477"
param9 = bigint(*, -4), "475.4412"


2025-02-12T13:46:36.3210 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133446, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.3210 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8205:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.3220 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133446, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3290 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133447, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3310 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133447, CONCURRENCY | WAIT | READ_WRITE)

Statement 8206:
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
    est.controle = '8'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.3310 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133447, CONCURRENCY | WAIT | READ_WRITE)

Statement 8206:
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
    est.controle = '8'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3320 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8206:
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
    est.controle = '8'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3320 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8206:
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
    est.controle = '8'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3320 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133447, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3320 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133448, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3330 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133448, CONCURRENCY | WAIT | READ_WRITE)

Statement 8207:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.3330 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133448, CONCURRENCY | WAIT | READ_WRITE)

Statement 8207:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3330 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8207:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3330 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133448, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3340 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133449, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3340 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133449, CONCURRENCY | WAIT | READ_WRITE)

Statement 8208:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.3340 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133449, CONCURRENCY | WAIT | READ_WRITE)

Statement 8208:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO
7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54095"
param1 = integer, "8"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "85234110"
param4 = varchar(500), "MILHO VERDE JUREMA 225G NO VAPOR"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896387016726"
param7 = bigint(*, -4), "25.0000"
param8 = bigint(*, -4), "2.3500"
param9 = bigint(*, -4), "58.7500"


2025-02-12T13:46:36.3340 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133449, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.3350 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8208:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.3350 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133449, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 6 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3460 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133450, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3480 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133450, CONCURRENCY | WAIT | READ_WRITE)

Statement 8209:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.3480 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133450, CONCURRENCY | WAIT | READ_WRITE)

Statement 8209:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3490 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8209:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3490 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8209:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3490 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133450, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3490 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133451, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3490 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133451, CONCURRENCY | WAIT | READ_WRITE)

Statement 8210:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.3490 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133451, CONCURRENCY | WAIT | READ_WRITE)

Statement 8210:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3490 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8210:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3500 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133451, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3500 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133452, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3500 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133452, CONCURRENCY | WAIT | READ_WRITE)

Statement 8211:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.3500 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133452, CONCURRENCY | WAIT | READ_WRITE)

Statement 8211:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54096"
param1 = integer, "11"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "85234110"
param4 = varchar(500), "KETCHUP AUREA 390G"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896180782682"
param7 = bigint(*, -4), "20.0000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.3500 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133452, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.3510 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8211:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.3510 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133452, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3610 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133453, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3620 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133453, CONCURRENCY | WAIT | READ_WRITE)

Statement 8212:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.3630 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133453, CONCURRENCY | WAIT | READ_WRITE)

Statement 8212:
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
        and iopc.codproduto = est.controle and op.status = 'FINALIZAD
A'),0))
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3640 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8212:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3640 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8212:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3640 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133453, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3640 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133454, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3650 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133454, CONCURRENCY | WAIT | READ_WRITE)

Statement 8213:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.3650 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133454, CONCURRENCY | WAIT | READ_WRITE)

Statement 8213:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3650 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8213:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3650 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133454, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3660 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133455, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3660 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133455, CONCURRENCY | WAIT | READ_WRITE)

Statement 8214:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.3660 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133455, CONCURRENCY | WAIT | READ_WRITE)

Statement 8214:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54097"
param1 = integer, "12"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "21039011"
param4 = varchar(500), "MAIONESE HELLMANNS 200G"
param5 = varchar(500), "UN"
param6 = varchar(500), "7894000030470"
param7 = bigint(*, -4), "76.0000"
param8 = bigint(*, -4), "4.0455"
param9 = bigint(*, -4), "307.4580"


2025-02-12T13:46:36.3660 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133455, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.3660 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8214:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.3660 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133455, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3690 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133456, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3710 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133456, CONCURRENCY | WAIT | READ_WRITE)

Statement 8215:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.3710 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133456, CONCURRENCY | WAIT | READ_WRITE)

Statement 8215:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3720 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8215:
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
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3720 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8215:
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
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast
(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '13'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3720 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133456, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3790 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133457, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3800 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133457, CONCURRENCY | WAIT | READ_WRITE)

Statement 8216:
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
    est.controle = '14'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.3810 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133457, CONCURRENCY | WAIT | READ_WRITE)

Statement 8216:
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
    est.controle = '14'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3810 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8216:
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
    est.controle = '14'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3810 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8216:
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
    est.controle = '14'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3820 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133457, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3940 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133458, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3970 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133458, CONCURRENCY | WAIT | READ_WRITE)

Statement 8217:
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
    est.controle = '17'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.3970 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133458, CONCURRENCY | WAIT | READ_WRITE)

Statement 8217:
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
    est.controle = '17'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3970 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8217:
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
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.control
e and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '17'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3980 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8217:
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
    est.controle = '17'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.3980 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133458, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3980 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133459, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3980 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133459, CONCURRENCY | WAIT | READ_WRITE)

Statement 8218:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.3980 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133459, CONCURRENCY | WAIT | READ_WRITE)

Statement 8218:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3980 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8218:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.3980 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133459, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.3990 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133460, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.3990 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133460, CONCURRENCY | WAIT | READ_WRITE)

Statement 8219:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.3990 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133460, CONCURRENCY | WAIT | READ_WRITE)

Statement 8219:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54098"
param1 = integer, "17"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "20071000"
param4 = varchar(500), "DOCE PIA 400G BANANA"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896348811254"
param7 = bigint(*, -4), "9.0000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.3990 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133460, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.3990 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8219:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.4000 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133460, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4020 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133461, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4120 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133461, CONCURRENCY | WAIT | READ_WRITE)

Statement 8220:
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
    est.controle = '18'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      7 ms

2025-02-12T13:46:36.4120 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133461, CONCURRENCY | WAIT | READ_WRITE)

Statement 8220:
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
    est.controle = '18'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4130 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8220:
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
    est.controle = '18'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4130 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8220:
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
    est.controle = '18'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4130 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133461, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4130 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133462, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4140 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133462, CONCURRENCY | WAIT | READ_WRITE)

Statement 8221:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.4140 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133462, CONCURRENCY | WAIT | READ_WRITE)

Statement 8221:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4140 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8221:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4140 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133462, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4150 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133463, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4150 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133463, CONCURRENCY | WAIT | READ_WRITE)

Statement 8222:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.4150 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133463, CONCURRENCY | WAIT | READ_WRITE)

Statement 8222:
----------
---------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54099"
param1 = integer, "18"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "20071000"
param4 = varchar(500), "DOCE PIA 400G GOIABA"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896348811186"
param7 = bigint(*, -4), "5.6000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.4150 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133463, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.4150 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8222:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.4150 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133463, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4170 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133464, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4190 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133464, CONCURRENCY | WAIT | READ_WRITE)

Statement 8223:
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
    est.controle = '19'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.4190 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133464, CONCURRENCY | WAIT | READ_WRITE)

Statement 8223:
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
    est.controle = '19'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4200 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8223:
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
    est.controle = '19'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4200 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8223:
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
    est.controle = '19'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4200 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133464, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4200 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133465, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4200 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133465, CONCURRENCY | WAIT | READ_WRITE)

Statement 8224:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.4200 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133465, CONCURRENCY | WAIT | READ_WRITE)

Statement 8224:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4200 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8224:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4210 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133465, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4210 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133466, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4210 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133466, CONCURRENCY | WAIT | READ_WRITE)

Statement 8225:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.4210 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133466, CONCURRENCY | WAIT | READ_WRITE)

Statement 8225:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54100"
param1 = integer, "19"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "85234110"
param4 = varchar(500), "DOCE NECTAR 400G MAÇA"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896714800295"
param7 = bigint(*, -4), "8.0000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.4210 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133466, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.4220 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8225:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.4220 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133466, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4270 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133467, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4290 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133467, CONCURRENCY | WAIT | READ_WRITE)

Statement 8226:
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
    est.controle = '20'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.4290 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133467, CONCURRENCY | WAIT | READ_WRITE)

Statement 8226:
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
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = i
opc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '20'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4300 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8226:
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
    est.controle = '20'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4300 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8226:
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
    est.controle = '20'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4300 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133467, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4440 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133468, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4460 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133468, CONCURRENCY | WAIT | READ_WRITE)

Statement 8227:
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
    est.controle = '21'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.4460 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133468, CONCURRENCY | WAIT | READ_WRITE)

Statement 8227:
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
    est.controle = '21'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4470 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8227:
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
    est.controle = '21'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4470 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8227:
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
    est.controle = '21'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4470 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133468, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4470 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133469, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4480 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133469, CONCURRENCY | WAIT | READ_WRITE)

Statement 8228:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.4480 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133469, CONCURRENCY | WAIT | READ_WRITE)

Statement 8228:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4480 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8228:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4480 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133469, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4480 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133470, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4490 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133470, CONCURRENCY | WAIT | READ_WRITE)

Statement 8229:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.4490 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133470, CONCURRENCY
 | WAIT | READ_WRITE)

Statement 8229:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54101"
param1 = integer, "21"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "85234110"
param4 = varchar(500), "DOCE NECTAR 400G ABOBORA/COCO"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896714800288"
param7 = bigint(*, -4), "8.0000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.4490 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133470, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.4490 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8229:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.4490 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133470, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4590 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133471, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4620 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133471, CONCURRENCY | WAIT | READ_WRITE)

Statement 8230:
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
    est.controle = '22'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.4620 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133471, CONCURRENCY | WAIT | READ_WRITE)

Statement 8230:
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
    est.controle = '22'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4630 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8230:
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
    est.controle = '22'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4630 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8230:
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
    est.controle = '22'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4630 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133471, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4630 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133472, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4640 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133472, CONCURRENCY | WAIT | READ_WRITE)

Statement 8231:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.4640 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133472, CONCURRENCY | WAIT | READ_WRITE)

Statement 8231:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4640 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8231:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4640 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133472, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4650 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133473, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4650 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133473, CONCURRENCY | WAIT | READ_WRITE)

Statement 8232:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.4650 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133473, CONCURRENCY | WAIT | READ_WRITE)

Statement 8232:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54102"
param1 = integer, "22"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "20071000"
param4 = varchar(500), "DOCE PIA 400G FIGO"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896348811179"
param7 = bigint(*, -4), "12.0000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.4650 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133473, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.4650 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8232:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.4650 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133473, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4680 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133474, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4700 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133474, CONCURRENCY | WAIT | READ_WRITE)

Statement 8233:
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
    est.controle = '23'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.4700 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133474, CONCURRENCY | WAIT | READ_WRITE)

Statement 8233:
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
    coalesce((select sum(qtde) as qtde from titemopcomp
osicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '23'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4700 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8233:
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
    est.controle = '23'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4700 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8233:
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
    est.controle = '23'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4700 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133474, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4710 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133475, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4710 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133475, CONCURRENCY | WAIT | READ_WRITE)

Statement 8234:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.4710 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133475, CONCURRENCY | WAIT | READ_WRITE)

Statement 8234:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4710 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8234:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4710 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133475, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4720 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133476, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4720 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133476, CONCURRENCY | WAIT | READ_WRITE)

Statement 8235:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.4720 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133476, CONCURRENCY | WAIT | READ_WRITE)

Statement 8235:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54103"
param1 = integer, "23"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "20071000"
param4 = varchar(500), "DOCE PIA 400G PESSEGO"
param5 = varchar(500), "UN"
param6 = varchar(500), "7896348811223"
param7 = bigint(*, -4), "5.0000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.4720 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133476, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.4720 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8235:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.4730 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133476, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4860 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133477, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4870 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133477, CONCURRENCY | WAIT | READ_WRITE)

Statement 8236:
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
    est.controle = '24'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.4880 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133477, CONCURRENCY | WAIT | READ_WRITE)

Statement 8236:
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
    est.controle = '24'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4880 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8236:
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
    est.controle = '24'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4880 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8236:
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
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast
(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '24'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.4880 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133477, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4890 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133478, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4890 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133478, CONCURRENCY | WAIT | READ_WRITE)

Statement 8237:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.4890 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133478, CONCURRENCY | WAIT | READ_WRITE)

Statement 8237:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4890 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8237:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.4890 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133478, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4900 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133479, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.4900 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133479, CONCURRENCY | WAIT | READ_WRITE)

Statement 8238:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.4900 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133479, CONCURRENCY | WAIT | READ_WRITE)

Statement 8238:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54104"
param1 = integer, "24"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "85234110"
param4 = varchar(500), "CHOCOLATE NESTLE 400G ESPECIALIDADES BOMBONS"
param5 = varchar(500), "UN"
param6 = varchar(500), "7891000467404"
param7 = bigint(*, -4), "16.0000"
param8 = bigint(*, -4), "1.9245"
param9 = bigint(*, -4), "30.7920"


2025-02-12T13:46:36.4900 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133479, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.4900 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8238:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.4900 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133479, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.4970 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133480, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5190 (4816:0000000000E98EE8) TRACE_INIT
    SESSION_2 IBE_12/02/2025 13:46:34
    

2025-02-12T13:46:36.5190 (4816:0000000000E98EE8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289789, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:3160
        (TRA_15133481, CONCURRENCY | NOWAIT | READ_WRITE)

2025-02-12T13:46:36.5190 (4816:0000000000E98EE8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289789, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:3160
        (TRA_15133481, CONCURRENCY | NOWAIT | READ_WRITE)

Statement 8240:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/12 12:51:36.0000' and '2025/02/12 13:46:36.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))
      0 ms

2025-02-12T13:46:36.5200 (4816:0000000000E98EE8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289789, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:3160
        (TRA_15133481, CONCURRENCY | NOWAIT | READ_WRITE)

Statement 8240:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/12 12:51:36.0000' and '2025/02/12 13:46:36.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-12T13:46:36.5200 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133480, CONCURRENCY | WAIT | READ_WRITE)

Statement 8239:
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
    est.controle = '25'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.5200 (4816:0000000000E98EE8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289789, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:3160

Statement 8240:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/12 12:51:36.0000' and '2025/02/12 13:46:36.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-12T13:46:36.5200 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133480, CONCURRENCY | WAIT | READ_WRITE)

Statement 8239:
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
    est.controle = '25'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5200 (4816:0000000000E98EE8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289789, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:3160

Statement 8240:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/12 12:51:36.0000' and '2025/02/12 13:46:36.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-12T13:46:36.5200 (4816:0000000000E98EE8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289789, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:3160
        (TRA_15133481, CONCURRENCY | NOWAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5210 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8239:
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
    est.controle = '25'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5210 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8239:
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
    est.controle = '25'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5210 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133480, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5210 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133482, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5210 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133482, CONCURRENCY | WAIT | READ_WRITE)

Statement 8242:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.5220 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133482, CONCURRENCY | WAIT | READ_WRITE)

Statement 8242:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5220 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8242:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5220 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133482, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5220 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133483, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5230 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133483, CONCURRENCY | WAIT | READ_WRITE)

Statement 8243:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.5230 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133483, CONCURRENCY | WAIT | READ_WRITE)

Statement 8243:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54105"
param1 = integer, "25"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "18069000"
param4 = varchar(500), "GAROTO CAIXA BOMBONS SORTIDOS 250GR"
param5 = varchar(500), "UN"
param6 = varchar(500), "7891008121025"
param7 = bigint(*, -4), "13.0000"
param8 = bigint(*, -4), "11.0614"
param9 = bigint(*, -4), "143.7982"


2025-02-12T13:46:36.5230 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133483, CONCURRENCY | WAIT | READ_WRITE)
    
TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.5230 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8243:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.5230 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133483, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5290 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133484, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5310 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133484, CONCURRENCY | WAIT | READ_WRITE)

Statement 8244:
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
    est.controle = '28'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.5310 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133484, CONCURRENCY | WAIT | READ_WRITE)

Statement 8244:
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
    est.controle = '28'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5320 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8244:
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
    est.controle = '28'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5320 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8244:
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
    est.controle = '28'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5320 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133484, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5320 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133485, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5330 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133485, CONCURRENCY | WAIT | READ_WRITE)

Statement 8245:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.5330 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133485, CONCURRENCY | WAIT | READ_WRITE)

Statement 8245:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5330 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8245:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5330 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133485, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5340 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133486, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5350 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133486, CONCURRENCY | WAIT | READ_WRITE)

Statement 8246:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.5350 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133486, CONCURRENCY | WAIT | READ_WRITE)

Statement 8246:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54106"
param1 = integer, "28"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "21069010"
param4 = varchar(500), "TANG LARANJA/MAMÃO"
param5 = varchar(500), "UN"
param6 = varchar(500), "7622300392031"
param7 = bigint(*, -4), "80.0000"
param8 = bigint(*, -4), "0.8188"
param9 = bigint(*, -4), "65.5040"


2025-02-12T13:46:36.5350 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133486, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.5350 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8246:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.5360 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133486, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5390 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133487, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5400 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133487, CONCURRENCY | WAIT | READ_WRITE)

Statement 8247:
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
    est.controle = '29'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.5410 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133487, CONCURRENCY | WAIT | READ_WRITE)

Statement 8247:
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
    est.controle = '29'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP 
INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5410 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8247:
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
    est.controle = '29'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5410 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8247:
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
    est.controle = '29'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5420 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133487, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5420 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133488, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5420 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133488, CONCURRENCY | WAIT | READ_WRITE)

Statement 8248:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.5420 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133488, CONCURRENCY | WAIT | READ_WRITE)

Statement 8248:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5420 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8248:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5430 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133488, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5440 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133489, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5450 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133489, CONCURRENCY | WAIT | READ_WRITE)

Statement 8249:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.5450 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133489, CONCURRENCY | WAIT | READ_WRITE)

Statement 8249:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54107"
param1 = integer, "29"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "21069010"
param4 = varchar(500), "TANG ABACAXI/COCO"
param5 = varchar(500), "UN"
param6 = varchar(500), "7622300386665"
param7 = bigint(*, -4), "10.0000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.5450 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133489, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.5460 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8249:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.5460 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133489, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5490 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133490, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5510 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133490, CONCURRENCY | WAIT | READ_WRITE)

Statement 8250:
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
    est.controle = '30'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.5510 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133490, CONCURRENCY | WAIT | READ_WRITE)

Statement 8250:
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
    est.controle = '30'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5520 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8250:
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
    est.controle = '30'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5520 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8250:
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
    est.controle = '30'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN
 (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5520 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133490, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5520 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133491, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5530 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133491, CONCURRENCY | WAIT | READ_WRITE)

Statement 8251:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.5530 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133491, CONCURRENCY | WAIT | READ_WRITE)

Statement 8251:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5530 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8251:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5530 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133491, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5550 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133492, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5550 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133492, CONCURRENCY | WAIT | READ_WRITE)

Statement 8252:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.5550 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133492, CONCURRENCY | WAIT | READ_WRITE)

Statement 8252:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54108"
param1 = integer, "30"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "21069010"
param4 = varchar(500), "NUTRINHO 25G ABACAXI"
param5 = varchar(500), "UN"
param6 = varchar(500), "7891331001513"
param7 = bigint(*, -4), "50.0000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.5550 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133492, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.5550 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8252:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.5560 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133492, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5690 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133493, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5700 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133493, CONCURRENCY | WAIT | READ_WRITE)

Statement 8253:
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
    est.controle = '31'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.5710 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133493, CONCURRENCY | WAIT | READ_WRITE)

Statement 8253:
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
    est.controle = '31'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5720 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8253:
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
    est.controle = '31'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5720 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8253:
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
    est.controle = '31'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5720 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133493, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5720 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133494, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5720 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133494, CONCURRENCY | WAIT | READ_WRITE)

Statement 8254:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.5720 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133494, CONCURRENCY | WAIT | READ_WRITE)

Statement 8254:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5720 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8254:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5730 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133494, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5730 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133495, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5740 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133495, CONCURRENCY | WAIT | READ_WRITE)

Statement 8255:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.5740 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133495, CONCURRENCY | WAIT | READ_WRITE)

Statement 8255:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54109"
param1 = integer, "31"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "21069010"
param4 = varchar(500), "TANG MARACUJA 25GR"
param5 = varchar(500), "UN"
param6 = varchar(500), "7622300391713"
param7 = bigint(*, -4), "101.0000"
param8 = bigint(*, -4), "0.8072"
param9 = bigint(*, -4), "81.5272"


2025-02-12T13:46:36.5740 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133495, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.5740 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8255:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.5750 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133495, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5860 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133496, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5870 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133496, CONCURRENCY | WAIT | READ_WRITE)

Statement 8256:
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
        coalesce((select s
um(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '500'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.5880 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133496, CONCURRENCY | WAIT | READ_WRITE)

Statement 8256:
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
    est.controle = '500'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5960 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8256:
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
    est.controle = '500'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5960 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8256:
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
    est.controle = '500'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.5970 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133496, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5970 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133497, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5970 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133497, CONCURRENCY | WAIT | READ_WRITE)

Statement 8257:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.5970 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133497, CONCURRENCY | WAIT | READ_WRITE)

Statement 8257:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5970 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8257:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.5980 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133497, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.5980 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133498, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.5980 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133498, CONCURRENCY | WAIT | READ_WRITE)

Statement 8258:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.5990 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133498, CONCURRENCY | WAIT | READ_WRITE)

Statement 8258:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54110"
param1 = integer, "500"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "19011090"
param4 = varchar(500), "BISNAGUINHA DE CREME FAROFA"
param5 = varchar(500), "KG"
param6 = varchar(500), "2005000"
param7 = bigint(*, -4), "215.8500"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.5990 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133498, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.5990 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8258:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.5990 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133498, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6090 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133499, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6120 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133499, CONCURRENCY | WAIT | READ_WRITE)

Statement 8259:
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
    est.controle = '501'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.6120 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133499, CONCURRENCY | WAIT | READ_WRITE)

Statement 8259:
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
    est.controle = '501'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6200 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8259:
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
    est.controle = '501'
^^^^^^^^^^^^^^^^
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6200 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8259:
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
    est.controle = '501'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6200 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133499, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6200 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133500, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6210 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133500, CONCURRENCY | WAIT | READ_WRITE)

Statement 8260:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.6210 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133500, CONCURRENCY | WAIT | READ_WRITE)

Statement 8260:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.6210 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8260:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.6210 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133500, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6210 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133501, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6220 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133501, CONCURRENCY | WAIT | READ_WRITE)

Statement 8261:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.6220 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133501, CONCURRENCY | WAIT | READ_WRITE)

Statement 8261:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54111"
param1 = integer, "501"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "19059090"
param4 = varchar(500), "PAO FRANCES"
param5 = varchar(500), "KG1"
param6 = varchar(500), "2005010"
param7 = bigint(*, -4), "366.2100"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.6220 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133501, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.6220 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8261:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.6220 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133501, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6240 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133502, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6260 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133502, CONCURRENCY | WAIT | READ_WRITE)

Statement 8262:
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
    est.controle = '502'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.6270 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133502, CONCURRENCY | WAIT | READ_WRITE)

Statement 8262:
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
    est.controle = '502'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6310 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8262:
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
    est.controle = '502'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6310 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8262:
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
    est.controle = '502'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6330 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133502, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6340 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133503, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6340 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133503, CONCURRENCY | WAIT | READ_WRITE)

Statement 8263:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.6350 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133503, CONCURRENCY | WAIT | READ_WRITE)

Statement 8263:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.6350 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8263:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.6360 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133503, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6370 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133504, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6370 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133504, CONCURRENCY | WAIT | READ_WRITE)

Statement 8264:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.6370 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133504, CONCURRENCY | WAIT | READ_WRITE)

Statement 8264:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54112"
param1 = integer, "502"
param2 = varchar(500),
 "INVENTARIO"
param3 = varchar(500), "19011090"
param4 = varchar(500), "PAO DOCE COM FAROFA"
param5 = varchar(500), "KG"
param6 = varchar(500), "2005020"
param7 = bigint(*, -4), "499.9940"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.6370 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133504, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.6370 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8264:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.6370 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133504, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6440 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133505, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6460 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133505, CONCURRENCY | WAIT | READ_WRITE)

Statement 8265:
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
    est.controle = '503'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.6470 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133505, CONCURRENCY | WAIT | READ_WRITE)

Statement 8265:
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
    est.controle = '503'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6470 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8265:
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
    est.controle = '503'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6480 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8265:
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
    est.controle = '503'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6480 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133505, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6480 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133506, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6490 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133506, CONCURRENCY | WAIT | READ_WRITE)

Statement 8266:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.6490 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133506, CONCURRENCY | WAIT | READ_WRITE)

Statement 8266:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.6490 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8266:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.6490 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133506, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6500 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133507, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6500 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133507, CONCURRENCY | WAIT | READ_WRITE)

Statement 8267:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.6500 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133507, CONCURRENCY | WAIT | READ_WRITE)

Statement 8267:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54113"
param1 = integer, "503"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "19052090"
param4 = varchar(500), "PAO CASEIRO DE MORANGA"
param5 = varchar(500), "KG"
param6 = varchar(500), "2005030"
param7 = bigint(*, -4), "59.0000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.6500 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133507, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.6500 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8267:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.6510 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133507, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6560 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133508, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6580 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133508, CONCURRENCY | WAIT | READ_WRITE)

Statement 8268:
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
    est.controle = '504'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.6580 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133508, CONCURRENCY | WAIT | READ_WRITE)

Statement 8268:
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
        coalesce((sel
ect sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '504'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6590 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8268:
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
    est.controle = '504'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6600 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8268:
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
    est.controle = '504'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6600 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133508, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6600 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133509, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6610 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133509, CONCURRENCY | WAIT | READ_WRITE)

Statement 8269:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.6620 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133509, CONCURRENCY | WAIT | READ_WRITE)

Statement 8269:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.6620 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8269:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.6620 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133509, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6630 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133510, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6630 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133510, CONCURRENCY | WAIT | READ_WRITE)

Statement 8270:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.6630 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133510, CONCURRENCY | WAIT | READ_WRITE)

Statement 8270:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54114"
param1 = integer, "504"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "19011090"
param4 = varchar(500), "PAO DE LEITE"
param5 = varchar(500), "KG"
param6 = varchar(500), "2005040"
param7 = bigint(*, -4), "110.6400"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.6630 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133510, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.6630 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8270:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.6640 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133510, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 6 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6730 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133511, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6810 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133511, CONCURRENCY | WAIT | READ_WRITE)

Statement 8271:
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
    est.controle = '505'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      7 ms

2025-02-12T13:46:36.6820 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133511, CONCURRENCY | WAIT | READ_WRITE)

Statement 8271:
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
    est.controle = '505'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6840 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8271:
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
    est.controle = '505'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6840 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8271:
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
    qtde
_apuracao
from
    testoque est
where 
    est.controle = '505'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6840 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133511, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6850 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133512, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6850 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133512, CONCURRENCY | WAIT | READ_WRITE)

Statement 8272:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.6850 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133512, CONCURRENCY | WAIT | READ_WRITE)

Statement 8272:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.6850 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8272:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.6850 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133512, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6860 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133513, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6860 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133513, CONCURRENCY | WAIT | READ_WRITE)

Statement 8273:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.6860 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133513, CONCURRENCY | WAIT | READ_WRITE)

Statement 8273:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54115"
param1 = integer, "505"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "19011090"
param4 = varchar(500), "PAO SANDUICHE FATIADO"
param5 = varchar(500), "KG"
param6 = varchar(500), "2005050"
param7 = bigint(*, -4), "221.3200"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.6860 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133513, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.6860 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8273:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.6860 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133513, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6920 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133514, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6950 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133514, CONCURRENCY | WAIT | READ_WRITE)

Statement 8274:
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
    est.controle = '506'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      2 ms

2025-02-12T13:46:36.6960 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133514, CONCURRENCY | WAIT | READ_WRITE)

Statement 8274:
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
    est.controle = '506'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6990 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8274:
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
    est.controle = '506'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6990 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8274:
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
    est.controle = '506'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.6990 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133514, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.6990 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133515, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.6990 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133515, CONCURRENCY | WAIT | READ_WRITE)

Statement 8275:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.7000 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133515, CONCURRENCY | WAIT | READ_WRITE)

Statement 8275:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7000 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8275:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7000 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133515, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7010 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133516, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7010 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133516, CONCURRENCY | WAIT | READ_WRITE)

Statement 8276:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.7010 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133516, CONCURRENCY | WAIT | READ_WRITE)

Statement 8276:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54116"
param1 = integer, "506"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "19059090"
param4 = varchar(500), "BISNAGUINHA"
param5 = varchar(500), "KG"
param6 = varchar(500), "2005060"
param7 = bigint(*, -4), "43.2800"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.7010 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133516, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.7010 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8276:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.7010 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133516, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7090 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133517, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7120 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133517, CONCURRENCY | WAIT | READ_WRITE)

Statement 8277:
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
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codpro
ducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '507'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      2 ms

2025-02-12T13:46:36.7120 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133517, CONCURRENCY | WAIT | READ_WRITE)

Statement 8277:
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
    est.controle = '507'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7150 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8277:
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
    est.controle = '507'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7150 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8277:
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
    est.controle = '507'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7150 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133517, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7160 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133518, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7160 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133518, CONCURRENCY | WAIT | READ_WRITE)

Statement 8278:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.7160 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133518, CONCURRENCY | WAIT | READ_WRITE)

Statement 8278:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7160 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8278:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7160 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133518, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7170 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133519, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7170 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133519, CONCURRENCY | WAIT | READ_WRITE)

Statement 8279:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.7170 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133519, CONCURRENCY | WAIT | READ_WRITE)

Statement 8279:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54117"
param1 = integer, "507"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "19011090"
param4 = varchar(500), "PAO DE CACHORRO QUENTE"
param5 = varchar(500), "KG"
param6 = varchar(500), "2005070"
param7 = bigint(*, -4), "499.9980"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.7170 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133519, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.7170 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8279:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.7180 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133519, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7270 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133520, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7300 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133520, CONCURRENCY | WAIT | READ_WRITE)

Statement 8280:
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
    est.controle = '508'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.7300 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133520, CONCURRENCY | WAIT | READ_WRITE)

Statement 8280:
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
    est.controle = '508'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7310 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8280:
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
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle a
nd cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '508'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7310 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8280:
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
    est.controle = '508'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7310 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133520, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7310 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133521, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7320 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133521, CONCURRENCY | WAIT | READ_WRITE)

Statement 8281:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.7320 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133521, CONCURRENCY | WAIT | READ_WRITE)

Statement 8281:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7320 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8281:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7320 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133521, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7320 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133522, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7330 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133522, CONCURRENCY | WAIT | READ_WRITE)

Statement 8282:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.7330 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133522, CONCURRENCY | WAIT | READ_WRITE)

Statement 8282:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54118"
param1 = integer, "508"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "19052090"
param4 = varchar(500), "PAO AMANTEIGADO"
param5 = varchar(500), "KG"
param6 = varchar(500), "2005080"
param7 = bigint(*, -4), "99.4500"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.7330 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133522, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.7330 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8282:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.7330 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133522, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7350 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133523, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7370 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133523, CONCURRENCY | WAIT | READ_WRITE)

Statement 8283:
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
    est.controle = '509'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.7380 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133523, CONCURRENCY | WAIT | READ_WRITE)

Statement 8283:
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
    est.controle = '509'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7380 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8283:
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
    est.controle = '509'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7380 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8283:
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
    est.controle = '509'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7380 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133523, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7390 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133524, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7390 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133524, CONCURRENCY | WAIT | READ_WRITE)

Statement 8284:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.7390 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133524, CONCURRENCY | WAIT | READ_WRITE)

Statement 8284:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7390 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8284:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7400 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133524, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7400 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133525, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7400 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133525, CONCURRENCY | WAIT | READ_WRITE)

Statement 8285:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.7410 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB
 (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133525, CONCURRENCY | WAIT | READ_WRITE)

Statement 8285:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54119"
param1 = integer, "509"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "19052090"
param4 = varchar(500), "PAO SUIÇO"
param5 = varchar(500), "KG"
param6 = varchar(500), "2005090"
param7 = bigint(*, -4), "6.8000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.7410 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133525, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.7410 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8285:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.7410 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133525, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7460 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133526, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7480 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133526, CONCURRENCY | WAIT | READ_WRITE)

Statement 8286:
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
    est.controle = '510'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.7490 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133526, CONCURRENCY | WAIT | READ_WRITE)

Statement 8286:
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
    est.controle = '510'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7490 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8286:
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
    est.controle = '510'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7490 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8286:
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
    est.controle = '510'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7490 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133526, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7500 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133527, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7500 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133527, CONCURRENCY | WAIT | READ_WRITE)

Statement 8287:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.7500 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133527, CONCURRENCY | WAIT | READ_WRITE)

Statement 8287:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7500 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8287:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7500 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133527, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7510 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133528, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7510 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133528, CONCURRENCY | WAIT | READ_WRITE)

Statement 8288:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.7510 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133528, CONCURRENCY | WAIT | READ_WRITE)

Statement 8288:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54120"
param1 = integer, "510"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "19052090"
param4 = varchar(500), "PAO CERVEJINHA"
param5 = varchar(500), "KG"
param6 = varchar(500), "2005100"
param7 = bigint(*, -4), "19.1700"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.7510 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133528, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.7520 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8288:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.7520 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133528, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7570 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133529, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7590 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133529, CONCURRENCY | WAIT | READ_WRITE)

Statement 8289:
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
    est.controle = '511'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.7590 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133529, CONCURRENCY | WAIT | READ_WRITE)

Statement 8289:
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
        and inc.codproduto = est.controle and inc.cancelado <> 'SIM' and inc.conf
irmado = 'SIM'),0) +
    coalesce((select sum(qtde) as qtde from titemopcomposicao iopc inner join tordemproducao op on op.controle = iopc.codproducao where op.datafinal > '12/31/2024'
        and iopc.codproduto = est.controle and op.status = 'FINALIZADA'),0))
        - iif(coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) > 0,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0) * 1,
        coalesce((select sum(qtdealterada) as qtde from tajusteestoque where codproduto = est.controle and cast(datahoracadastro as date) >  '12/31/2024'),0))
    qtde_apuracao
from
    testoque est
where 
    est.controle = '511'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7600 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8289:
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
    est.controle = '511'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7600 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8289:
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
    est.controle = '511'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7600 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133529, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7600 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133530, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7610 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133530, CONCURRENCY | WAIT | READ_WRITE)

Statement 8290:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)
      0 ms

2025-02-12T13:46:36.7610 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133530, CONCURRENCY | WAIT | READ_WRITE)

Statement 8290:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7610 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8290:
-------------------------------------------------------------------------------
SELECT GEN_ID(GEN_TTEMP_ID, 1) CONTROLE
FROM RDB$DATABASE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (RDB$DATABASE NATURAL)

2025-02-12T13:46:36.7620 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133530, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 2 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7630 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133531, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7630 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133531, CONCURRENCY | WAIT | READ_WRITE)

Statement 8291:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE
      0 ms

2025-02-12T13:46:36.7630 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133531, CONCURRENCY | WAIT | READ_WRITE)

Statement 8291:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

param0 = integer, "54121"
param1 = integer, "511"
param2 = varchar(500), "INVENTARIO"
param3 = varchar(500), "19052090"
param4 = varchar(500), "PAO CASEIRO DE AIPIN"
param5 = varchar(500), "KG"
param6 = varchar(500), "2005110"
param7 = bigint(*, -4), "11.9000"
param8 = bigint(*, -4), "0"
param9 = bigint(*, -4), "0"


2025-02-12T13:46:36.7630 (4816:0000000000E9D9E8) EXECUTE_TRIGGER_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133531, CONCURRENCY | WAIT | READ_WRITE)
    TTEMP_BI FOR TTEMP (BEFORE INSERT) 

2025-02-12T13:46:36.7640 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8291:
-------------------------------------------------------------------------------
INSERT INTO TTEMP
(CONTROLE, CAMPO1, CAMPO4, CAMPO5, CAMPO6, 
  CAMPO7, CAMPO8, CAMPO10, CAMPO11, CAMPO12)
VALUES (?, ?, ?, ?, ?, 
  ?, ?, ?, ?, ?)
RETURNING CONTROLE

2025-02-12T13:46:36.7640 (4816:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133531, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 3 write(s), 1 fetch(es), 1 mark(s)

2025-02-12T13:46:36.7680 (4816:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133532, CONCURRENCY | WAIT | READ_WRITE)

2025-02-12T13:46:36.7700 (4816:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133532, CONCURRENCY | WAIT | READ_WRITE)

Statement 8292:
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
    est.controle = '512'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))
      1 ms

2025-02-12T13:46:36.7700 (4816:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172
        (TRA_15133532, CONCURRENCY | WAIT | READ_WRITE)

Statement 8292:
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
    est.controle = '512'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7710 (4816:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8292:
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
    est.controle = '512'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (IC INDEX (CODPROD_TITEMCOMPRA), CMP INDEX (PK_TCOMPRA))
PLAN JOIN (IO INDEX (FK_TITEMORDEMPRODUCAO_1), OP INDEX (PK_TORDEMPRODUCAO))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (IEC INDEX (TITEMVENDAECF_IDXCODPRODUTO, TITEMVENDAECF_IDXDATAECF), ECF INDEX (PK_TVENDAECF))
PLAN JOIN (NF INDEX (DTEMI_TVENDANFE), INF INDEX (FK_TITENSVENDANFE_1, ENVIADA_TITENSVENDANFE))
PLAN JOIN (INFC INDEX (TITEMVENDANFCE_CODPROD, TITEMVENDANFCE_ENV), NFC INDEX (PK_TVENDANFCE))
PLAN JOIN (INC INDEX (TITENNOTACONSUMIDOR_CODPROD, TITENNOTACONSUMIDOR_CONF), NC INDEX (PK_TNOTACONSUMIDOR))
PLAN JOIN (IOPC INDEX (FK_TITEMOPCOMPOSICAO_3), OP INDEX (PK_TORDEMPRODUCAO))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (TAJUSTEESTOQUE INDEX (CODPRODUTO_TAJUSTEESTOQUE))
PLAN (EST INDEX (PK_TESTOQUE))

2025-02-12T13:46:36.7710 (4816:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC - 2.FDB (ATT_289817, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:11172

Statement 8292:
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
        - iif(coalesce((select sum(qtdea

IBE> Trace session IBE_12/02/2025 13:46:34 terminated.
