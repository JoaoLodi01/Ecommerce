--=-=-=-=-=--=-=-=-=-=-=-=-
select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO'
-- Query 1
--=-=-=-=-=--=-=-=-=-=-=-=-

select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/07 14:23:26.0000' and '2025/02/07 15:18:26.9999' order by controle desc
-- Query 2
--=-=-=-=-=--=-=-=-=-=-=-=-

select * from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO'
-- Query 3
--=-=-=-=-=--=-=-=-=-=-=-=-
select distinct 
    e.* 
from
    tformapagamentonotamanual fp
inner join tespecie e on fp.codespecie = e.controle 
where
    codnotamanual 
    in(
        select 
            controle
        from
            tnotaconsumidor 
        where
            cast(dataehoracadastro as date) between'02/06/2025' and
            '02/06/2025' and cancelado <> 'SIM' ) and valorpago > 0
-- Query 4

--=-=-=-=-=--=-=-=-=-=-=-=-

select
        cx.centrocusto CENTROCUSTO,
        sum(cx.valorentrada) VALORENTRADA,
        sum(cx.valorsaida) VALORSAIDA
    from tcaixa cx
    inner join tcentrocusto cc on cx.centrocusto = cc.centrocusto
    where
        (cc.centrocusto = 'CENTRO DE CUSTO PADRÃO') and 
        (cast(cx.datahoracadastro as date) between '02/06/2025' and 
        '02/06/2025')
        and (((cx.origem like '%NOTA MANUAL%') or (cx.origem like '%NOTA CONSUMIDOR%')))
    group by cx.centrocusto

-- Query 5
--=-=-=-=-=--=-=-=-=-=-=-=-

select
    *
from
    tcaixa
where
    (cast(datahoracadastro as date) between '02/06/2025' and '02/06/2025') and 
    (codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')) and 
    ((origem = 'SANGRIA NOTA MANUAL') or (origem = 'SUPRIMENTO NOTA MANUAL'))

-- Query 6
--=-=-=-=-=--=-=-=-=-=-=-=-

SELECT * FROM TNOTACONSUMIDOR TN WHERE (cast(TN.dataehoracadastro as date) between '02/06/2025' and '02/06/2025')

-- Query 7
--=-=-=-=-=--=-=-=-=-=-=-=-
SELECT * FROM TNOTACONSUMIDOR TN WHERE (cast(TN.dataehoracadastro as date) between '02/06/2025' and '02/06/2025')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TN NATURAL)

2025-02-07T15:18:28.7960 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1569:
-------------------------------------------------------------------------------
SELECT * FROM TNOTACONSUMIDOR TN WHERE (cast(TN.dataehoracadastro as date) between '02/06/2025' and '02/06/2025')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TN NATURAL)

2025-02-07T15:18:28.7970 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1569:
-------------------------------------------------------------------------------
SELECT * FROM TNOTACONSUMIDOR TN WHERE (cast(TN.dataehoracadastro as date) between '02/06/2025' and '02/06/2025')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TN NATURAL)

2025-02-07T15:18:28.7970 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092289, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-07T15:18:28.7970 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092291, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:28.8080 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092291, CONCURRENCY | WAIT | READ_WRITE)

Statement 1571:
-------------------------------------------------------------------------------

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TNOTACONSUMIDOR INDEX (PK_TNOTACONSUMIDOR))
PLAN SORT (JOIN (E NATURAL, FP INDEX (FK_CODESPECIE)))
      9 ms

2025-02-07T15:18:28.8080 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092292, READ_COMMITTED | REC_VERSION | NOWAIT | READ_ONLY)

2025-02-07T15:18:28.8090 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092292, READ_COMMITTED | REC_VERSION | NOWAIT | READ_ONLY)

Statement 1572:
-------------------------------------------------------------------------------
SELECT CAST(NULL AS NUMERIC) AS RECNO, CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, C.RDB$RELATION_NAME AS TABLE_NAME, C.RDB$INDEX_NAME AS INDEX_NAME, S.RDB$FIELD_NAME AS COLUMN_NAME, S.RDB$FIELD_POSITION + 1 AS COLUMN_POSITION, 'A' AS SORT_ORDER, CAST(NULL AS VARCHAR(67)) AS FILTER_ FROM RDB$RELATION_CONSTRAINTS C LEFT JOIN RDB$INDEX_SEGMENTS S ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME WHERE C.RDB$CONSTRAINT_TYPE = 'PRIMARY KEY' AND C.RDB$RELATION_NAME = ? ORDER BY 7
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT (JOIN (C INDEX (RDB$INDEX_42), S INDEX (RDB$INDEX_6)))
      0 ms

2025-02-07T15:18:28.8090 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092292, READ_COMMITTED | REC_VERSION | NOWAIT | READ_ONLY)

Statement 1572:
-------------------------------------------------------------------------------
SELECT CAST(NULL AS NUMERIC) AS RECNO, CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, C.RDB$RELATION_NAME AS TABLE_NAME, C.RDB$INDEX_NAME AS INDEX_NAME, S.RDB$FIELD_NAME AS COLUMN_NAME, S.RDB$FIELD_POSITION + 1 AS COLUMN_POSITION, 'A' AS SORT_ORDER, CAST(NULL AS VARCHAR(67)) AS FILTER_ FROM RDB$RELATION_CONSTRAINTS C LEFT JOIN RDB$INDEX_SEGMENTS S ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME WHERE C.RDB$CONSTRAINT_TYPE = 'PRIMARY KEY' AND C.RDB$RELATION_NAME = ? ORDER BY 7
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT (JOIN (C INDEX (RDB$INDEX_42), S INDEX (RDB$INDEX_6)))

param0 = varchar(93), "TFORMAPAGAMENTONOTAMANUAL"


2025-02-07T15:18:28.8100 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1572:
-------------------------------------------------------------------------------
SELECT CAST(NULL AS NUMERIC) AS RECNO, CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, C.RDB$RELATION_NAME AS TABLE_NAME, C.RDB$INDEX_NAME AS INDEX_NAME, S.RDB$FIELD_NAME AS COLUMN_NAME, S.RDB$FIELD_POSITION + 1 AS COLUMN_POSITION, 'A' AS SORT_ORDER, CAST(NULL AS VARCHAR(67)) AS FILTER_ FROM RDB$RELATION_CONSTRAINTS C LEFT JOIN RDB$INDEX_SEGMENTS S ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME WHERE C.RDB$CONSTRAINT_TYPE = 'PRIMARY KEY' AND C.RDB$RELATION_NAME = ? ORDER BY 7
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT (JOIN (C INDEX (RDB$INDEX_42), S INDEX (RDB$INDEX_6)))

2025-02-07T15:18:28.8100 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1572:
-------------------------------------------------------------------------------
SELECT CAST(NULL AS NUMERIC) AS RECNO, CAST(NULL AS VARCHAR(67)) AS CATALOG_NAME, CAST(NULL AS VARCHAR(67)) AS SCHEMA_NAME, C.RDB$RELATION_NAME AS TABLE_NAME, C.RDB$INDEX_NAME AS INDEX_NAME, S.RDB$FIELD_NAME AS COLUMN_NAME, S.RDB$FIELD_POSITION + 1 AS COLUMN_POSITION, 'A' AS SORT_ORDER, CAST(NULL AS VARCHAR(67)) AS FILTER_ FROM RDB$RELATION_CONSTRAINTS C LEFT JOIN RDB$INDEX_SEGMENTS S ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME WHERE C.RDB$CONSTRAINT_TYPE = 'PRIMARY KEY' AND C.RDB$RELATION_NAME = ? ORDER BY 7
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT (JOIN (C INDEX (RDB$INDEX_42), S INDEX (RDB$INDEX_6)))

2025-02-07T15:18:28.8100 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092292, READ_COMMITTED | REC_VERSION | NOWAIT | READ_ONLY)
      0 ms

2025-02-07T15:18:28.8100 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092291, CONCURRENCY | WAIT | READ_WRITE)

Statement 1571:
-------------------------------------------------------------------------------

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TNOTACONSUMIDOR INDEX (PK_TNOTACONSUMIDOR))
PLAN SORT (JOIN (E NATURAL, FP INDEX (FK_CODESPECIE)))

2025-02-07T15:18:28.9330 (13464:0000000000E9A110) TRACE_INIT
    SESSION_2 IBE_07/02/2025 15:18:26
    

2025-02-07T15:18:28.9330 (13464:0000000000E9A110) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC.FDB (ATT_62191, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:10120
        (TRA_7394042, CONCURRENCY | NOWAIT | READ_WRITE)

2025-02-07T15:18:28.9350 (13464:0000000000E9A110) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC.FDB (ATT_62191, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:10120
        (TRA_7394042, CONCURRENCY | NOWAIT | READ_WRITE)

Statement 7047:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/07 14:23:28.0000' and '2025/02/07 15:18:28.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))
      0 ms

2025-02-07T15:18:28.9350 (13464:0000000000E9A110) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC.FDB (ATT_62191, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:10120
        (TRA_7394042, CONCURRENCY | NOWAIT | READ_WRITE)

Statement 7047:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/07 14:23:28.0000' and '2025/02/07 15:18:28.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-07T15:18:28.9360 (13464:0000000000E9A110) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC.FDB (ATT_62191, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:10120

Statement 7047:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/07 14:23:28.0000' and '2025/02/07 15:18:28.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-07T15:18:28.9360 (13464:0000000000E9A110) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC.FDB (ATT_62191, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:10120

Statement 7047:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/07 14:23:28.0000' and '2025/02/07 15:18:28.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-07T15:18:28.9360 (13464:0000000000E9A110) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER - HOMETEC.FDB (ATT_62191, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:10120
        (TRA_7394042, CONCURRENCY | NOWAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-07T15:18:29.4040 (13464:0000000000E98B50) TRACE_INIT
    SESSION_2 IBE_07/02/2025 15:18:26
    

2025-02-07T15:18:29.4040 (13464:0000000000E98B50) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219554, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:17168
        (TRA_34092293, CONCURRENCY | NOWAIT | READ_WRITE)

2025-02-07T15:18:29.4050 (13464:0000000000E98B50) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219554, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:17168
        (TRA_34092293, CONCURRENCY | NOWAIT | READ_WRITE)

Statement 1573:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/07 14:23:29.0000' and '2025/02/07 15:18:29.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))
      0 ms

2025-02-07T15:18:29.4050 (13464:0000000000E98B50) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219554, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:17168
        (TRA_34092293, CONCURRENCY | NOWAIT | READ_WRITE)

Statement 1573:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/07 14:23:29.0000' and '2025/02/07 15:18:29.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-07T15:18:29.4060 (13464:0000000000E98B50) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219554, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:17168

Statement 1573:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/07 14:23:29.0000' and '2025/02/07 15:18:29.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-07T15:18:29.4060 (13464:0000000000E98B50) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219554, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:17168

Statement 1573:
-------------------------------------------------------------------------------
select * from ttransacaopix where modulo = 'RECEBER' and datarecebimento is null and datahoracadastro between '2025/02/07 14:23:29.0000' and '2025/02/07 15:18:29.9999' order by controle desc
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN SORT ((TTRANSACAOPIX INDEX (TTRANSACAOPIX_MODULO)))

2025-02-07T15:18:29.4060 (13464:0000000000E98B50) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219554, SYSDBA:NONE, ISO88591, XNET:KOCHEM)
    C:\SGBR\Master\Monitoramento.exe:17168
        (TRA_34092293, CONCURRENCY | NOWAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-07T15:18:29.4400 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1571:
-------------------------------------------------------------------------------

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TNOTACONSUMIDOR INDEX (PK_TNOTACONSUMIDOR))
PLAN SORT (JOIN (E NATURAL, FP INDEX (FK_CODESPECIE)))

2025-02-07T15:18:29.4400 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1571:
-------------------------------------------------------------------------------
select distinct e.* from tformapagamentonotamanual fp inner join tespecie e on fp.codespecie = e.controle where codnotamanual in(select controle from tnotaconsumidor where cast(dataehoracadastro as date) between'02/06/2025' and '02/06/2025' and cancelado <> 'SIM' ) and valorpago > 0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TNOTACONSUMIDOR INDEX (PK_TNOTACONSUMIDOR))
PLAN SORT (JOIN (E NATURAL, FP INDEX (FK_CODESPECIE)))

2025-02-07T15:18:29.4400 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092291, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-07T15:18:29.4400 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092294, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:29.4440 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092294, CONCURRENCY | WAIT | READ_WRITE)

Statement 1574:
-------------------------------------------------------------------------------
select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A ES INDEX (PK_TESPECIE), A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
      2 ms

2025-02-07T15:18:29.4440 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092294, CONCURRENCY | WAIT | READ_WRITE)

Statement 1574:
-------------------------------------------------------------------------------
select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A ES INDEX (PK_TESPECIE), A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))

2025-02-07T15:18:29.9810 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1574:
-------------------------------------------------------------------------------
select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A ES INDEX (PK_TESPECIE), A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))

2025-02-07T15:18:29.9810 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1574:
-------------------------------------------------------------------------------
select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A ES INDEX (PK_TESPECIE), A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))

2025-02-07T15:18:29.9810 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092294, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-07T15:18:29.9820 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092295, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:29.9830 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092295, CONCURRENCY | WAIT | READ_WRITE)

Statement 1575:
-------------------------------------------------------------------------------
select sum(entrada) entrada from (select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle)a 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A A ES INDEX (PK_TESPECIE), A A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
      0 ms

2025-02-07T15:18:29.9830 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092295, CONCURRENCY | WAIT | READ_WRITE)

Statement 1575:
-------------------------------------------------------------------------------
select sum(entrada) entrada from (select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle)a 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A A ES INDEX (PK_TESPECIE), A A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))

2025-02-07T15:18:30.2660 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1575:
-------------------------------------------------------------------------------
select sum(entrada) entrada from (select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle)a 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A A ES INDEX (PK_TESPECIE), A A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))

2025-02-07T15:18:30.2660 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1575:
-------------------------------------------------------------------------------
select sum(entrada) entrada from (select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle)a 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A A ES INDEX (PK_TESPECIE), A A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))

2025-02-07T15:18:30.2660 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092295, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-07T15:18:30.2660 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092296, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:30.2680 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092296, CONCURRENCY | WAIT | READ_WRITE)

Statement 1576:
-------------------------------------------------------------------------------
select sum(saida) saida from (select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle)a 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A A ES INDEX (PK_TESPECIE), A A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
      0 ms

2025-02-07T15:18:30.2680 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092296, CONCURRENCY | WAIT | READ_WRITE)

Statement 1576:
-------------------------------------------------------------------------------
select sum(saida) saida from (select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle)a 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A A ES INDEX (PK_TESPECIE), A A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))

2025-02-07T15:18:30.5500 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1576:
-------------------------------------------------------------------------------
select sum(saida) saida from (select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle)a 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A A ES INDEX (PK_TESPECIE), A A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))

2025-02-07T15:18:30.5500 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1576:
-------------------------------------------------------------------------------
select sum(saida) saida from (select distinct
    *
from (
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
inner join
    tespecie es
on
    cx.codespecie = es.controle
inner join
    tnotaconsumidor nm
on
    nm.controle = cx.codmodulo
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codmodulo is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
    and nm.cancelado <> 'SIM'
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'ESTORNO' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorsaida > 0
union all
select
    cx.controle,
    cx.documento,
    cx.valorsaida saida,
    cx.valorentrada entrada,
    cx.especie,
    'NORMAL' as mov
from
    tcaixa cx
where
    cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto = '1'
    and cx.codreceber is not null
    and ((cx.origem = 'NOTA CONSUMIDOR') or (cx.origem = 'NOTA MANUAL'))
    and cx.valorentrada > 0
    )a 
order by
    controle)a 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM), A A ES INDEX (PK_TESPECIE), A A NM INDEX (PK_TNOTACONSUMIDOR))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))
PLAN (A A CX INDEX (FK_TCAIXA_CODCENTROCUSTO, TCAIXA_ORIGEM, TCAIXA_ORIGEM))

2025-02-07T15:18:30.5510 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092296, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-07T15:18:30.5510 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092297, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:30.5510 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092297, CONCURRENCY | WAIT | READ_WRITE)

Statement 1577:
-------------------------------------------------------------------------------
select (sum(valorentrada) - sum(valorsaida)) as tt from tcaixa
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCAIXA NATURAL)
      0 ms

2025-02-07T15:18:30.5510 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092297, CONCURRENCY | WAIT | READ_WRITE)

Statement 1577:
-------------------------------------------------------------------------------
select (sum(valorentrada) - sum(valorsaida)) as tt from tcaixa
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCAIXA NATURAL)

2025-02-07T15:18:30.5970 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1577:
-------------------------------------------------------------------------------
select (sum(valorentrada) - sum(valorsaida)) as tt from tcaixa
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCAIXA NATURAL)

2025-02-07T15:18:30.5970 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1577:
-------------------------------------------------------------------------------
select (sum(valorentrada) - sum(valorsaida)) as tt from tcaixa
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCAIXA NATURAL)

2025-02-07T15:18:30.5970 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092297, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-07T15:18:30.6560 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092298, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:30.6600 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092298, CONCURRENCY | WAIT | READ_WRITE)

Statement 1578:
-------------------------------------------------------------------------------
SELECT * FROM TCONFIGNOTAMANUAL WHERE CODCONFIG = '13'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCONFIGNOTAMANUAL INDEX (UNQ_CODCONFIG_TCONFIGNOTAMANUAL))
      1 ms

2025-02-07T15:18:30.6610 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092298, CONCURRENCY | WAIT | READ_WRITE)

Statement 1578:
-------------------------------------------------------------------------------
SELECT * FROM TCONFIGNOTAMANUAL WHERE CODCONFIG = '13'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCONFIGNOTAMANUAL INDEX (UNQ_CODCONFIG_TCONFIGNOTAMANUAL))

2025-02-07T15:18:30.6640 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1578:
-------------------------------------------------------------------------------
SELECT * FROM TCONFIGNOTAMANUAL WHERE CODCONFIG = '13'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCONFIGNOTAMANUAL INDEX (UNQ_CODCONFIG_TCONFIGNOTAMANUAL))

2025-02-07T15:18:30.6640 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1578:
-------------------------------------------------------------------------------
SELECT * FROM TCONFIGNOTAMANUAL WHERE CODCONFIG = '13'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCONFIGNOTAMANUAL INDEX (UNQ_CODCONFIG_TCONFIGNOTAMANUAL))

2025-02-07T15:18:30.6640 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092298, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-07T15:18:30.6730 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092299, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:30.6750 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092299, CONCURRENCY | WAIT | READ_WRITE)

Statement 1579:
-------------------------------------------------------------------------------
select 
    coalesce(sum(fp.valorpago), 0) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    nm.dataemissao between '02/06/2025' and '02/06/2025'
    and nm.cancelado <> 'SIM' and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO'))
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP NATURAL, NM INDEX (PK_TNOTACONSUMIDOR))
      1 ms

2025-02-07T15:18:30.6760 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092299, CONCURRENCY | WAIT | READ_WRITE)

Statement 1579:
-------------------------------------------------------------------------------
select 
    coalesce(sum(fp.valorpago), 0) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    nm.dataemissao between '02/06/2025' and '02/06/2025'
    and nm.cancelado <> 'SIM' and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO'))
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP NATURAL, NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:30.9630 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1579:
-------------------------------------------------------------------------------
select 
    coalesce(sum(fp.valorpago), 0) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    nm.dataemissao between '02/06/2025' and '02/06/2025'
    and nm.cancelado <> 'SIM' and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO'))
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP NATURAL, NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:30.9630 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1579:
-------------------------------------------------------------------------------
select 
    coalesce(sum(fp.valorpago), 0) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    nm.dataemissao between '02/06/2025' and '02/06/2025'
    and nm.cancelado <> 'SIM' and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO'))
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP NATURAL, NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:30.9630 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092299, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-07T15:18:30.9650 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092300, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:30.9660 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092300, CONCURRENCY | WAIT | READ_WRITE)

Statement 1580:
-------------------------------------------------------------------------------
select 
    coalesce(sum(fp.valorpago), 0) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    nm.dataemissao between '02/06/2025' and '02/06/2025'
     and nm.cancelado = 'SIM' and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO'))
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP NATURAL, NM INDEX (PK_TNOTACONSUMIDOR))
      0 ms

2025-02-07T15:18:30.9660 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092300, CONCURRENCY | WAIT | READ_WRITE)

Statement 1580:
-------------------------------------------------------------------------------
select 
    coalesce(sum(fp.valorpago), 0) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    nm.dataemissao between '02/06/2025' and '02/06/2025'
     and nm.cancelado = 'SIM' and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO'))
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP NATURAL, NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.2220 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1580:
-------------------------------------------------------------------------------
select 
    coalesce(sum(fp.valorpago), 0) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    nm.dataemissao between '02/06/2025' and '02/06/2025'
     and nm.cancelado = 'SIM' and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO'))
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP NATURAL, NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.2230 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1580:
-------------------------------------------------------------------------------
select 
    coalesce(sum(fp.valorpago), 0) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    nm.dataemissao between '02/06/2025' and '02/06/2025'
     and nm.cancelado = 'SIM' and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO'))
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP NATURAL, NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.2230 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092300, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-07T15:18:31.2250 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092301, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:31.2260 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092301, CONCURRENCY | WAIT | READ_WRITE)

Statement 1581:
-------------------------------------------------------------------------------
select
    sum(cx.valorsaida) tt
from
    tcaixa cx
where
    cx.origem = 'SANGRIA NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))
      0 ms

2025-02-07T15:18:31.2260 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092301, CONCURRENCY | WAIT | READ_WRITE)

Statement 1581:
-------------------------------------------------------------------------------
select
    sum(cx.valorsaida) tt
from
    tcaixa cx
where
    cx.origem = 'SANGRIA NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))

2025-02-07T15:18:31.2320 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1581:
-------------------------------------------------------------------------------
select
    sum(cx.valorsaida) tt
from
    tcaixa cx
where
    cx.origem = 'SANGRIA NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))

2025-02-07T15:18:31.2320 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1581:
-------------------------------------------------------------------------------
select
    sum(cx.valorsaida) tt
from
    tcaixa cx
where
    cx.origem = 'SANGRIA NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))

2025-02-07T15:18:31.2320 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092301, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-07T15:18:31.2340 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092302, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:31.2340 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092302, CONCURRENCY | WAIT | READ_WRITE)

Statement 1582:
-------------------------------------------------------------------------------
select
    sum(cx.valorsaida) transferencia
from
    tcaixa cx
where
    cx.origem = 'TRANSFERÊNCIA NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))
      0 ms

2025-02-07T15:18:31.2340 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092302, CONCURRENCY | WAIT | READ_WRITE)

Statement 1582:
-------------------------------------------------------------------------------
select
    sum(cx.valorsaida) transferencia
from
    tcaixa cx
where
    cx.origem = 'TRANSFERÊNCIA NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))

2025-02-07T15:18:31.2340 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1582:
-------------------------------------------------------------------------------
select
    sum(cx.valorsaida) transferencia
from
    tcaixa cx
where
    cx.origem = 'TRANSFERÊNCIA NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))

2025-02-07T15:18:31.2350 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1582:
-------------------------------------------------------------------------------
select
    sum(cx.valorsaida) transferencia
from
    tcaixa cx
where
    cx.origem = 'TRANSFERÊNCIA NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))

2025-02-07T15:18:31.2350 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092302, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-07T15:18:31.2370 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092303, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:31.2370 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092303, CONCURRENCY | WAIT | READ_WRITE)

Statement 1583:
-------------------------------------------------------------------------------
select
    sum(cx.valorentrada) tt
from
    tcaixa cx
where
    cx.origem = 'SUPRIMENTO NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))
      0 ms

2025-02-07T15:18:31.2370 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092303, CONCURRENCY | WAIT | READ_WRITE)

Statement 1583:
-------------------------------------------------------------------------------
select
    sum(cx.valorentrada) tt
from
    tcaixa cx
where
    cx.origem = 'SUPRIMENTO NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))

2025-02-07T15:18:31.2380 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1583:
-------------------------------------------------------------------------------
select
    sum(cx.valorentrada) tt
from
    tcaixa cx
where
    cx.origem = 'SUPRIMENTO NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))

2025-02-07T15:18:31.2380 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1583:
-------------------------------------------------------------------------------
select
    sum(cx.valorentrada) tt
from
    tcaixa cx
where
    cx.origem = 'SUPRIMENTO NOTA MANUAL'
    and cast(cx.datahoracadastro as date) between '02/06/2025' and '02/06/2025'
    and cx.codcentrocusto in(select controle from tcentrocusto where centrocusto = 'CENTRO DE CUSTO PADRÃO')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN (CX INDEX (TCAIXA_ORIGEM))

2025-02-07T15:18:31.2380 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092303, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-07T15:18:31.2390 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092304, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:31.2470 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092304, CONCURRENCY | WAIT | READ_WRITE)

Statement 1584:
-------------------------------------------------------------------------------
SELECT sum(COALESCE(TAXASERVICO, 0)) taxaServico FROM TNOTACONSUMIDOR TN INNER JOIN TCOMANDA TC ON TN.CODMODULO = TC.CONTROLE WHERE TC.DATAFECHAMENTO IS NOT NULL AND TN.FATURADA = 'SIM' AND TN.MODULO = 'COMANDAS'AND TC.DATAFECHAMENTO BETWEEN '12/30/1899' AND '12/30/1899'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (TN NATURAL, TC INDEX (PK_TCOMANDA))
      7 ms

2025-02-07T15:18:31.2480 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092304, CONCURRENCY | WAIT | READ_WRITE)

Statement 1584:
-------------------------------------------------------------------------------
SELECT sum(COALESCE(TAXASERVICO, 0)) taxaServico FROM TNOTACONSUMIDOR TN INNER JOIN TCOMANDA TC ON TN.CODMODULO = TC.CONTROLE WHERE TC.DATAFECHAMENTO IS NOT NULL AND TN.FATURADA = 'SIM' AND TN.MODULO = 'COMANDAS'AND TC.DATAFECHAMENTO BETWEEN '12/30/1899' AND '12/30/1899'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (TN NATURAL, TC INDEX (PK_TCOMANDA))

2025-02-07T15:18:31.3250 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1584:
-------------------------------------------------------------------------------
SELECT sum(COALESCE(TAXASERVICO, 0)) taxaServico FROM TNOTACONSUMIDOR TN INNER JOIN TCOMANDA TC ON TN.CODMODULO = TC.CONTROLE WHERE TC.DATAFECHAMENTO IS NOT NULL AND TN.FATURADA = 'SIM' AND TN.MODULO = 'COMANDAS'AND TC.DATAFECHAMENTO BETWEEN '12/30/1899' AND '12/30/1899'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (TN NATURAL, TC INDEX (PK_TCOMANDA))

2025-02-07T15:18:31.3250 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1584:
-------------------------------------------------------------------------------
SELECT sum(COALESCE(TAXASERVICO, 0)) taxaServico FROM TNOTACONSUMIDOR TN INNER JOIN TCOMANDA TC ON TN.CODMODULO = TC.CONTROLE WHERE TC.DATAFECHAMENTO IS NOT NULL AND TN.FATURADA = 'SIM' AND TN.MODULO = 'COMANDAS'AND TC.DATAFECHAMENTO BETWEEN '12/30/1899' AND '12/30/1899'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN JOIN (TN NATURAL, TC INDEX (PK_TCOMANDA))

2025-02-07T15:18:31.3250 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092304, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-07T15:18:31.3270 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092305, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:31.3280 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092305, CONCURRENCY | WAIT | READ_WRITE)

Statement 1585:
-------------------------------------------------------------------------------
select VALORSAIDA from tcaixa where controle = '40362'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCAIXA INDEX (PK_TCAIXA))
      0 ms

2025-02-07T15:18:31.3280 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092305, CONCURRENCY | WAIT | READ_WRITE)

Statement 1585:
-------------------------------------------------------------------------------
select VALORSAIDA from tcaixa where controle = '40362'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCAIXA INDEX (PK_TCAIXA))

2025-02-07T15:18:31.3290 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1585:
-------------------------------------------------------------------------------
select VALORSAIDA from tcaixa where controle = '40362'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCAIXA INDEX (PK_TCAIXA))

2025-02-07T15:18:31.3290 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1585:
-------------------------------------------------------------------------------
select VALORSAIDA from tcaixa where controle = '40362'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCAIXA INDEX (PK_TCAIXA))

2025-02-07T15:18:31.3290 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092305, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-07T15:18:31.3310 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092306, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:31.3320 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092306, CONCURRENCY | WAIT | READ_WRITE)

Statement 1586:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '1') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))
      0 ms

2025-02-07T15:18:31.3320 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092306, CONCURRENCY | WAIT | READ_WRITE)

Statement 1586:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '1') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.4950 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1586:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '1') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.4950 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1586:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '1') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.4950 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092306, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-07T15:18:31.4970 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092307, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:31.4970 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092307, CONCURRENCY | WAIT | READ_WRITE)

Statement 1587:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '2') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))
      0 ms

2025-02-07T15:18:31.4970 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092307, CONCURRENCY | WAIT | READ_WRITE)

Statement 1587:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '2') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.6500 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1587:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '2') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.6510 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1587:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '2') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.6510 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092307, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-07T15:18:31.6520 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092308, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:31.6530 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092308, CONCURRENCY | WAIT | READ_WRITE)

Statement 1588:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '4') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))
      0 ms

2025-02-07T15:18:31.6530 (13464:0000000000E9D9E8)
 EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092308, CONCURRENCY | WAIT | READ_WRITE)

Statement 1588:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '4') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.7050 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1588:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '4') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.7050 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1588:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '4') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.7060 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092308, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-07T15:18:31.7070 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092309, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:31.7080 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092309, CONCURRENCY | WAIT | READ_WRITE)

Statement 1589:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '6') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))
      0 ms

2025-02-07T15:18:31.7080 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092309, CONCURRENCY | WAIT | READ_WRITE)

Statement 1589:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '6') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.7340 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1589:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '6') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.7340 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1589:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '6') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.7340 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092309, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 fetch(es), 1 mark(s)

2025-02-07T15:18:31.7350 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092310, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:31.7360 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092310, CONCURRENCY | WAIT | READ_WRITE)

Statement 1590:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '7') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))
      0 ms

2025-02-07T15:18:31.7360 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092310, CONCURRENCY | WAIT | READ_WRITE)

Statement 1590:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '7') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.7900 (13464:0000000000E9D9E8) CLOSE_CURSOR
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1590:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '7') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.7900 (13464:0000000000E9D9E8) FREE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616

Statement 1590:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '7') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))

2025-02-07T15:18:31.7900 (13464:0000000000E9D9E8) COMMIT_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092310, CONCURRENCY | WAIT | READ_WRITE)
      0 ms, 1 read(s), 1 fetch(es), 1 mark(s)

2025-02-07T15:18:31.7920 (13464:0000000000E9D9E8) START_TRANSACTION
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092311, CONCURRENCY | WAIT | READ_WRITE)

2025-02-07T15:18:31.7930 (13464:0000000000E9D9E8) PREPARE_STATEMENT
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092311, CONCURRENCY | WAIT | READ_WRITE)

Statement 1591:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '8') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))
      0 ms

2025-02-07T15:18:31.7930 (13464:0000000000E9D9E8) EXECUTE_STATEMENT_START
    C:\SGBR\MASTER\BD\BASESGMASTER.FDB (ATT_219568, SYSDBA:NONE, NONE, XNET:KOCHEM)
    C:\SGBR\Master\GR.exe:14616
        (TRA_34092311, CONCURRENCY | WAIT | READ_WRITE)

Statement 1591:
-------------------------------------------------------------------------------
select 
    sum(coalesce(fp.valorpago,0)) tt 
from 
    tformapagamentonotamanual fp 
left join 
    tnotaconsumidor nm 
on 
    fp.codnotamanual = nm.controle 
where 
    (cast(nm.datafaturada as date) between '02/06/2025' and '02/06/2025') and
    (fp.codespecie = '8') and 
    (nm.codcentrocusto in (select controle from tcentrocusto where centrocusto =  'CENTRO DE CUSTO PADRÃO')) and 
    (nm.cancelado <> 'SIM')
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PLAN (TCENTROCUSTO INDEX (PK_TCENTROCUSTO))
PLAN JOIN (FP INDEX (FK_CODESPECIE), NM INDEX (PK_TNOTACONSUMIDOR))


IBE> Trace session IBE_07/02/2025 15:18:26 terminated.
