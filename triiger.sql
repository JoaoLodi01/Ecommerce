
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                                              +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    Atualização SG Master    +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                                              +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/       

/*------ Release: 0.0.0.1 03/01/2022 13:30:00 --------*/
/*------ SYSDBA 01/07/2024 09:06:00 --------*/
ALTER TABLE TCONFIGNFE ADD GERARAUDITORIAENVIOEMAIL CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR ;

/*------ SYSDBA 01/07/2024 13:42:00 --------*/
ALTER TABLE TCONFIGURACOESGERAIS ADD CALCULARPROMOCAODAV CHAR(1) CHARACTER SET latin1 DEFAULT '1' COLLATE pt_BR; 

/*------ SYSDBA 04/07/2024 09:39:00 --------*/
ALTER TABLE TCONFIGMDFE ADD INFORMACOESADICIONAIS BLOB SUB_TYPE 1 SEGMENT SIZE 80 CHARACTER SET latin1;

/*------ SYSDBA 08/07/2024 08:19:00 --------*/
CREATE INDEX TCAIXA_DHC_CC_IDX ON tcaixa(datahoracadastro, codcentrocusto);

/*------ SYSDBA 08/07/2024 08:34:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TCENTROCUSTO_AU0 FOR TCENTROCUSTO
ACTIVE AFTER UPDATE POSITION 0
AS
begin
  /* Trigger text */
  IF(new.CENTROCUSTO <> old.CENTROCUSTO) THEN
  Begin
      UPDATE TUSUARIO SET CENTROCUSTO = new.CENTROCUSTO WHERE CODCENTROCUSTO = old.CONTROLE;
  end
end

^
SET TERM ; ^

/*------ SYSDBA 10/07/2024 08:10:00 --------*/
ALTER TABLE TCONFIGCOMPRA ADD CARREGARPAGAMENTOXML CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 11/07/2024 10:40:00 --------*/
ALTER TABLE TCONFIGCONDICIONAL ADD AVISARITEMENVIADO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 11/07/2024 10:40:00 --------*/
ALTER TABLE TCONFIGCONDICIONAL ADD DIASAVISO INTEGER DEFAULT '0';

/*------ SYSDBA 11/07/2024 10:40:00 --------*/
ALTER TABLE TITEMOS ADD DESCRICAONFSE BLOB SUB_TYPE 1 SEGMENT SIZE 80;

/*------ SYSDBA 11/07/2024 13:16:00 --------*/
ALTER TABLE TCCE ALTER COLUMN MOTIVO TYPE VARCHAR(1000);

/*------ SYSDBA 15/07/2024 13:16:00 --------*/
ALTER TABLE TCONFIGURACOESGERAIS ADD BLOQUEARDAVABERTO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 15/07/2024 13:16:00 --------*/
ALTER TABLE TCONFIGNFCE ADD UTILIZARSOMDEERRO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 15/07/2024 13:16:00 --------*/
ALTER TABLE TCONFIGCOMANDA ADD AGRUPARCOMANDA CHAR(1) CHARACTER SET latin1 DEFAULT 0 COLLATE PT_BR; 

/*------ SYSDBA 15/07/2024 13:16:00 --------*/
ALTER TABLE TCOMANDA ADD SEMMOVIMENTO VARCHAR(3) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 15/07/2024 13:16:00 --------*/
ALTER TABLE TCOMANDA ADD IDENTIFICADOR VARCHAR(20) CHARACTER SET latin1 COLLATE PT_BR; 

/*------ SYSDBA 15/07/2024 13:16:00 --------*/
ALTER TABLE TCONFIGPEDIDOVENDA ADD SENHADESCONTOMAXIMOITEM CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 16/07/2024 17:48:00 --------*/
ALTER TABLE TCONFIGEMITENTE
ADD SENHAEPHARMA VARCHAR(50) CHARACTER SET latin1 
COLLATE PT_BR;

/*------ SYSDBA 16/07/2024 17:48:00 --------*/
ALTER TABLE TCONFIGEMITENTE
ADD USUARIOEPHARMA VARCHAR(50) CHARACTER SET latin1
COLLATE PT_BR;

/*------ SYSDBA 19/07/2024 13:04:00 --------*/
DROP TABLE TEPHARMCLIENTE;

/*------ SYSDBA 16/07/2024 17:48:00 --------*/
CREATE TABLE TEPHARMACLIENTE (
    CONTROLE INTEGER NOT NULL,
    ID INTEGER NOT NULL,
    NOME VARCHAR(100) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    IDIDENTIFICACAOCARTAO INTEGER NOT NULL,
    NOMEIDENTIFICACAOCARTAO VARCHAR(100) NOT NULL,
    DATAHORACADASTRO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    DATAHORAATUALIZACAO TIMESTAMP
);

/*------ SYSDBA 16/07/2024 17:48:00 --------*/
ALTER TABLE TEPHARMACLIENTE ADD PRIMARY KEY (CONTROLE);

/*------ SYSDBA 16/07/2024 17:48:00 --------*/
CREATE SEQUENCE GEN_CONTROLE_ID;

/*------ SYSDBA 16/07/2024 17:48:00 --------*/
SET TERM ^ ;

CREATE TRIGGER BI_TEPHARMACLIENTE FOR TEPHARMACLIENTE
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.CONTROLE IS NULL) THEN
        NEW.CONTROLE = NEXT VALUE FOR GEN_CONTROLE_ID;
END;

^
SET TERM ; ^

/*------ SYSDBA 16/07/2024 17:48:00 --------*/
SET TERM ^ ;

CREATE TRIGGER BU_TEPHARMACLIENTE FOR TEPHARMACLIENTE
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
    NEW.DATAHORAATUALIZACAO = CURRENT_TIMESTAMP;
END;

^
SET TERM ; ^

/*------ SYSDBA 17/07/2024 17:48:00 --------*/
ALTER TABLE TCOMANDA ADD DATAHORAMOVIMENTOCOMANDA TIMESTAMP;

/*------ SYSDBA 18/07/2024 09:02:00 --------*/
ALTER TABLE TCONFIGURACAO ADD OCULTARQTDEVALORES  CHAR(1) COLLATE PT_BR;

/*------ SYSDBA 18/07/2024 10:12:00 --------*/
ALTER TABLE TPARCELAPREDEFINIDA ADD TIPOJUROS CHAR(1) CHARACTER SET latin1 DEFAULT 'S' COLLATE PT_BR;

/*------ SYSDBA 19/07/2024 14:50:00 --------*/
ALTER TABLE TCONFIGOS ADD DUASVIASLAUDO CHAR (1) COLLATE PT_BR;

/*------ SYSDBA 23/07/2024 09:44:00 --------*/
ALTER TABLE TCONFIGNFCE ADD UTILIZARSOMDECONFIRMACAO CHAR(1) CHARACTER SET latin1 DEFAULT '1' COLLATE PT_BR;

/*------ SYSDBA 23/07/2024 09:44:00 --------*/
UPDATE TCONFIGNFCE SET UTILIZARSOMDECONFIRMACAO = 1 WHERE UTILIZARSOMDECONFIRMACAO IS NULL;

/*------ SYSDBA 23/07/2024 09:59:00 --------*/
CREATE GENERATOR GEN_TCNAE_ID;

/*------ SYSDBA 23/07/2024 09:59:00 --------*/
CREATE TABLE TCNAE (
    CONTROLE   INTEGER NOT NULL,
    CNAE       VARCHAR(7) COLLATE PT_BR,
    DESCRICAO  VARCHAR(200) COLLATE PT_BR
);

/*------ SYSDBA 23/07/2024 09:59:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TCNAE_BI FOR TCNAE
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_tcnae_id,1);
end;

^
SET TERM ; ^

/*------ SYSDBA 26/07/2024 08:07:00 --------*/
ALTER TABLE tconfigos ADD IMPRIMIRREQUISICAO CHAR(1) DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 26/07/2024 15:25:00 --------*/
CREATE OR ALTER VIEW VACOUGUE(
    CONTROLE,
    CODFUNCIONARIO,
    FUNCIONARIO,
    CODPRODUTO,
    PRODUTO,
    PESOTOTAL,
    PRECOKG,
    ANIMAL,
    GRUPO,
    STATUS,
    DATAHORACADASTRO)
AS
select
    taco.controle,
    taco.codfuncionario,
    (Select funcionario from tfuncionario where controle = taco.codfuncionario) as Funcionario,
    taco.codprodutoorigem,
    (Select produto from testoque where controle = taco.codprodutoorigem),
    taco.pesototal,
    taco.precokg,
    case taco.animal
        when 0 then 'BOVINO'
        when 1 then 'SUÍNO'
    end as animal,
    case taco.grupo
        when 0 then 'DIANTEIRO'
        when 1 then 'TRASEIRO'
        when 2 then 'CARCAÇA COMPLETA'
        when 3 then 'TODOS'
    end as grupo,
    case taco.status
        when 0 then 'ABERTO'
        when 1 then 'EM PRODUÇÃO'
        when 2 then 'FINALIZADO'
    end as status,
    taco.datahoracadastro
 from tacouguedesmembramento taco
;

/*------ SYSDBA 30/07/2024 15:25:00 --------*/
ALTER TABLE TCONFIGURACOESGERAIS ADD ABRIRDASHBOARD CHAR (1) COLLATE PT_BR;

/*------ SYSDBA 30/07/2024 15:16:00 --------*/
CREATE GENERATOR GEN_TCONFIGCASHBACK_ID;

/*------ SYSDBA 30/07/2024 15:16:00 --------*/
CREATE TABLE TCONFIGCASHBACK (
    CONTROLE INTEGER NOT NULL,
    MODULOSCASHBACK VARCHAR(30) CHARACTER SET latin1 DEFAULT '1,2,3,4,5,6,7,8' COLLATE PT_BR,
    VALORMINIMOCASHBACK DECIMAL(15,4) DEFAULT 0.0000,
    TIPOCASHBACK CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR,
    VALORCASHBACK DECIMAL(15,4) DEFAULT 0.0000
);

/*------ SYSDBA 30/07/2024 15:16:00 --------*/
ALTER TABLE TCONFIGCASHBACK ADD CONSTRAINT PK_TCONFIGCASHBACK PRIMARY KEY (CONTROLE);

/*------ SYSDBA 30/07/2024 15:16:00 --------*/

SET TERM ^ ;

/* Trigger: TCONFIGCASHBACK_BI0 */
CREATE OR ALTER TRIGGER TCONFIGCASHBACK_BI0 FOR TCONFIGCASHBACK
ACTIVE BEFORE INSERT POSITION 0
as 
begin 
  if (new.controle is null) then 
    new.controle = gen_id(gen_tconfigcashback_id,1);
end

^
SET TERM ; ^


/*------ SYSDBA 01/08/2024 15:16:00 --------*/
ALTER TABLE thistoricocreditocliente
ADD UTILIZADO CHAR(1) DEFAULT '0' COLLATE PT_BR,
ADD CODMODULOUTILIZADO INTEGER,
ADD MODULOUTILIZADO VARCHAR(15) COLLATE PT_BR;

/*------ SYSDBA 09/08/2024 15:16:00 --------*/
CREATE OR ALTER procedure SPATUALIZASTATUSCOMANDA (
    CODCOMANDA integer)
as
declare variable EPEDIDO char(3);
declare variable STATUSMESA varchar(15);
declare variable NUMEROMESA char(10);
declare variable VALORPAGOIMP float;
declare variable VALORPAGODIV float;
declare variable VALORPAGO float;
declare variable VALORTOTAL float;
DECLARE VARIABLE ComandaNaoFinalizada INTEGER;
BEGIN    
    SELECT COALESCE(SUM(CAST(REPLACE(VALORPAGOVARCHAR, ',', '.') AS DECIMAL (15,2)) - cast(VALORTROCO AS DECIMAL (15,2))), 0) FROM TFORMAPAGAMENTOCOMANDA WHERE CODCOMANDA = :CODCOMANDA AND CODDIVISAO IS NULL INTO :VALORPAGO;
    SELECT COALESCE(SUM(FC.VALORPAGO), 0) FROM TMODULODIVISAO MD LEFT JOIN TFORMAPAGAMENTOCOMANDA FC ON FC.CODDIVISAO = MD.CONTROLE WHERE MD.CODCOMANDA = :CODCOMANDA AND FC.CODDIVISAO IS NOT NULL INTO :VALORPAGODIV;
    SELECT COALESCE(SUM(VALORPAGO), 0) FROM TMODULODIVISAO WHERE CODCOMANDA = :CODCOMANDA AND CONTROLE NOT IN(SELECT IIF(CODDIVISAO IS NULL, 0, CODDIVISAO) FROM TFORMAPAGAMENTOCOMANDA WHERE CODCOMANDA = :CODCOMANDA) INTO :VALORPAGOIMP;
    SELECT COALESCE(VALORTOTAL, 0) FROM TCOMANDA WHERE CONTROLE = :CODCOMANDA INTO :VALORTOTAL;
    if (((VALORPAGO + VALORPAGODIV + VALORPAGOIMP) >= VALORTOTAL) or ((VALORPAGO + VALORPAGODIV + VALORPAGOIMP) <= 0.00)) then
    begin
        UPDATE TCOMANDA SET STATUS = 'FINALIZADA', DATAFECHAMENTO = CURRENT_DATE, HORAFECHAMENTO = CURRENT_TIME WHERE CONTROLE = :CODCOMANDA AND STATUS <> 'FINALIZADA';
        SELECT PEDIDO, NUMEROMESA, STATUS FROM TCOMANDA WHERE CONTROLE = :CODCOMANDA
            INTO :EPEDIDO, :NUMEROMESA, :STATUSMESA;
        if ((:STATUSMESA <> 'LIVRE') AND (:EPEDIDO <> 'SIM')) then
        begin
            SELECT COUNT(*) FROM TCOMANDA WHERE NUMEROMESA = :NUMEROMESA AND STATUS <> 'FINALIZADA' INTO :ComandaNaoFinalizada;
            if (:ComandaNaoFinalizada = 0) then
            begin
                UPDATE TMESA SET STATUS = 'LIVRE', DATAMOVIMENTO = NULL, IDENTIFICADOR = NULL, NOMERESERVA = NULL, CODCLIENTE = NULL, VALOR = NULL WHERE NUMEROMESA = :NUMEROMESA;
            end
        end
    END
    
end;


/*------ SYSDBA 05/08/2024 10:51:00 --------*/
CREATE TABLE TANTECIPACAOCARTAO (
    CONTROLE INTEGER NOT NULL PRIMARY KEY,
    CODESPECIE INTEGER NOT NULL,
    TAXAANTECIPACAO DECIMAL(5, 2) NOT NULL,
    DIASCREDITO INTEGER NOT NULL,
    FOREIGN KEY (CODESPECIE) REFERENCES TESPECIE(CONTROLE)
);

/*------ SYSDBA 05/08/2024 10:51:00 --------*/
CREATE SEQUENCE GEN_TANTECIPACAOCARTAO_CONTROLE;

/*------ SYSDBA 05/08/2024 10:51:00 --------*/
SET TERM ^ ;

CREATE TRIGGER BI_TANTECIPACAOCARTAO_CONTROLE FOR TANTECIPACAOCARTAO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.CONTROLE IS NULL) THEN
    NEW.CONTROLE = NEXT VALUE FOR GEN_TANTECIPACAOCARTAO_CONTROLE;
END

^
SET TERM ; ^

/*------ SYSDBA 05/08/2024 10:51:00 --------*/
ALTER TABLE TCAIXA ADD ANTECIPACAO CHAR(1) COLLATE PT_BR;

/*------ SYSDBA 05/08/2024 10:51:00 --------*/
ALTER TABLE TANTECIPACAOCARTAO ADD ESPECIE VARCHAR(50) CHARACTER SET latin1 COLLATE PT_BR; 

/*------ SYSDBA 05/08/2024 17:51:00 --------*/
ALTER TABLE TCONFIGPEDIDOVENDA ADD BLOQALTERAFUNCIONARIOLOGADO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 09/08/2024 15:37:00 --------*/
CREATE OR ALTER procedure SPATUALIZAQTDE (
    SPPECODPRODUTO integer not null)
as
declare variable SPVQTDECOMPRA decimal(15,4);
declare variable SPVQTDEVENDA decimal(15,4);
declare variable SPVVALORTOTALCOMPRADO decimal(15,4);
declare variable SPVCUSTOULTIMACOMPRA decimal(15,4);
declare variable SPVQTDEEMPEDIDOVENDA decimal(15,4);
declare variable SPVQTDEEMPEDIDOCOMPRA decimal(15,4);
declare variable SPVQTDERESERVADA decimal(15,4);
declare variable SPVQTDERESERVADA2 decimal(15,4);
declare variable SPVQTDEEMPRODUCAOPRODUTOFINAL decimal(15,4);
declare variable SPVQTDEEMPRODUCAOMP decimal(15,4);
declare variable SPVATUALIZARESTOQUE varchar(3);
declare variable SPQTDEAPURADA decimal(15,4);
declare variable SPVRESERVARPRODUTOS varchar(3);
declare variable SPVQTDERESERVADA3 decimal(15,4);
begin
        select Atualizarestoque, RESERVARPRODALUGUELCONDI from temitente
            into :spvatualizarestoque, :spvreservarprodutos;
        if (spvatualizarestoque = 'SIM') then
        begin
            select sum(coalesce(coalesce(QTDE,0),0)) from titemopcomposicao
                where CODPRODUTO  = :sppecodproduto and situacao <> 'FINALIZADA'
                into :spvqtdeemproducaomp;
            if (spvqtdeemproducaomp is null) then
                spvqtdeemproducaomp = 0;
            select sum(coalesce(coalesce(QTDE,0),0)) from titemordemproducao where situacao <> 'FINALIZADA'
                and codproduto = :sppecodproduto
                into :spvqtdeemproducaoprodutofinal;
            if (spvqtdeemproducaoprodutofinal is null) then
                spvqtdeemproducaoprodutofinal = 0;
            select sum(coalesce(coalesce(quantidade,0),0)) from titempedidocompra
                where CODPRODUTO  = :sppecodproduto and situacaopedido <> 'FINALIZADO'
                into :spvqtdeempedidocompra;
            if (spvqtdeempedidocompra is null) then
                spvqtdeempedidocompra = 0;
            select SUM(coalesce(coalesce(quantidade,0),0)) ttqtde from titemos
             where codservico = :sppecodproduto and (coalesce(situacao,'') <> 'FINALIZADA' and coalesce(situacao,'') <> 'CANCELADA') and reservarproduto = 'SIM'
            into :spvqtdereservada;

            if (spvreservarprodutos = 'SIM') then
            begin
               select sum(ttqtde) from (
               select coalesce(coalesce(qtde,0),0) ttqtde from titemcondicional icn inner join tcondicional cnd on icn.codcondicional = cnd.controle
                   where codproduto = :sppecodproduto and (icn.cancelado <> 'S') and (icn.devolvido <> 'SIM') and ((cnd.Situacao <> 'FINALIZADO') AND (cnd.Situacao <> 'DEVOLVIDO'))
               UNION ALL
               select coalesce(coalesce(qtde,0),0) ttqtde from titemaluguel
                   where codproduto = :sppecodproduto and (coalesce(status,'') <> 'DEVOLVIDO') and (cancelado <> 'S'))
                   into :spvqtdereservada2;
            end
            select coalesce(sum(ttqtde),0) as qtdereservada from (
            select coalesce(coalesce(qtdecomercial,0),0)  ttqtde from titensvendanfe inf inner join tvendanfe ven on inf.codnfe = ven.controle
                inner join toperacao top on ven.codoperacao = top.controle
            where top.reservaritensestoque = '1' and inf.codproduto = cast(:sppecodproduto as varchar(20)) and inf.reservaritem = 'SIM' and inf.tipooperacao = '1' and inf.enviada = 'SIM'
            and inf.cancelado <> 'SIM' and inf.codaplicacaoproduto <> '09' and inf.ambiente = '1'
                ) into :spvqtdereservada3;

            if (spvqtdereservada is null) then
                spvqtdereservada = 0;
            if (spvqtdereservada2 is null) then
                spvqtdereservada2 = 0;

            select sum(coalesce(coalesce(QTDE,0),0)) from titempedidovenda ip Inner join tpedidovenda p on ip.codpedidovenda = p.controle
                where ip.codproduto = :sppecodproduto and p.status = 'ABERTO' and ip.cancelado = 'N'
                into :spvqtdeempedidovenda;
            if (spvqtdeempedidovenda is null) then
                spvqtdeempedidovenda = 0;

            select
                /* QUANTIDADE TOTAL COMPRADA */
                coalesce((select sum(qtde) as qtde
                            from
                                titemcompra ic
                            where
                                ic.codproduto = est.controle and
                                ic.confirmado= 'SIM' and
                                ic.TIPOOPERACAO = '0' and
                                ic.movimentaestoque = 'SIM'),0) qtde_comprada,
                /* QUANTIDADE TOTAL VENDIDA */
                /* VENDA ECF */
                (coalesce((select sum(qtde) as qtde
                           from
                             titemvendaecf iec
                           where
                            iec.codproduto = est.controle  and
                            iec.cancelado <> 'SIM' and
                            iec.codaplicacaoproduto <> '09'),0)
                +     /* NFE SAÍDA */
                coalesce((select sum(qtdecomercial) as qtde
                          from
                            titensvendanfe inf
                          where
                            inf.codproduto = cast(est.controle as varchar(20)) and
                            inf.TIPOOPERACAO = '1' and
                            inf.enviada  = 'SIM' and
                            inf.cancelado <> 'SIM' and
                            inf.rejeitada <> 'SIM' and
                            inf.movimentaestoque = 'SIM' and
                            inf.codaplicacaoproduto <> '09' and
                            inf.ambiente = '1'),0)
                +     /* VENDA NFCE */
                coalesce((select sum(qtde) as qtde
                          from
                            titemvendanfce infc
                          where
                            infc.codproduto = est.controle and
                            infc.cancelado <> 'SIM' and
                            infc.codaplicacaoproduto <> '09' and
                            infc.enviada = 'SIM' and
                            infc.ambiente = '1'),0)
                +     /* VENDA NOTA MANUAL */
                coalesce((select sum(qtde) as qtde
                          from
                            TITENNOTACONSUMIDOR inc
                          where
                            inc.codproduto = est.controle and
                            inc.cancelado <> 'SIM' and
                            inc.codaplicacaoproduto <> '09' and
                            inc.confirmado = 'SIM'),0)
                -     /* NFE ENTRADA */
                coalesce((select sum(qtdecomercial) as qtde
                          from
                            titensvendanfe inf
                          where
                            inf.codproduto = cast(est.controle as varchar(20)) and
                            inf.TIPOOPERACAO = '0' and
                            inf.enviada  = 'SIM' and
                            inf.cancelado <> 'SIM' and
                            inf.movimentaestoque = 'SIM' and
                            inf.codaplicacaoproduto <> '09' and
                            inf.ambiente = '1'),0)) qtde_vendida,

                /* QUANTIDADE TOTAL NO ESTOQUE*/
                cast(coalesce(est.qtdeinicial,0) as numeric(15,4))
                +     /* COMPRA */
                (coalesce((select sum(qtde) as qtde
                            from
                                titemcompra ic
                            where
                                ic.codproduto = est.controle and
                                ic.confirmado= 'SIM' and
                                ic.TIPOOPERACAO = '0' and
                                ic.movimentaestoque = 'SIM'),0)
                -     /* VENDA ECF */
                coalesce((select sum(qtde) as qtde
                           from
                             titemvendaecf iec
                           where
                            iec.codproduto = est.controle  and
                            iec.cancelado <> 'SIM' and
                            iec.codaplicacaoproduto <> '09'),0)
                -     /* NFE SAÍDA */
                coalesce((select sum(qtdecomercial) as qtde
                          from
                            titensvendanfe inf
                          where
                            inf.codproduto = cast(est.controle as varchar(20)) and
                            inf.TIPOOPERACAO = '1' and
                            inf.enviada  = 'SIM' and
                            inf.cancelado <> 'SIM' and
                            inf.rejeitada <> 'SIM' and
                            inf.movimentaestoque = 'SIM' and
                            inf.codaplicacaoproduto <> '09' and
                            inf.ambiente = '1'),0)
                -     /* VENDA NFCE */
                coalesce((select sum(qtde) as qtde
                          from
                            titemvendanfce infc
                          where
                            infc.codproduto = est.controle and
                            infc.cancelado <> 'SIM' and
                            infc.codaplicacaoproduto <> '09' and
                            infc.enviada = 'SIM' and
                            infc.ambiente = '1'),0)
                -     /* VENDA NOTA MANUAL */
                coalesce((select sum(qtde) as qtde
                          from
                            TITENNOTACONSUMIDOR inc
                          where
                            inc.codproduto = est.controle and
                            inc.cancelado <> 'SIM' and
                            inc.codaplicacaoproduto <> '09' and
                            inc.confirmado = 'SIM'),0)
                +     /* NFE ENTRADA */
                coalesce((select sum(qtdecomercial) as qtde
                          from
                            titensvendanfe inf
                          where
                            inf.codproduto = cast(est.controle as varchar(20)) and
                            inf.TIPOOPERACAO = '0' and
                            inf.enviada  = 'SIM' and
                            inf.cancelado <> 'SIM' and
                            inf.movimentaestoque = 'SIM' and
                            inf.codaplicacaoproduto <> '09' and
                            inf.ambiente = '1'),0)
                +     /* ORDEM PRODUCAO - PF */
                coalesce((select sum(qtde) as qtde
                          from
                            titemordemproducao io
                          where
                            io.codproduto = est.controle and
                            io.situacao = 'FINALIZADA'),0)
                -     /* ORDEM PRODUCAO - MP */
                coalesce((select sum(qtde) as qtde
                          from
                            titemopcomposicao iomp
                          where
                            iomp.codproduto  = est.controle and
                            est.codaplicacaoproduto <> '09' and
                            situacao = 'FINALIZADA'),0)
                +     /* QTDE AJUSTE */
                coalesce((select sum(qtdealterada) as qtde
                          from
                            tajusteestoque aj
                          where
                            aj.codproduto = est.controle),0)
                ) qtde_apuracao
            
            from
                testoque est
            where
                controle = :sppecodproduto
            into :spvqtdecompra, :spvqtdevenda, :spqtdeapurada;

            /*  */
            if (spvqtdecompra > 0) then
            begin
                select first 1 valorunitario from titemcompra where codproduto = :sppecodproduto and confirmado = 'SIM' order by controle desc
                    into :spvcustoultimacompra;
                update testoque set custoultimacompra = :spvcustoultimacompra where controle = :sppecodproduto;
                select sum(coalesce(coalesce(valortotal,0),0)) as totamcompradoitem from titemcompra where codproduto = :sppecodproduto and confirmado = 'SIM'
                    into :spvvalortotalcomprado;
            end

            update testoque set QTDEPEDIDOCOMPRA = :spvqtdeempedidocompra where CONTROLE = :sppecodproduto;
            update testoque set qtdepedidovenda = :spvqtdeempedidovenda where CONTROLE = :sppecodproduto;
            update testoque set qtdeemproducao = :spvqtdeemproducaoprodutofinal where CONTROLE = :sppecodproduto;
            update testoque set qtdeemproducaoMP = :spvqtdeemproducaomp where CONTROLE = :sppecodproduto;
            update testoque set qtdereservada = :spvqtdereservada + :spvqtdereservada2 + :spvqtdereservada3 where CONTROLE = :sppecodproduto;
            update testoque set CUSTOMEDIO = :spvvalortotalcomprado / :spvqtdecompra where controle = :sppecodproduto;
            update testoque set qtdetotalcomprada = :spvqtdecompra where CONTROLE = :sppecodproduto;
            update testoque set qtdetotalvendida = :spvqtdevenda where CONTROLE = :sppecodproduto;
            update testoque set qtde = :spqtdeapurada where controle = :sppecodproduto;

            update TESTOQUE set qtdereal = coalesce(testoque.qtde,0) +
                                           :spvqtdeempedidocompra -
                                           :spvqtdeemproducaomp +
                                           :spvqtdeemproducaoprodutofinal -
                                           :spvqtdereservada -
                                           :spvqtdereservada2 -
                                           :spvqtdeempedidovenda -
                                           :spvqtdereservada3
                where CONTROLE = :sppecodproduto;
         end
end;

/*------ SYSDBA 10/06/2024 12:48:00 --------*/
ALTER TABLE TCONFIGNFE ADD ATTXMLCANCELADO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR; 

/*------ SYSDBA 15/08/2024 09:06:00 --------*/
ALTER TABLE TCONFIGURACOESGERAIS ADD ANTECIPACAOCARTAO CHAR(1) CHARACTER SET latin1 COLLATE PT_BR; 

/*------ SYSDBA 16/08/2024 16:54:00 --------*/
CREATE GENERATOR GEN_TCONFERENCIAFECHAMENTOCAIXA;

/*------ SYSDBA 16/08/2024 16:54:00 --------*/
CREATE TABLE TCONFERENCIAFECHAMENTOCAIXA (
    CONTROLE            INTEGER NOT NULL,
    CODCENTROCUSTO      INTEGER NOT NULL,
    CENTROCUSTO         VARCHAR(100) COLLATE PT_BR,
    CODFUNCIONARIO      INTEGER NOT NULL,
    FUNCIONARIO         VARCHAR(100) COLLATE PT_BR,
    ESPECIE             VARCHAR(50) COLLATE PT_BR,
    VALORRECEBIDO       DECIMAL(15,4),
    VALORFECHAMENTO     DECIMAL(15,4),
    VALORDIFERENCA      DECIMAL(15,4),
    DATAHORAFECHAMENTO  TIMESTAMP NOT NULL
);

/*------ SYSDBA 16/08/2024 16:54:00 --------*/
ALTER TABLE TCONFERENCIAFECHAMENTOCAIXA ADD CONSTRAINT PK_TCONFERENCIAFECHAMENTOCAIXA PRIMARY KEY (CONTROLE);

/*------ SYSDBA 16/08/2024 16:54:00 --------*/
SET TERM ^ ;

/* Trigger: TCONFERENCIAFECHAMENTOCAIXA_BI */
CREATE OR ALTER TRIGGER TCONFERENCIAFECHAMENTOCAIXA_BI FOR TCONFERENCIAFECHAMENTOCAIXA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_tconferenciafechamentocaixa,1);
end
^


SET TERM ; ^

/*------ SYSDBA 16/08/2024 17:11:00 --------*/
ALTER TABLE TCONFIGNFCE ADD LANCARPRODUTOSPESADOAUTOMATICO CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 16/08/2024 17:24:00 --------*/
ALTER TABLE TCONFIGNFCE ADD TEMPOESPERA VARCHAR(1) CHARACTER SET latin1 DEFAULT '3' COLLATE PT_BR;

/*------ SYSDBA 16/08/2024 17:27:00 --------*/
ALTER TABLE TCONFIGNOTAMANUAL ADD LANCARPRODUTOSPESADOAUTOMATICO CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 16/08/2024 17:27:00 --------*/
ALTER TABLE TCONFIGNOTAMANUAL ADD TEMPOESPERA VARCHAR(1) CHARACTER SET latin1 DEFAULT '3' COLLATE PT_BR;

/*------ SYSDBA 19/08/2024 07:43:00 --------*/
ALTER TABLE TCONFIGPEDIDOVENDA ADD IMPRIMIRENTREGACLIENTE CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 19/08/2024 07:43:00 --------*/
update tconfigpedidovenda set imprimirentregacliente = 1 where imprimirentregacliente is null;

/*------ SYSDBA 19/08/2024 07:43:00 --------*/
ALTER TABLE TITEMCONDICIONAL ADD CODBARRASINTERNO VARCHAR(100) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 23/08/2024 09:25:00 --------*/
CREATE OR ALTER procedure SPATUALIZADATAVENDACOMPRA (
    SPPECODFORNECEDOR integer,
    SPPECODCLIENTE integer)
as
declare variable DATAVENDA date;
begin
    if (sppecodcliente IS NOT NULL) then
    begin
       SELECT
          MAX(DT_VENDA) AS DATA
          FROM
            (SELECT
                MAX(NFE.DATAEMISSAO) DT_VENDA
             FROM
                TVENDANFE NFE
             WHERE
                NFE.CODCLIENTE = :SPPECODCLIENTE AND
                NFE.PROTOCOLO IS NOT NULL AND
                NFE.PROTOCOLOCANCELAMENTO IS NULL AND
                NFE.TIPOOPERACAO = '1'
             UNION
             SELECT
                MAX(NFCE.DATAEMISSAO) DT_VENDA
             FROM
                TVENDANFCE NFCE
             WHERE
                NFCE.CODCLIENTE = :SPPECODCLIENTE AND
                NFCE.PROTOCOLO IS NOT NULL AND
                NFCE.PROTOCOLOCANCELAMENTO IS NULL AND
                NFCE.SAT = 'NÃO'
             UNION
             SELECT
                MAX(SAT.DATAEMISSAO) DT_VENDA
             FROM
                TVENDANFCE SAT
             WHERE
                SAT.CODCLIENTE = :SPPECODCLIENTE AND
                SAT.SAT = 'SIM' AND
                SAT.CODIGOSTATUS = '6000'
             UNION
             SELECT
                MAX(ECF.DATAEMISSAOECF) DT_VENDA
             FROM
                TVENDAECF ECF
             WHERE
                ECF.CODCLIENTE = :SPPECODCLIENTE AND
                ECF.cancelado <> 'SIM'
             UNION
             SELECT
                MAX(NM.DATAEMISSAO) DT_VENDA
             FROM
                TNOTACONSUMIDOR NM
             WHERE
                NM.CODCLIENTE = :SPPECODCLIENTE AND
                ((NM.DATAFATURADA IS NOT NULL) or (NM.JAFATURADA = 'NÃO')) AND
                NM.CANCELADO <> 'SIM'
                ) INTO :DATAVENDA;
       update tcliente set dataultimavenda  = :DATAVENDA where controle = :sppecodcliente;
    end
end;

/*------ SYSDBA 28/08/2024 13:23:00 --------*/
ALTER TABLE TCLIENTE ADD ALIQUOTAICMS NUMERIC(15,2);

/*------ SYSDBA 29/08/2024 10:04:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TEMITENTE_AUAUDIT FOR TEMITENTE
ACTIVE AFTER UPDATE POSITION 0
AS
begin
    if ((new.NOMEFANTASIA <> old.NOMEFANTASIA) or
        (new.RAZAOSOCIAL <> old.RAZAOSOCIAL) or
        (new.CPF <> old.CPF) or
        (new.CNPJ <> new.CNPJ) or        
        (new.ENDERECO <> old.ENDERECO) or 
        (new.BAIRRO <> old.BAIRRO) or         
        (new.CEP <> old.CEP) or
        (new.TELEFONE <> old.TELEFONE) or
        (new.CELULAR <> old.CELULAR) or
        ((new.CONTROLESG <> old.CONTROLESG) and (old.CONTROLESG <> '')))
    then
    begin
        execute procedure spauditoria(new.CONTROLE,
                             'TEMITENTE', 
                             new.DATAHORACADASTRO, 
                             'Informações alteradas: ' ||
                             iif((new.RAZAOSOCIAL <> old.RAZAOSOCIAL),   (' Razão social: ' ||coalesce(new.RAZAOSOCIAL, '')), '')||
                             iif((new.NOMEFANTASIA <> old.NOMEFANTASIA), (' Fantasia: '     ||coalesce(new.NOMEFANTASIA,'')),'')||
                             iif((new.CNPJ <> old.CNPJ),                 (' CNPJ: '         ||coalesce(new.CNPJ,'')), '')||
                             iif((new.CPF <> old.CPF),                   (' CPF: '          ||coalesce(new.CPF,'')), '')||
                             iif((new.ENDERECO <> old.ENDERECO),         (' Endereço: '     ||coalesce(new.ENDERECO,'')), '')||
                             iif((new.BAIRRO <> old.BAIRRO),             (' Bairro: '       ||coalesce(new.BAIRRO,'')), '')||
                             iif((new.CEP <> old.CEP),                   (' CEP: '          ||coalesce(new.CEP,'')), '')||
                             iif((new.TELEFONE <> old.TELEFONE),         (' Telefone: '     ||coalesce(new.TELEFONE,'')), '')||
                             iif((new.CELULAR <> old.CELULAR),           (' Celular: '      ||coalesce(new.CELULAR,'')), '')||
                             iif((new.CONTROLESG <> old.CONTROLESG),     (' ControleSG: '   ||coalesce(new.CONTROLESG, '')), ''));
    end
end
^
SET TERM ; ^

/*------ SYSDBA 30/08/2024 09:21:00 --------*/
ALTER TABLE TCONFIGNFCE ADD IMPRIMENFCE CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 30/08/2024 09:21:00 --------*/
ALTER TABLE TCONFIGNFCE ADD IMPRIMEPIX CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 02/09/2024 08:25:00 --------*/
ALTER TABLE TCONFIGURACOESGERAIS ADD NUMEROVIASTEF INTEGER;

/*------ SYSDBA 02/09/2024 14:50:00 --------*/
ALTER TABLE TUSUARIO ADD OCULTARCOLUNAS CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR; 

/*------ SYSDBA 02/09/2024 14:50:00 --------*/
ALTER TABLE TUSUARIO ADD COLUNASOCULTADAS VARCHAR(20) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 03/09/2024 09:20:00 --------*/
ALTER TABLE TCONFIGURACAO ADD EMAILHTML BLOB SUB_TYPE 1 SEGMENT SIZE 80 CHARACTER SET UTF8;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TFORMAPAGAMENTOOS ADD ADIANTAMENTO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TCONFIGOS ADD MODELOIMPRESSAOOFICINA CHAR(1) COLLATE PT_BR;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TCONFIGOS ADD EXIGIROBJETO CHAR(1) DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE GENERATOR GEN_TOFICINALOCALIZACAOVEICULO_;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE TABLE TOFICINALOCALIZACAOVEICULO (
    CONTROLE          INTEGER NOT NULL,
    LOCALIZACAO       VARCHAR(50),
    DATAHORACADASTRO  TIMESTAMP
);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TOFICINALOCALIZACAOVEICULO ADD CONSTRAINT PK_TOFICINALOCALIZACAOVEICULO PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TOFICINALOCALIZACAOVEICULO_BI FOR TOFICINALOCALIZACAOVEICULO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_toficinalocalizacaoveiculo_,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TESTOQUE ADD AGENDARSERVICO CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TESTOQUE ADD DIASAGENDAMENTO VARCHAR(5) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TESTOQUE ADD CODPRODUTOSIMILAR INTEGER;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER procedure SPTOTALIZAOS (
    SPCONTROLEOS integer)
as
declare variable SPVALORVENDA decimal(15,2);
begin
    Select Sum((valorunitario * quantidade) - desconto) from titemos
    where
        codos = :spcontroleos and Status <> 'REJEITADO'

    and
        cancelada <> 'SIM'
    into
        spvalorvenda;
    Update tos os set
        valortotal =    coalesce(:spvalorvenda,0)
                        -
                        coalesce(totaldesconto,0)
                        +
                        coalesce(totalacrescimo,0)
    where
        controle = :spcontroleos;
end

^
SET TERM ; ^

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE GENERATOR GEN_TANEXOOS_ID;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE TABLE TANEXOOS (
    CONTROLE           INTEGER NOT NULL,
    CODOS              INTEGER,
    ANEXOLOCAL         VARCHAR(200),
    ANEXOFTP           VARCHAR(50),
    DATAEHORACADASTRO  TIMESTAMP
);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TANEXOOS ADD CONSTRAINT PK_TANEXOOS PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TANEXOOS_BI FOR TANEXOOS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_tanexoos_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE SEQUENCE GEN_THISTORICOOS_ID;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE TABLE THISTORICOOS (
    CONTROLE        INTEGER NOT NULL,
    CODOPERADOR     INTEGER,
    CODOS           INTEGER NOT NULL,
    SITUACAOANTIGA  VARCHAR(100),
    SITUACAONOVA    VARCHAR(100),
    DATAALTERACAO   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE THISTORICOOS ADD CONSTRAINT PK_THISTORICOOS PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER THISTORICOOS_BI FOR THISTORICOOS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(GEN_THISTORICOOS_ID,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER trigger tos_criahistoricoos for tos
active after update position 0
AS
BEGIN
  IF (NEW.situacao <> OLD.situacao) THEN
  BEGIN
      INSERT INTO THISTORICOOS (CODOS, SITUACAOANTIGA, SITUACAONOVA)
      VALUES (NEW.CONTROLE, OLD.SITUACAO, NEW.SITUACAO);
  END
END

^
SET TERM ; ^

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE GENERATOR GEN_TOSCHECKLIST_ID;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE TABLE TOSCHECKLIST (
    CONTROLE INTEGER NOT NULL,
    CODOS INTEGER NOT NULL,
    CODCHECKLIST INTEGER NOT NULL,
    DESCRICAOCHECKLIST VARCHAR (100),
    CODSUBCHECKLIST INTEGER,
    DESCRICAOSUBCHECKLIST VARCHAR (35),
    CONFIRMADO CHAR (1),
    OBS BLOB SUB_TYPE 1 SEGMENT SIZE 5000,
    DATAEHORACADASTRO TIMESTAMP
);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TOSCHECKLIST ADD CONSTRAINT PK_TOSCHECKLIST PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TOSCHECKLIST FOR TOSCHECKLIST
ACTIVE BEFORE INSERT POSITION 0
as
begin
if (new.controle is null) then
    new.controle = gen_id(gen_toschecklist_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE GENERATOR GEN_TOFICINACHECKLIST_ID;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE TABLE TOFICINACHECKLIST (
    CONTROLE            INTEGER NOT NULL,
    CODPRODUTO          INTEGER,
    PRODUTO             VARCHAR(100),
    DESCRICAO           VARCHAR(30),
    UTILIZANAIMPRESSAO  CHAR(1),
    DATAEHORACADASTRO   TIMESTAMP
);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TOFICINACHECKLIST ADD CONSTRAINT PK_TOFICINACHECKLIST PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TOFICINACHECKLIST_BI FOR TOFICINACHECKLIST
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_toficinachecklist_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE GENERATOR GEN_TOFICINAITEMCHECKLIST_ID;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE TABLE TOFICINAITEMCHECKLIST (
    CONTROLE      INTEGER NOT NULL,
    CODCHECKLIST  INTEGER NOT NULL,
    DESCRICAO     VARCHAR(35),
    DATAEHORACADASTRO     TIMESTAMP
);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TOFICINAITEMCHECKLIST ADD CONSTRAINT PK_TOFICINAITEMCHECKLIST PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TOFICINAITEMCHECKLIST_BI FOR TOFICINAITEMCHECKLIST
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_toficinaitemchecklist_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE GENERATOR GEN_TOFICINAVEICULO_ID;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE TABLE TOFICINAVEICULO (
    CONTROLE             INTEGER NOT NULL,
    CODPROPRIETARIO      INTEGER NOT NULL,
    PROPRIETARIO         VARCHAR(100),
    MARCA                VARCHAR(50),
    MODELO               VARCHAR(100),
    ATIVO                CHAR(1),
    PLACA                VARCHAR(8),
    CATEGORIA            VARCHAR(20),
    COR                  VARCHAR(25),
    ANOMODELOFABRICACAO  VARCHAR(4),
    ANOFABRICACAO        INTEGER,
    TIPOCOMBUSTIVEL      VARCHAR(30),
    CHASSI               VARCHAR(17),
    QUILOMETRAGEM        VARCHAR(10),
    OBS                  BLOB SUB_TYPE 1 SEGMENT SIZE 5000,
    DATAEHORACADASTRO    TIMESTAMP,
    POTENCIA             VARCHAR(10) COLLATE PT_BR
);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TOFICINAVEICULO ADD CONSTRAINT PK_TOFICINAVEICULO PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TOFICINAVEICULO_BI FOR TOFICINAVEICULO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_toficinaveiculo_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE GENERATOR GEN_TOFICINAIMAGEMVEICULO_ID;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE TABLE TOFICINAIMAGEMVEICULO (
    CONTROLE           INTEGER NOT NULL,
    CODVEICULO         INTEGER NOT NULL,
    IMAGEMLOCAL        VARCHAR(200),
    IMAGEMFTP          VARCHAR(50),
    DATAEHORACADASTRO  TIMESTAMP
);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TOFICINAIMAGEMVEICULO ADD CONSTRAINT PK_TOFICINAIMAGEMVEICULO PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TOFICINAIMAGEMVEICULO_BI FOR TOFICINAIMAGEMVEICULO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_toficinaimagemveiculo_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE GENERATOR GEN_TOSOFICINA_ID;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
CREATE TABLE TOSOFICINA (
    CONTROLE               INTEGER NOT NULL,
    CODVEICULOOFICINA      INTEGER,
    CODOS                  INTEGER NOT NULL,
    PERCTANQUECOMBUSTIVEL  INTEGER,
    LOCALIZACAOVEICULO     VARCHAR(50) COLLATE PT_BR
);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TOSOFICINA ADD CONSTRAINT PK_TOSOFICINA PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TOSOFICINA_BI FOR TOSOFICINA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_tosoficina_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TAGENDAMENTOOS ADD CODVEICULO INTEGER;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TOSOFICINA ADD CONSTRAINT FK_TOSOFICINA_1 FOREIGN KEY (CODOS) REFERENCES TOS (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TANEXOOS ADD CONSTRAINT FK_TANEXOOS_1 FOREIGN KEY (CODOS) REFERENCES TOS (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE THISTORICOOS ADD CONSTRAINT FK_THISTORICOOS_1 FOREIGN KEY (CODOS) REFERENCES TOS (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TOSCHECKLIST ADD CONSTRAINT FK_TOSCHECKLIST_1 FOREIGN KEY (CODOS) REFERENCES TOS (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TOFICINAITEMCHECKLIST ADD CONSTRAINT FK_TOFICINAITEMCHECKLIST_1 FOREIGN KEY (CODCHECKLIST) REFERENCES TOFICINACHECKLIST (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TOFICINAIMAGEMVEICULO ADD CONSTRAINT FK_TOFICINAIMAGEMVEICULO_1 FOREIGN KEY (CODVEICULO) REFERENCES TOFICINAVEICULO (CONTROLE);

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
ALTER TABLE TCONFIGCONDICIONAL ADD IMPRIMIRITENSDEVOLVIDOS CHAR(1) CHARACTER SET latin1 DEFAULT '1' COLLATE PT_BR;

/*------ SYSDBA 04/09/2024 10:00:00 --------*/
UPDATE TCONFIGCONDICIONAL SET IMPRIMIRITENSDEVOLVIDOS = '1' WHERE IMPRIMIRITENSDEVOLVIDOS IS NULL;

/*------ SYSDBA 04/09/2024 14:25:00 --------*/
SET TERM ^ ;

CREATE OR ALTER procedure SPTOTALIZAOS (
    SPCONTROLEOS integer)
as
declare variable SPVALORVENDA decimal(15,2);
begin
    Select Sum((valorunitario * quantidade) - desconto) from titemos
    where
        codos = :spcontroleos and (Status <> 'REJEITADO' or Status is null)
    and
        cancelada <> 'SIM'
    into
        spvalorvenda;
    Update tos os set
        valortotal =    coalesce(:spvalorvenda,0)
                        -
                        coalesce(totaldesconto,0)
                        +
                        coalesce(totalacrescimo,0)
    where
        controle = :spcontroleos;
end

^
SET TERM ; ^

/*------ SYSDBA 05/09/2024 08:15:00 --------*/
CREATE GENERATOR GEN_TSEGURADORA_ID;

/*------ SYSDBA 05/09/2024 08:15:00 --------*/
CREATE TABLE TSEGURADORA (
    CONTROLE           INTEGER NOT NULL,
    SEGURADORA         VARCHAR(100) COLLATE PT_BR,
    RESPONSAVELSEGURO  CHAR(1) COLLATE PT_BR,
    CNPJSEGURADORA     VARCHAR(14) COLLATE PT_BR,
    NROAPOLICE         VARCHAR(20) COLLATE PT_BR,
    NROAVERBACAO       VARCHAR(20) COLLATE PT_BR,
    DATAHORACADASTRO   TIMESTAMP
);

/*------ SYSDBA 05/09/2024 08:15:00 --------*/
ALTER TABLE TSEGURADORA ADD CONSTRAINT PK_TSEGURADORA PRIMARY KEY (CONTROLE);

/*------ SYSDBA 05/09/2024 08:15:00 --------*/
SET TERM ^ ;

/* Trigger: TSEGURADORA_BI */
CREATE OR ALTER TRIGGER TSEGURADORA_BI FOR TSEGURADORA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(GEN_TSEGURADORA_ID,1);
end

^
SET TERM ; ^

/*------ SYSDBA 05/09/2024 08:15:00 --------*/
ALTER TABLE TCONFIGNFCE ADD SOLICITAREMISSAOCOBRANCA CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 06/09/2024 08:15:00 --------*/
ALTER TABLE TPARCELAPREDEFINIDAINTERVALO ADD JUROSPARCELA DECIMAL(15,2) DEFAULT 0;

/*------ SYSDBA 09/09/2024 09:10:00 --------*/
ALTER TABLE TCONFIGCONDICIONAL ADD IMPRESSAOGRADE CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 11/09/2024 08:00:00 --------*/
UPDATE TPARCELAPREDEFINIDA SET TIPOJUROS = 'S' WHERE TIPOJUROS IS NULL;

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
CREATE GENERATOR GEN_TPARCELAMENTODAV_ID;

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
CREATE TABLE TPARCELAMENTODAV (
    CONTROLE   INTEGER NOT NULL,
    MODULO  VARCHAR(100) CHARACTER SET latin1 COLLATE PT_BR,
    CODORCAMENTO INTEGER,
    CODPEDIDOVENDA INTEGER,
    CODCONDICIONAL INTEGER,
    CODPREVENDA INTEGER,
    CODESPECIE INTEGER,
    ESPECIE VARCHAR(100) CHARACTER SET latin1 COLLATE PT_BR,
    CODPLANOCONTA INTEGER,
    PLANOCONTA VARCHAR(100) CHARACTER SET latin1 COLLATE PT_BR,
    VALOR DECIMAL(15,4) DEFAULT 0.0000,
    QTDEPARCELA INTEGER,
    NPARCELA INTEGER,
    DIAPARARECEBIMENTO INTEGER,
    DATAVENCIMENTO DATE,
    VALORDAV DECIMAL(15,4) DEFAULT 0.0000,
    CODMODULOVENDA INTEGER,
    MODULOVENDA VARCHAR(50) CHARACTER SET latin1 COLLATE PT_BR
);

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
ALTER TABLE TPARCELAMENTODAV ADD CONSTRAINT PK_TPARCELAMENTODAV PRIMARY KEY (CONTROLE);

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
ALTER TABLE TPARCELAMENTODAV ADD CONSTRAINT FK_TPARCELAMENTODAV_PEDIDOVENDA FOREIGN KEY (CODPEDIDOVENDA) REFERENCES TPEDIDOVENDA (CONTROLE);

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
ALTER TABLE TPARCELAMENTODAV ADD CONSTRAINT FK_TPARCELAMENTODAV_ORCAMENTO FOREIGN KEY (CODORCAMENTO) REFERENCES TORCAMENTO (CONTROLE);

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
ALTER TABLE TPARCELAMENTODAV ADD CONSTRAINT FK_TPARCELAMENTODAV_CONDICIONAL FOREIGN KEY (CODCONDICIONAL) REFERENCES TCONDICIONAL (CONTROLE);

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
ALTER TABLE TPARCELAMENTODAV ADD CONSTRAINT FK_TPARCELAMENTODAV_PREVENDA FOREIGN KEY (CODPREVENDA) REFERENCES TPREVENDA (CONTROLE);

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
SET TERM ^ ;

/* Trigger: TPARCELAMENTODAV_BI */
CREATE OR ALTER TRIGGER TPARCELAMENTODAV_BI0 FOR TPARCELAMENTODAV
ACTIVE BEFORE INSERT POSITION 0
as 
begin 
  if (new.controle is null) then 
    new.controle = gen_id(gen_tparcelamentodav_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
ALTER TABLE TCONFIGPEDIDOVENDA ADD DEFINIRPARCELAMENTODAV CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
ALTER TABLE TCONFIGCONDICIONAL ADD DEFINIRPARCELAMENTODAV CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
ALTER TABLE TCONFIGORCAMENTO ADD DEFINIRPARCELAMENTODAV CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
ALTER TABLE TCONFIGPREVENDA ADD DEFINIRPARCELAMENTODAV CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
CREATE GENERATOR GEN_TCTEOBSCONT_ID;

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
CREATE TABLE TCTEOBSCONT (
    CONTROLE           INTEGER NOT NULL,
    CODCTE             INTEGER NOT NULL,
    IDENTIFICACAO      VARCHAR(20) COLLATE PT_BR,
    CONTEUDO           VARCHAR(160) COLLATE PT_BR,
    DATAEHORACADASTRO  TIMESTAMP
);

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
ALTER TABLE TCTEOBSCONT ADD CONSTRAINT PK_TCTEOBSCONT PRIMARY KEY (CONTROLE);

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
ALTER TABLE TCTEOBSCONT ADD CONSTRAINT FK_TCTEOBSCONT_1 FOREIGN KEY (CODCTE) REFERENCES TCTE (CONTROLE);

/*------ SYSDBA 13/09/2024 08:15:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TCTEOBSCONT_BI FOR TCTEOBSCONT
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_tcteobscont_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 16/09/2024 08:30:00 --------*/
ALTER TABLE TESPECIE ADD NOMEMAQUINA VARCHAR(50) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 16/09/2024 08:30:00 --------*/
ALTER TABLE TCONFIGNFCE ADD IMPRIMEPOS CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 16/09/2024 15:30:00 --------*/
CREATE GENERATOR GEN_TGERENCIASGCAM_ID;

/*------ SYSDBA 16/09/2024 15:30:00 --------*/
CREATE TABLE TGERENCIASGCAM (
    CONTROLE      INTEGER NOT NULL,
    CODMODULO     INTEGER,
    MODULO        VARCHAR(50) COLLATE PT_BR,
    CODIGOSGCAM   VARCHAR(20) COLLATE PT_BR,
    SINCRONIZADO  CHAR(1) COLLATE PT_BR
);

/*------ SYSDBA 16/09/2024 15:30:00 --------*/
ALTER TABLE TGERENCIASGCAM ADD CONSTRAINT PK_TGERENCIASGCAM PRIMARY KEY (CONTROLE);

/*------ SYSDBA 16/09/2024 15:30:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TGERENCIASGCAM_BI FOR TGERENCIASGCAM
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_tgerenciasgcam_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TCONFIGNFCE ADD CSOSN VARCHAR(3) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TCONFIGNFCE ADD DESCRICAOCSOSN VARCHAR(300) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TCONFIGNFCE ADD ALIQUOTAICMSECF DECIMAL(15,2);

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TCONFIGNFCE ADD CFOP VARCHAR(4) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TCONFIGNFCE ADD CODCSTORIGEM INTEGER DEFAULT 1 NOT NULL;

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TCONFIGNFCE ADD CODIGOCSTORIGEM INTEGER;

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TCONFIGNFCE ADD ORIGEM VARCHAR(300) COLLATE PT_BR;

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TCONFIGNFCE ADD PERCREDUCAOBC DECIMAL(15,2);

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TCONFIGNFCE ADD CONSTRAINT FK_TCONFIGNFCE_CODCSTORIGEM FOREIGN KEY (CODCSTORIGEM) REFERENCES TCSTORIEM (CONTROLE);

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TITEMNFCEPAGINTEGRADO ADD VALORICMS DECIMAL(15,2);

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TITEMNFCEPAGINTEGRADO ADD PERCICMS DECIMAL(15,2);

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TITEMNFCEPAGINTEGRADO ADD VALORBCICMS DECIMAL(15,2);

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TCONFIGOS ADD PERCMAXDESC DECIMAL(15,2) DEFAULT 0.00;

/*------ SYSDBA 17/09/2024 08:10:00 --------*/
ALTER TABLE TCONFIGOS ADD EXIGIRSUPDESC CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 26/09/2024 08:20:00 --------*/
ALTER TABLE TCONFIGCOMANDA ADD TAXADESERVICOENTREGA DECIMAL(15,2);

/*------ SYSDBA 26/09/2024 08:20:00 --------*/
ALTER TABLE TCOMANDA ADD TAXASERVICOENTREGA DECIMAL(15,2);

/*------ SYSDBA 26/09/2024 08:20:00 --------*/
CREATE TABLE TCONFIGFECHAMENTOCAIXANM (
    CONTROLE INT,
    CONSIDERARSANGRIASUPRIMENTO CHAR(1),
    CONSIDERARSANGRIASUPRIMENTOFP CHAR(1),
    CONSIDERARSANGRIASUPRIMENTOFD CHAR(1),
    CONSIDERARRECEBIMENTOS CHAR(1),
    CONSIDERARRECEBIMENTOSFP CHAR(1),
    CONSIDERARRECEBIMENTOSFD CHAR(1),
    TIPORECEBIMENTOS CHAR(1),
    TIPORECEBIMENTOSFP CHAR(1),
    TIPORECEBIMENTOSFD CHAR(1),
    MODULOVENDAS CHAR(1),
    MODULOVENDASFP CHAR(1),
    MODULOVENDASFD CHAR(1),
    TIPOOPERACAO INT,
    TIPOOPERACAOFP INT,
    TIPOOPERACAOFD INT,
    EXIBEITENS CHAR(1),
    EXIBEITENSFP CHAR(1),
    EXIBEITENSFD CHAR(1),
    CONSTRAINT PK_TCONFIGFECHAMENTOCAIXANM PRIMARY KEY (CONTROLE)
);

/*------ SYSDBA 26/09/2024 08:20:00 --------*/
INSERT INTO TCONFIGFECHAMENTOCAIXANM (CONTROLE) VALUES (1);

/*------ SYSDBA 26/09/2024 08:20:00 --------*/
CREATE TABLE TCONFIGFECHAMENTOCAIXANFCE (
    CONTROLE INT,
    CONSIDERARSANGRIASUPRIMENTO CHAR(1),
    CONSIDERARSANGRIASUPRIMENTOFP CHAR(1),
    CONSIDERARSANGRIASUPRIMENTOFD CHAR(1),
    CONSIDERARRECEBIMENTOS CHAR(1),
    CONSIDERARRECEBIMENTOSFP CHAR(1),
    CONSIDERARRECEBIMENTOSFD CHAR(1),
    TIPORECEBIMENTOS CHAR(1),
    TIPORECEBIMENTOSFP CHAR(1),
    TIPORECEBIMENTOSFD CHAR(1),
    MODULOVENDAS CHAR(1),
    MODULOVENDASFP CHAR(1),
    MODULOVENDASFD CHAR(1),
    TIPOOPERACAO INT,
    TIPOOPERACAOFP INT,
    TIPOOPERACAOFD INT,
    EXIBEITENS CHAR(1),
    EXIBEITENSFP CHAR(1),
    EXIBEITENSFD CHAR(1),
    CONSTRAINT PK_TCONFIGFECHAMENTOCAIXANFCE PRIMARY KEY (CONTROLE)
);

/*------ SYSDBA 26/09/2024 08:20:00 --------*/
INSERT INTO TCONFIGFECHAMENTOCAIXANFCE (CONTROLE) VALUES (1);

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TESTOQUE ADD PRECODISTRIBUIDOR DECIMAL(15,4) DEFAULT 0.0000;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TESTOQUE ADD PRECOATACADO DECIMAL(15,4) DEFAULT 0.0000;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TITEMCOMPRA ADD PRECOREVENDACOMPRA DECIMAL(15,2) DEFAULT 0.00;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TITEMCOMPRA ADD PRECOATACADOCOMPRA DECIMAL(15,4) DEFAULT 0.0000;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TITEMCOMPRA ADD PRECODISTRIBUIDORCOMPRA DECIMAL(15,4) DEFAULT 0.0000;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TCLIENTE ADD TIPOPRECOVENDA CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGESTOQUE ADD UTILIZARPRECOSESTOQUE CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGESTOQUE ADD NOMEPRECOREVENDA VARCHAR(25) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGESTOQUE ADD NOMEPRECODISTRIBUIDOR VARCHAR(25) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGESTOQUE ADD NOMEPRECOATACADO VARCHAR(25) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGESTOQUE ADD BLOQUEARPRECOMENORQUECUSTO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGESTOQUE ADD BLOQUEARDIFERENCADESCMAXIMO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGESTOQUE ADD BLOQUEARDIFERENCA CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGESTOQUE ADD PERCDIFERENCA DECIMAL(15,4) DEFAULT 0.0000;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
UPDATE TCLIENTE SET TIPOPRECOVENDA = '0' WHERE TIPOPRECOVENDA IS NULL;

/*------ SYSDBA 01/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGESTOQUE ADD DEFINIRPRECOVENDAPADRAO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 01/10/2024 14:00:00 --------*/
ALTER TABLE TCTE ADD RETIRADA CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 01/10/2024 14:00:00 --------*/
ALTER TABLE TCTE ADD DETALHESRETIRADA VARCHAR(160) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 02/10/2024 11:00:00 --------*/
CREATE GENERATOR GEN_TAPOLICESEGURADORA_ID;

/*------ SYSDBA 02/10/2024 11:00:00 --------*/
CREATE TABLE TAPOLICESEGURADORA (
    CONTROLE          INTEGER NOT NULL,
    NROAPOLICE        VARCHAR(20) COLLATE PT_BR,
    CODSEGURADORA     INTEGER NOT NULL,
    DATAHORACADASTRO  TIMESTAMP
);

/*------ SYSDBA 02/10/2024 11:00:00 --------*/
ALTER TABLE TAPOLICESEGURADORA ADD CONSTRAINT PK_TAPOLICESEGURADORA PRIMARY KEY (CONTROLE);

/*------ SYSDBA 02/10/2024 11:00:00 --------*/
ALTER TABLE TAPOLICESEGURADORA ADD CONSTRAINT FK_TAPOLICESEGURADORA_CODSEG FOREIGN KEY (CODSEGURADORA) REFERENCES TSEGURADORA (CONTROLE);

/*------ SYSDBA 02/10/2024 11:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TAPOLICESEGURADORA_BI FOR TAPOLICESEGURADORA
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.CONTROLE IS NULL) THEN
        NEW.CONTROLE = GEN_ID(GEN_TAPOLICESEGURADORA_ID, 1);
END

^
SET TERM ; ^

/*------ SYSDBA 02/10/2024 13:25:00 --------*/
ALTER TABLE TWHATSAPPMENSAGEM ADD MENSAGEMUTF8 BLOB SUB_TYPE 1 SEGMENT SIZE 80 CHARACTER SET UTF8;

/*------ SYSDBA 02/10/2024 14:31:00 --------*/
ALTER TABLE TFORMAPAGNFCEPAGINTEGRADO ADD ENDIDPIX VARCHAR(50) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 02/10/2024 15:15:00 --------*/
ALTER TABLE TWHATSAPPMENSAGEM ADD MENSAGEMUTF8VISUAL BLOB SUB_TYPE 1 SEGMENT SIZE 80 CHARACTER SET UTF8;

/*------ SYSDBA 03/10/2024 09:42:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TNOTACONSUMIDOR_VERIFICALOTE FOR TNOTACONSUMIDOR
ACTIVE AFTER UPDATE POSITION 0
AS
begin

    if (((new.DATAFATURADA is not NULL) OR (new.JAFATURADA = 'NÃO')) AND
        (new.CANCELADO <> 'SIM')) then
    begin
      Execute procedure spverificaqtdelote(new.CONTROLE, 'NM','V');
    end

    if (new.CANCELADO = 'SIM') then
    begin
       Execute procedure spverificaqtdelote(new.CONTROLE, 'NM','C');
    end

end

^
SET TERM ; ^

/*------ SYSDBA 04/10/2024 08:15:00 --------*/
ALTER TABLE TCONFIGCOMPRA ADD DATARECEBIMENTOEMISSAO CHAR(1) CHARACTER SET latin1 DEFAULT 0 COLLATE PT_BR;

/*------ SYSDBA 04/10/2024 08:40:00 --------*/
ALTER TABLE TWHATSAPPMENSAGEM ADD TITULOMENSAGEM VARCHAR(50) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE GENERATOR GEN_TTAMANHOPIZZA_ID;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE TABLE TTAMANHOPIZZA (
    CONTROLE INTEGER NOT NULL,
    DESCRICAO VARCHAR(20) NOT NULL,
    QTDESABORES SMALLINT NOT NULL,
    QTDEBORDAS SMALLINT NOT NULL,
    QTDEFATIAS SMALLINT NOT NULL,
    ATIVO CHAR(1) NOT NULL
);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TTAMANHOPIZZA ADD CONSTRAINT PK_TTAMANHOPIZZA PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TTAMANHOPIZZA_BI FOR TTAMANHOPIZZA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(GEN_TTAMANHOPIZZA_ID,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE GENERATOR GEN_TBORDA_ID;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE TABLE TBORDA (
    CONTROLE INTEGER NOT NULL,
    DESCRICAO VARCHAR(100),
    VALOR DECIMAL(15, 2),
    TIPO CHAR(1) NOT NULL
);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TBORDA ADD CONSTRAINT PK_TBORDA PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TBORDA_BI FOR TBORDA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(GEN_TBORDA_ID,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE GENERATOR GEN_TDETALHEPIZZA_ID;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE TABLE TDETALHEPIZZA (
    CONTROLE INTEGER NOT NULL,
    CODCOMANDA INTEGER,
    CODTAMANHO INTEGER NOT NULL,
    DESCRICAO VARCHAR(20) COLLATE PT_BR,
    VALORSABOR DECIMAL(15, 2) NOT NULL,
    VALORBORDA DECIMAL(15, 2) NOT NULL,
    OBSPIZZA VARCHAR(250) COLLATE PT_BR,
    TOTALPIZZA DECIMAL(15, 2) NOT NULL,
    CANCELADO VARCHAR(3) COLLATE PT_BR
);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TDETALHEPIZZA ADD CONSTRAINT PK_TDETALHEPIZZA PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TDETALHEPIZZA ADD CONSTRAINT FK_TDETALHEPIZZA_1 FOREIGN KEY (CODTAMANHO) REFERENCES TTAMANHOPIZZA (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TDETALHEPIZZA_BI FOR TDETALHEPIZZA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(GEN_TDETALHEPIZZA_ID,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE GENERATOR GEN_TGRUPOBORDA_ID;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE TABLE TGRUPOBORDA (
    CONTROLE INTEGER NOT NULL,
    CODGRUPO INTEGER NOT NULL,
    CODBORDA INTEGER NOT NULL
);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TGRUPOBORDA ADD CONSTRAINT PK_TGRUPOBORDA PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TGRUPOBORDA ADD CONSTRAINT FK_TGRUPOBORDA_1 FOREIGN KEY (CODGRUPO) REFERENCES TGRUPOESTOQUE (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TGRUPOBORDA ADD CONSTRAINT FK_TGRUPOBORDA_2 FOREIGN KEY (CODBORDA) REFERENCES TBORDA (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TGRUPOBORDA_BI FOR TGRUPOBORDA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(GEN_TGRUPOBORDA_ID,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TGRUPOESTOQUE ADD TIPOCARDAPIO CHAR(1) DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TITEMCOMANDA ADD CODTAMANHO INTEGER;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TITEMCOMANDA ADD IDPIZZA INTEGER;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TITEMCOMANDA ADD CODDETALHEPIZZA INTEGER;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TITEMCOMANDA ADD  VALORSABOR DECIMAL(15,2);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE INDEX IDX_TITEMCOMANDA_DETALHEPIZZA ON TITEMCOMANDA (CODDETALHEPIZZA);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TITEMCOMANDA ADD CONSTRAINT FK_TITEMCOMANDA_DETALHEPIZZA FOREIGN KEY (CODDETALHEPIZZA) REFERENCES TDETALHEPIZZA (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TCONFIGCOMANDA ADD SABORVALORMAIOR CHAR(1) DEFAULT '0'  COLLATE PT_BR;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TCONFIGCOMANDA ADD BORDAVALORMAIOR CHAR(1) DEFAULT '0'  COLLATE PT_BR;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE GENERATOR GEN_TITEMCOMANDABORDA_ID;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE TABLE TITEMCOMANDABORDA (
    CONTROLE INTEGER NOT NULL,
    CODCOMANDA INTEGER,
    CODBORDA INTEGER,
    BORDA VARCHAR(100),
    VALOR DECIMAL(15, 2),
    DATAEHORACADASTRO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    IDPIZZA INTEGER,
    CODDETALHEPIZZA INTEGER
);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TITEMCOMANDABORDA ADD CONSTRAINT PK_TITEMCOMANDABORDA PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TITEMCOMANDABORDA ADD CONSTRAINT FK_TITEMCOMANDABORDA_1 FOREIGN KEY (CODBORDA) REFERENCES TBORDA (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TITEMCOMANDABORDA ADD CONSTRAINT FK_TITEMCOMANDABORDA_2 FOREIGN KEY (CODDETALHEPIZZA) REFERENCES TDETALHEPIZZA (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TITEMCOMANDABORDA_BI FOR TITEMCOMANDABORDA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(GEN_TITEMCOMANDABORDA_ID,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE GENERATOR GEN_TGRUPOTAMANHO_ID;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE TABLE TGRUPOTAMANHO (
    CONTROLE INTEGER NOT NULL,
    CODGRUPO INTEGER NOT NULL,
    CODTAMANHOPIZZA INTEGER NOT NULL
);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TGRUPOTAMANHO ADD CONSTRAINT PK_TGRUPOTAMANHO PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TGRUPOTAMANHO ADD CONSTRAINT FK_TGRUPOTAMANHO_1 FOREIGN KEY (CODGRUPO) REFERENCES TGRUPOESTOQUE (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TGRUPOTAMANHO ADD CONSTRAINT FK_TGRUPOTAMANHO_2 FOREIGN KEY (CODTAMANHOPIZZA) REFERENCES TTAMANHOPIZZA (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TGRUPOTAMANHO_BI FOR TGRUPOTAMANHO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(GEN_TGRUPOTAMANHO_ID,1);
end

^
SET TERM ; ^

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE GENERATOR GEN_TTAMANHOVALOR_ID;

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
CREATE TABLE TTAMANHOVALOR (
    CONTROLE            INTEGER NOT NULL,
    CODTAMANHO      INTEGER NOT NULL,
    CODPRODUTO      INTEGER NOT NULL,    
    PRECOVENDA       DECIMAL(15,2)  
);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TTAMANHOVALOR ADD CONSTRAINT PK_TTAMANHOVALOR PRIMARY KEY (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TTAMANHOVALOR ADD CONSTRAINT FK_TTAMANHOVALOR_1 FOREIGN KEY (CODTAMANHO) REFERENCES TGRUPOTAMANHO (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
ALTER TABLE TTAMANHOVALOR ADD CONSTRAINT FK_TTAMANHOVALOR_2 FOREIGN KEY (CODPRODUTO) REFERENCES TESTOQUE (CONTROLE);

/*------ SYSDBA 04/10/2024 14:30:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TTAMANHOVALOR_BI FOR TTAMANHOVALOR
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(GEN_TTAMANHOVALOR_ID,1);
end

^
SET TERM ; ^

/*------ SYSDBA 07/10/2024 09:40:00 --------*/
ALTER TABLE TNOTACONSUMIDOR ADD PERCDESCONTO DECIMAL(15,2);

/*------ SYSDBA 07/10/2024 09:40:00 --------*/
ALTER TABLE TNOTACONSUMIDOR ADD PERCACRESCIMO DECIMAL(15,2);

/*------ SYSDBA 08/10/2024 09:10:00 --------*/
CREATE GENERATOR GEN_TAVERBACAOSEGURADORA_ID;

/*------ SYSDBA 08/10/2024 09:10:00 --------*/
CREATE TABLE TAVERBACAOSEGURADORA (
    CONTROLE          INTEGER NOT NULL,
    NROAVERBACAO      VARCHAR(40) COLLATE PT_BR,
    CODDOCDESCARMDFE  INTEGER,
    CODSEGURADORA     INTEGER NOT NULL,
    DATAHORACADASTRO  TIMESTAMP
);

/*------ SYSDBA 08/10/2024 09:10:00 --------*/
ALTER TABLE TAVERBACAOSEGURADORA ADD CONSTRAINT PK_TAVERBACAOSEGURADORA PRIMARY KEY (CONTROLE);

/*------ SYSDBA 08/10/2024 09:10:00 --------*/
ALTER TABLE TAVERBACAOSEGURADORA ADD CONSTRAINT FK_TAVSEG_CODDOC_MDFE FOREIGN KEY (CODDOCDESCARMDFE) REFERENCES TDOCDESCARREGAMENTOMDFE (CONTROLE);

/*------ SYSDBA 08/10/2024 09:10:00 --------*/
ALTER TABLE TAVERBACAOSEGURADORA ADD CONSTRAINT FK_TAVSEG_CODSEGURADORA FOREIGN KEY (CODSEGURADORA) REFERENCES TSEGURADORA (CONTROLE);

/*------ SYSDBA 08/10/2024 09:10:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TAVERBACAOSEGURADORA_BI FOR TAVERBACAOSEGURADORA
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.CONTROLE IS NULL) THEN
        NEW.CONTROLE = GEN_ID(GEN_TAVERBACAOSEGURADORA_ID, 1);
END

^
SET TERM ; ^

/*------ SYSDBA 08/10/2024 17:20:00 --------*/
ALTER TABLE TWHATSAPPMENSAGEM ADD OPCAOADICIONAL CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 08/10/2024 17:20:00 --------*/
ALTER TABLE TWHATSAPPMENSAGEM ADD DIASVENCIMENTO INTEGER;

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
ALTER TABLE TCONFERENCIAFECHAMENTOCAIXA ADD MODULO VARCHAR(30) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
ALTER TABLE TCONFERENCIAFECHAMENTOCAIXA ADD HORATURNOINICIAL TIME;

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
ALTER TABLE TCONFERENCIAFECHAMENTOCAIXA ADD HORATURNOFINAL TIME;

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
CREATE GENERATOR GEN_TCONFERENCIATURNO_ID;

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
CREATE TABLE TCONFERENCIATURNO (
    CONTROLE        INTEGER NOT NULL,
    DESCRICAOTURNO  VARCHAR(20) COLLATE PT_BR,
    HORAINICIAL     TIME,
    HORAFINAL       TIME,
    QTDEPORTURNO    CHAR(2) COLLATE PT_BR,
    DIASDASEMANA    VARCHAR(20) COLLATE PT_BR
);

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
ALTER TABLE TCONFERENCIATURNO ADD CONSTRAINT PK_TCONFERENCIATURNO PRIMARY KEY (CONTROLE);

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TCONFERENCIATURNO_BI FOR TCONFERENCIATURNO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_TCONFERENCIATURNO_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
CREATE GENERATOR GEN_THISTORICOCONFERENCIA_ID;

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
CREATE TABLE THISTORICOCONFERENCIA (
    CONTROLE               INTEGER NOT NULL,
    CODCONFERENCIA         INTEGER,
    CODFUNCIONARIO         INTEGER,
    FUNCIONARIO            VARCHAR(100) COLLATE PT_BR,
    VALORRECEBIDOANTIGO    DECIMAL(15,4),
    VALORRECEBIDONOVO      DECIMAL(15,4),
    VALORFECHAMENTOANTIGO  DECIMAL(15,4),
    VALORFECHAMENTONOVO    DECIMAL(15,4),
    VALORDIFERENCAANTIGO   DECIMAL(15,4),
    VALORDIFERENCANOVO     DECIMAL(15,4),
    DATAHORAFECHAMENTO     TIMESTAMP NOT NULL,
    MODULO                 VARCHAR(30) COLLATE PT_BR
);

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
ALTER TABLE THISTORICOCONFERENCIA ADD CONSTRAINT PK_THISTORICOCONFERENCIA PRIMARY KEY (CONTROLE);

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER THISTORICOCONFERENCIA_BI FOR THISTORICOCONFERENCIA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_thistoricoconferencia_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 16/10/2024 08:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TCONFERENCIAFECHAMENTOCAIXA_BU0 FOR TCONFERENCIAFECHAMENTOCAIXA
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
    IF ((NEW.VALORRECEBIDO <> OLD.VALORRECEBIDO OR NEW.VALORFECHAMENTO <> OLD.VALORFECHAMENTO)) THEN
    BEGIN
        INSERT INTO THISTORICOCONFERENCIA (CODCONFERENCIA, CODFUNCIONARIO, FUNCIONARIO, VALORRECEBIDOANTIGO, VALORRECEBIDONOVO, VALORFECHAMENTOANTIGO, VALORFECHAMENTONOVO,
        VALORDIFERENCAANTIGO, VALORDIFERENCANOVO, DATAHORAFECHAMENTO, MODULO) VALUES (OLD.CONTROLE, NEW.CODFUNCIONARIO, NEW.FUNCIONARIO, OLD.VALORRECEBIDO, NEW.VALORRECEBIDO,
        OLD.VALORFECHAMENTO, NEW.VALORFECHAMENTO, OLD.VALORDIFERENCA, NEW.VALORDIFERENCA, CURRENT_TIMESTAMP, OLD.MODULO);
    END
END

^
SET TERM ; ^

/*------ SYSDBA 16/10/2024 17:20:00 --------*/
ALTER TABLE TCONFIGOS ADD CARREGAROBSESTOQUE CHAR(1) DEFAULT '0';

/*------ SYSDBA 16/10/2024 17:20:00 --------*/
ALTER TABLE TCONFIGOS ADD EMITIRDOCUMENTO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 16/10/2024 17:20:00 --------*/
ALTER TABLE TCONFIGOS ADD CATEGORIAFATURAMENTO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 21/10/2024 07:50:00 --------*/
ALTER TABLE TAJUSTEESTOQUE ADD DEVOLUCAO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 22/10/2024 13:40:00 --------*/
ALTER TABLE TCONFIGFECHAMENTOCAIXANM ADD UTILIZARCONFIGFP CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 22/10/2024 13:40:00 --------*/
ALTER TABLE TCONFIGFECHAMENTOCAIXANM ADD UTILIZARCONFIGFD CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 22/10/2024 16:45:00 --------*/
ALTER TABLE TSEGURADORA ADD ATIVO VARCHAR(3) DEFAULT 'SIM' NOT NULL;

/*------ SYSDBA 23/10/2024 10:30:00 --------*/
ALTER TABLE TCONFIGFECHAMENTOCAIXANFCE ADD UTILIZARCONFIGFD CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 23/10/2024 10:30:00 --------*/
ALTER TABLE TCONFIGFECHAMENTOCAIXANFCE ADD UTILIZARCONFIGFP CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 23/10/2024 10:30:00 --------*/
ALTER TABLE TCONFIGFECHAMENTOCAIXANFCE ADD UTILIZARCONFIGDT CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 23/10/2024 13:15:00 --------*/
CREATE TABLE TARQUIVOEXTRATOCARTAO (
    CONTROLE INTEGER NOT NULL,
    ARQUIVOHASH VARCHAR(255) NOT NULL,
    IMPORTADO TIMESTAMP NOT NULL,
    ATUALIZADOIMPORTACAO TIMESTAMP NOT NULL,
    ENTIDADEEXTRATO VARCHAR(255),
    DATAINICIO TIMESTAMP,
    DATAFIM TIMESTAMP
);

/*------ SYSDBA 23/10/2024 13:15:00 --------*/
ALTER TABLE TARQUIVOEXTRATOCARTAO ADD PRIMARY KEY (CONTROLE);

/*------ SYSDBA 23/10/2024 13:15:00 --------*/
CREATE SEQUENCE GEN_TARQUIVOEXTRATOCARTAO_ID;

/*------ SYSDBA 23/10/2024 13:15:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TARQUIVOEXTRATOCARTAO_BI FOR TARQUIVOEXTRATOCARTAO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.CONTROLE IS NULL) THEN
    NEW.CONTROLE = NEXT VALUE FOR GEN_TARQUIVOEXTRATOCARTAO_ID;
END

^
SET TERM ; ^

/*------ SYSDBA 23/10/2024 13:15:00 --------*/
CREATE TABLE TEXTRATOCARTAO (
    CONTROLE INTEGER NOT NULL,
    DATAEHORAVENDA TIMESTAMP NOT NULL,
    STATUSVENDA VARCHAR(14) NOT NULL,
    VALORVENDAORIGINAL DECIMAL(18,2) NOT NULL,
    VALORVENDAATUALIZADO DECIMAL(18,2) NOT NULL,
    MODALIDADE VARCHAR(18) NOT NULL,
    TIPO VARCHAR(18) NOT NULL,
    NUMEROPARCELAS INTEGER NOT NULL,
    BANDEIRA VARCHAR(18) NOT NULL,
    TAXAMDR DECIMAL(18,2) NOT NULL,
    VALORMDR DECIMAL(18,2) NOT NULL,
    TAXAANTECIPACAOFLEX VARCHAR(12) NOT NULL,
    VALORTAXAANTECIPACAOFLEX DECIMAL(18,2) NOT NULL,
    TAXASDESCONTADAS VARCHAR(150) NOT NULL,
    VALORTOTALTAXASDESCONTADAS DECIMAL(18,2) NOT NULL,
    VALORLIQUIDO DECIMAL(18,2) NOT NULL,
    NSUCV VARCHAR(18) NOT NULL,
    PRAZORECEBIMENTO INTEGER NOT NULL,
    RESUMOVENDASNUMEROLOTE VARCHAR(18) NOT NULL,
    NUMEROAUTORIZACAO VARCHAR(18) NOT NULL,
    NUMEROESTABELECIMENTO VARCHAR(13) NOT NULL,
    NOMEESTABELECIMENTO VARCHAR(150) NOT NULL,
    CNPJ VARCHAR(18) NOT NULL,
    NUMEROCARTAO VARCHAR(30) NOT NULL,
    IDCARTEIRADIGITAL VARCHAR(18) NOT NULL,
    MEIOPAGAMENTO VARCHAR(18) NOT NULL,
    TIPOMAQUININHA VARCHAR(12) NOT NULL,
    CODIGOMAQUININHA VARCHAR(12) NOT NULL,
    TID VARCHAR(18) NOT NULL,
    NUMEROPEDIDO VARCHAR(18) NOT NULL,
    TAXAEMBARQUE DECIMAL(18,2) NOT NULL,
    CANCELADAPELOESTABELECIMENTO SMALLINT NOT NULL,
    DATACANCELAMENTO TIMESTAMP,
    VALORCANCELADO DECIMAL(18,2) NOT NULL,
    EMDISPUTACHARGEBACK SMALLINT NOT NULL,
    DATAENTROUDISPUTACHARGEBACK TIMESTAMP,
    RESOLUCAOCHARGEBACK VARCHAR(150) NOT NULL,
    DATARESOLUCAOCHARGEBACK TIMESTAMP,
    NACIONALIDADECARTAO VARCHAR(12) NOT NULL,
    MOEDAESTRANGEIRA SMALLINT NOT NULL,
    CARTAOPREPAGO SMALLINT NOT NULL,
    CODARQUIVOEXTRATOCARTAO INTEGER,
    CONFIRMADO SMALLINT DEFAULT 0
);

/*------ SYSDBA 23/10/2024 13:15:00 --------*/
ALTER TABLE TEXTRATOCARTAO ADD PRIMARY KEY (CONTROLE);

/*------ SYSDBA 23/10/2024 13:15:00 --------*/
ALTER TABLE TEXTRATOCARTAO ADD CONSTRAINT FK_CODARQUIVOEXTRATOCARTAO FOREIGN KEY (CODARQUIVOEXTRATOCARTAO) REFERENCES TARQUIVOEXTRATOCARTAO (CONTROLE) ON DELETE CASCADE;

/*------ SYSDBA 23/10/2024 13:15:00 --------*/
CREATE SEQUENCE GEN_TEXTRATOCARTAO_ID;

/*------ SYSDBA 23/10/2024 13:15:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TEXTRATOCARTAO_BI FOR TEXTRATOCARTAO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.CONTROLE IS NULL) THEN
    NEW.CONTROLE = NEXT VALUE FOR GEN_TEXTRATOCARTAO_ID;
END

^
SET TERM ; ^

/*------ SYSDBA 23/10/2024 13:15:00 --------*/
ALTER TABLE TESPECIE ADD TAXAMDR DECIMAL(15, 4);

/*------ SYSDBA 24/10/2024 14:25:00 --------*/
ALTER TABLE TDOCDESCARREGAMENTOMDFE ADD "INFORMARNROAVERBACAONAOBS" VARCHAR(3) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 29/10/2024 07:50:00 --------*/
CREATE TABLE TFORMAPAGAMENTOIMPCOMANDA (
    CONTROLE INT NOT NULL,
    ESPECIE VARCHAR(50),
    VALORINFORMADO DECIMAL(10,4),
    CODCOMANDA INT,
    PRIMARY KEY (CONTROLE),
    FOREIGN KEY (CODCOMANDA) REFERENCES TCOMANDA (CONTROLE)
);

/*------ SYSDBA 29/10/2024 07:50:00 --------*/
CREATE GENERATOR GEN_TFORMAPAGIMPCOMANDA_ID;

/*------ SYSDBA 29/10/2024 07:50:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TR_TFORMAPAG_BEFORE_INSERT FOR TFORMAPAGAMENTOIMPCOMANDA
BEFORE INSERT
AS
BEGIN
    IF (NEW.CONTROLE IS NULL) THEN
        NEW.CONTROLE = GEN_ID(GEN_TFORMAPAGIMPCOMANDA_ID, 1);
END

^
SET TERM ; ^

/*------ SYSDBA 29/10/2024 10:00:00 --------*/
ALTER TABLE TCONFIGORCAMENTO ADD SEPARARPRODUTOSERVICOIMPRESSAO CHAR(1) CHARACTER SET latin1 COLLATE PT_BR ;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGCASHBACK ADD PERIODOPADRAO CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGCASHBACK ADD USAPERIODOPERSONALIZADO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGCASHBACK ADD DIASPERIODOPERSONALIZADO CHAR(3) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGCASHBACK ADD ENVIARNOTIFICACAO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE TCONFIGCASHBACK ADD DIASAVISO CHAR(3) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE THISTORICOCASHBACK ADD DATAVALIDADE DATE;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE THISTORICOCASHBACK ADD VENCIDO CHAR(3) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
CREATE GENERATOR GEN_TPROPRIETARIOVEICULO_ID;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
CREATE TABLE TPROPRIETARIOVEICULO (
    CONTROLE                 INTEGER NOT NULL,
    RAZAOSOCIALPROPRIETARIO  VARCHAR(100) COLLATE PT_BR,
    CPFPROPRIETARIO          VARCHAR(20) COLLATE PT_BR,
    CNPJPROPRIETARIO         VARCHAR(20) COLLATE PT_BR,
    UFPROPRIETARIO           VARCHAR(2) COLLATE PT_BR,
    IEPROPRIETARIO           VARCHAR(20) COLLATE PT_BR,
    RNTRC                    VARCHAR(8) COLLATE PT_BR,
    TIPOPROPRIETARIO         VARCHAR(25) COLLATE PT_BR
);

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE TPROPRIETARIOVEICULO ADD CONSTRAINT PK_TPROPRIETARIOVEICULO PRIMARY KEY (CONTROLE);

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TPROPRIETARIOVEICULO_BI FOR TPROPRIETARIOVEICULO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(GEN_TPROPRIETARIOVEICULO_ID,1);
end

^
SET TERM ; ^

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE TVEICULO ADD CODPROPRIETARIO INTEGER;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE TVEICULO ADD NOMEPROPRIETARIO VARCHAR(100) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
CREATE GENERATOR GEN_THISTORICONFCE_ID;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
CREATE TABLE THISTORICONFCE (
    CONTROLE          INTEGER NOT NULL,
    DATAHORACADASTRO  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    DATAEMISSAO       DATE,
    NOTA              INTEGER,
    SERIE             INTEGER,
    CNPJ              VARCHAR(18) COLLATE PT_BR,
    CPF               VARCHAR(14) COLLATE PT_BR,
    RAZAOSOCIAL       VARCHAR(60) COLLATE PT_BR,
    IE                VARCHAR(14) COLLATE PT_BR,
    VALORTOTAL        NUMERIC(15,2),
    VALORICMS         NUMERIC(15,2),
    VALORICMSST       NUMERIC(15,2),
    VALORBCICMS       NUMERIC(15,2),
    VALORBCICMSST     NUMERIC(15,2),
    CHAVEACESSO       VARCHAR(44) COLLATE PT_BR,
    XML               BLOB SUB_TYPE 1 SEGMENT SIZE 80
);

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE THISTORICONFCE ADD CONSTRAINT PK_THISTORICONFCE PRIMARY KEY (CONTROLE);

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER THISTORICONFCE_BI FOR THISTORICONFCE
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_thistoriconfce_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
CREATE GENERATOR GEN_THISTORICONFCEITEM_ID;

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
CREATE TABLE THISTORICONFCEITEM (
    CONTROLE          INTEGER NOT NULL,
    DATAHORACADASTRO  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CODNFCE           INTEGER NOT NULL,
    CODBARRA          VARCHAR(14) COLLATE PT_BR,
    PRODUTO           VARCHAR(120) COLLATE PT_BR,
    NCM               VARCHAR(8) COLLATE PT_BR,
    CEST              VARCHAR(7) COLLATE PT_BR,
    CFOP              CHAR(4) COLLATE PT_BR,
    UNCOMERCIAL       VARCHAR(6) COLLATE PT_BR,
    QTDECOMERCIAL     DECIMAL(15,2),
    VALORUNITARIO     DECIMAL(15,2),
    VALORBRUTO        DECIMAL(15,2),
    VALORDESCONTO     DECIMAL(15,2),
    VALORLIQUIDO      DECIMAL(15,2),
    VALORBCICMS       DECIMAL(15,2),
    ALIQUOTAICMS      DECIMAL(15,2),
    VALORICMS         DECIMAL(15,2),
    VALORBCICMSST     DECIMAL(15,2),
    ALIQUOTAICMSST    DECIMAL(15,2),
    VALORICMSST       DECIMAL(15,2)
);

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE THISTORICONFCEITEM ADD CONSTRAINT PK_THISTORICONFCEITEM PRIMARY KEY (CONTROLE);

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
ALTER TABLE THISTORICONFCEITEM ADD CONSTRAINT FK_THISTORICONFCEITEM FOREIGN KEY (CODNFCE) REFERENCES THISTORICONFCE (CONTROLE);

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER THISTORICONFCEITEM_BI FOR THISTORICONFCEITEM
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_thistoriconfceitem_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 31/10/2024 08:00:00 --------*/
update RDB$RELATION_FIELDS set RDB$NULL_FLAG = 1 where (RDB$FIELD_NAME = 'CODNFE') and (RDB$RELATION_NAME = 'THISTORICONFEITEM');

/*------ SYSDBA 01/11/2024 09:25:00 --------*/
SET TERM ^ ;

CREATE OR ALTER procedure SPALIMENTAITEMOP (
    CODPRODUCAO integer,
    CODMODULO integer,
    ORIGEM varchar(10) collate PT_BR)
as
declare variable ESTPROD varchar(100) collate PT_BR;
declare variable ESTUN varchar(10) collate PT_BR;
declare variable ESTUSAGRADE varchar(10) collate PT_BR;
declare variable CODPROD integer;
declare variable QTDEOP decimal(15,4);
declare variable ESTVALORUNITARIO decimal(15,4);
BEGIN

    if (:origem = 'NM') then
    begin
        For
            SELECT tnm.CODPRODUTO, SUM(coalesce(cast(tnm.qtde AS DECIMAL (15,4)),0.000)) AS qtdevenda FROM titennotaconsumidor tnm  WHERE  tnm.CODNOTACONSUMIDOR = :codmodulo
                AND tnm.codproduto IN (SELECT DISTINCT tcomposicao.CODPRODUTOCOMPOSICAO FROM tcomposicao WHERE tcomposicao.codprodutocomposicao = tnm.CODPRODUTO) 
                    GROUP by tnm.codproduto
                    INTO :CODPROD, :QTDEOP do
        begin
            SELECT FIRST 1 testoque.PRODUTO, testoque.UNIDADE, testoque.USAGRADE, testoque.PRECOCUSTO FROM testoque WHERE testoque.controle = :codprod
                INTO :ESTPROD, :ESTUN, :ESTUSAGRADE, :ESTVALORUNITARIO;
            
           INSERT INTO titemordemproducao (
                CODPRODUTO, PRODUTO, DATAEHORACADASTRO, SITUACAO,
                CODPRODUCAO, UN,
                 USAGRADE, QTDE, VALORUNITARIO)                     
            VALUES (
                 :CODPROD, :ESTPROD, CURRENT_TIMESTAMP, 'FINALIZADA',
                 :CODPRODUCAO, :ESTUN,
                 :ESTUSAGRADE, :QTDEOP, :ESTVALORUNITARIO);
        end
    end
    
    if (:origem = 'NFCE') then
    begin
        For
            SELECT tnfce.CODPRODUTO, SUM(coalesce(cast(tnfce.qtde AS DECIMAL (15,4)),0.0000)) AS qtdevenda FROM titemvendanfce tnfce WHERE  tnfce.CODNFCE = :codmodulo
                AND tnfce.codproduto IN (SELECT DISTINCT tcomposicao.CODPRODUTOCOMPOSICAO FROM tcomposicao WHERE tcomposicao.codprodutocomposicao = tnfce.CODPRODUTO) 
                    GROUP by tnfce.codproduto
                    INTO :CODPROD, :QTDEOP do
        begin
            SELECT FIRST 1 testoque.PRODUTO, testoque.UNIDADE, testoque.USAGRADE, testoque.PRECOCUSTO FROM testoque WHERE testoque.controle = :codprod
                INTO :ESTPROD, :ESTUN, :ESTUSAGRADE, :ESTVALORUNITARIO;
            
           INSERT INTO titemordemproducao (
                CODPRODUTO, PRODUTO, DATAEHORACADASTRO, SITUACAO,
                CODPRODUCAO, UN,
                 USAGRADE, QTDE, VALORUNITARIO)                     
            VALUES (
                 :CODPROD, :ESTPROD, CURRENT_TIMESTAMP, 'FINALIZADA',
                 :CODPRODUCAO, :ESTUN,
                 :ESTUSAGRADE, :QTDEOP, :ESTVALORUNITARIO);
        end
    end
    
    if (:origem = 'PDV') then
    begin
        For
            SELECT titempdv.CODPRODUTO, SUM(coalesce(cast(titempdv.qtde AS DECIMAL (15,4)),0.000)) AS qtdevenda FROM titemvendaecf titempdv WHERE  titempdv.CODVENDAECF = :codmodulo
                AND titempdv.codproduto IN (SELECT DISTINCT tcomposicao.CODPRODUTOCOMPOSICAO FROM tcomposicao WHERE tcomposicao.codprodutocomposicao = titempdv.CODPRODUTO) 
                AND titempdv.CANCELADO <> 'SIM' 
                    GROUP by titempdv.codproduto
                    INTO :CODPROD, :QTDEOP do
        begin
            SELECT FIRST 1 testoque.PRODUTO, testoque.UNIDADE, testoque.USAGRADE, testoque.PRECOCUSTO FROM testoque WHERE testoque.controle = :codprod
                INTO :ESTPROD, :ESTUN, :ESTUSAGRADE, :ESTVALORUNITARIO;
            
           INSERT INTO titemordemproducao (
                CODPRODUTO, PRODUTO, DATAEHORACADASTRO, SITUACAO,
                CODPRODUCAO, UN,
                 USAGRADE, QTDE, VALORUNITARIO)                     
            VALUES (
                 :CODPROD, :ESTPROD, CURRENT_TIMESTAMP, 'FINALIZADA',
                 :CODPRODUCAO, :ESTUN,
                 :ESTUSAGRADE, :QTDEOP, :ESTVALORUNITARIO);
        end
    end
    
    if (:origem = 'NFE') then
    begin
        For
            SELECT tnfe.CODPRODUTO, SUM(coalesce(cast(tnfe.qtdecomercial AS DECIMAL(15,4)),0.000)) AS qtdevenda FROM titensvendanfe tnfe WHERE  tnfe.CODNFE = :codmodulo
                AND tnfe.codproduto IN (SELECT DISTINCT tcomposicao.CODPRODUTOCOMPOSICAO FROM tcomposicao WHERE tcomposicao.codprodutocomposicao = tnfe.CODPRODUTO) 
                    GROUP by tnfe.codproduto
                    INTO :CODPROD, :QTDEOP do
        begin
            SELECT FIRST 1 testoque.PRODUTO, testoque.UNIDADE, testoque.USAGRADE, testoque.PRECOCUSTO FROM testoque WHERE testoque.controle = :codprod
                INTO :ESTPROD, :ESTUN, :ESTUSAGRADE, :ESTVALORUNITARIO;
            
           INSERT INTO titemordemproducao (
                CODPRODUTO, PRODUTO, DATAEHORACADASTRO, SITUACAO,
                CODPRODUCAO, UN,
                 USAGRADE, QTDE, VALORUNITARIO)                     
            VALUES (
                 :CODPROD, :ESTPROD, CURRENT_TIMESTAMP, 'FINALIZADA',
                 :CODPRODUCAO, :ESTUN,
                 :ESTUSAGRADE, :QTDEOP, :ESTVALORUNITARIO);
        end
    end

END

^
SET TERM ; ^

/*------ SYSDBA 07/11/2024 14:15:00 --------*/
ALTER TABLE TESPECIE ADD ESPECIECOMISSAO CHAR(1) CHARACTER SET latin1;

/*------ SYSDBA 14/11/2024 18:00:00 --------*/
ALTER TABLE TCONFIGOS ADD AVISARLANCAMENTOITEMDUPLICADO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 26/11/2024 11:30:00 --------*/
ALTER TABLE TCONFIGWHATSAPP ADD DATAENVIADO DATE;

/*------ SYSDBA 27/11/2024 07:48:00 --------*/
ALTER TABLE THISTORICONFE ADD CNPJCPFDESTINATARIO VARCHAR(14) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 27/11/2024 08:23:00 --------*/
ALTER TABLE TLCDPRDEMONSTRATIVO ADD CODCOMPRA INTEGER;

/*------ SYSDBA 27/11/2024 08:23:00 --------*/
ALTER TABLE TLCDPRDEMONSTRATIVO ADD CONSTRAINT FK_TLCDPRDEM_CODCOMPRA  FOREIGN KEY (CODCOMPRA) REFERENCES TCOMPRA (CONTROLE);

/*------ SYSDBA 27/11/2024 11:07:00 --------*/
ALTER TABLE TCONFIGRECEBER ADD PERMITIRQUITARCLIENTEDIFERENTE CHAR(1) DEFAULT '0';

/*------ SYSDBA 28/11/2024 08:30:00 --------*/
ALTER TABLE TCONFIGNOTAMANUAL ADD IMPRIMIRMATRICIAL CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 28/11/2024 08:30:00 --------*/
ALTER TABLE TCONFIGORCAMENTO ADD IMPRIMIRMATRICIAL CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 28/11/2024 08:30:00 --------*/
ALTER TABLE TCONFIGPEDIDOVENDA ADD IMPRIMIRMATRICIAL CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 06/12/2024 13:08:00 --------*/
ALTER TABLE TCONFIGRECEBER ADD EXIGESUPQUITARPARCIALOPCAO INTEGER DEFAULT 1;

/*------ SYSDBA 23/12/2024 07:50:00 --------*/
ALTER TABLE TCONFIGRECEBER ADD BUSCAEXATA CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 23/12/2024 07:50:00 --------*/
ALTER TABLE TCONFIGPAGAR ADD BUSCAEXATA CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 09/01/2025 08:20:00 --------*/
ALTER TABLE TWHATSAPPHISTORICO ADD MENSAGEMUTF8 BLOB SUB_TYPE 1 SEGMENT SIZE 80 CHARACTER SET UTF8;

/*------ SYSDBA 10/01/2025 16:55:00 --------*/
ALTER TABLE TOPERACAO ADD EXCLUSAOIPIPISCOFINS CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 13/01/2025 09:15:00 --------*/
ALTER TABLE TESTADOSICMSSUBS ADD PERCICMSDIFERIDO DECIMAL(15, 2) DEFAULT 0.00;

/*------ SYSDBA 14/01/2025 08:50:00 --------*/
SET TERM ^ ;

CREATE OR ALTER VIEW VCASHBACK(
    CODCLIENTE,
    CLIENTE,
    SALDO)
AS
select
    thist.CODCLIENTE AS codCliente,
    (select cliente from tcliente where controle = thist.codcliente ) as Cliente,
    iif(sum(thist.valorentrada - thist.valorsaida) > 0, sum(thist.valorentrada - thist.valorsaida), 0) as Saldo
from thistoricocashback thist
where thist.confirmado = '1' and (thist.vencido <> 'SIM' or thist.vencido is null or thist.vencido = '')
group by
    thist.codcliente

^
SET TERM ; ^

/*------ SYSDBA 15/01/2025 09:33:00 --------*/
ALTER TABLE TCONFIGESTOQUE ADD ATUALIZARQTDEFISICACOMLOTES CHAR(1) CHARACTER SET latin1 DEFAULT '1' COLLATE PT_BR;

/*------ SYSDBA 24/01/2025 15:50:00 --------*/
ALTER TABLE TCONFIGNFCE ADD IMPRIMECOMPPOS CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 24/01/2025 15:50:00 --------*/
ALTER TABLE TOPERACAO ADD EXCLUSAODESCONTOIPI CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 27/01/2025 08:36:00 --------*/
ALTER TABLE TCONFIGSAT ADD TEMPOESPERACOMUNICACAOSAT INTEGER DEFAULT 10;

/*------ SYSDBA 27/01/2025 09:05:00 --------*/
ALTER TABLE TCONFIGURACOESGERAIS ADD BLOQUEARMESCLAGEM CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR; 

/*------ SYSDBA 03/02/2025 09:25:00 --------*/
ALTER TABLE TCONFIGNFE ADD SOMARQTDEPRODUTOS CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 03/02/2025 09:25:00 --------*/
UPDATE TCONFIGNFE SET SOMARQTDEPRODUTOS = SOMARQTDEPRODUTOSNOSVOLUMES WHERE SOMARQTDEPRODUTOS IS NULL;

/*------ SYSDBA 03/02/2025 09:25:00 --------*/
ALTER TABLE TCLIENTE ALTER COLUMN MENSAGEMFISCAL TYPE VARCHAR(2000);

/*------ SYSDBA 04/02/2025 09:20:00 --------*/
ALTER TABLE TESTADOSICMSSUBS ADD PERCMARGEMPAUTAST DECIMAL(15, 2) DEFAULT 0.00;

/*------ SYSDBA 04/02/2025 09:20:00 --------*/
ALTER TABLE TESTADOSICMSSUBS ADD VALORPAUTAST DECIMAL(15, 4) DEFAULT 0.00;

/*------ SYSDBA 04/02/2025 09:20:00 --------*/
ALTER TABLE TESTOQUE ADD PERCMARGEMPAUTAST DECIMAL(15, 2) DEFAULT 0.00;

/*------ SYSDBA 04/02/2025 09:20:00 --------*/
ALTER TABLE TESTOQUE ADD VALORPAUTAST DECIMAL(15, 4) DEFAULT 0.00;

/*------ SYSDBA 04/02/2025 13:28:00 --------*/
ALTER TABLE TEMITENTE ADD DATAABERTURASEMANAL DATE;

/*------ SYSDBA 05/02/2025 13:15:00 --------*/
CREATE OR ALTER VIEW VACOUGUE(
    CONTROLE,
    CODFUNCIONARIO,
    FUNCIONARIO,
    CODPRODUTO,
    PRODUTO,
    PESOTOTAL,
    PRECOKG,
    ANIMAL,
    GRUPO,
    STATUS,
    DATAHORACADASTRO)
AS
select
    taco.controle,
    taco.codfuncionario,
    (Select funcionario from tfuncionario where controle = taco.codfuncionario) as Funcionario,
    taco.codprodutoorigem,
    (Select produto from testoque where controle = taco.codprodutoorigem),
    taco.pesototal,
    taco.precokg,
    case taco.animal
        when 0 then 'BOVINO'
        when 1 then 'SUÍNO'
    end as animal,
    case taco.grupo
        when 0 then 'DIANTEIRO'
        when 1 then 'TRASEIRO'
        when 2 then 'CARCAÇA COMPLETA'
        when 3 then 'TODOS'
    end as grupo,
    case taco.status
        when 0 then 'ABERTO'
        when 1 then 'EM PRODUÇÃO'
        when 2 then 'FINALIZADO'
    end as status,
    taco.datahoracadastro
 from tacouguedesmembramento taco;

/*------ SYSDBA 06/02/2025 09:17:00 --------*/
ALTER TABLE TUSUARIO ADD DASHBOARD VARCHAR(3) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 06/02/2025 14:45:00 --------*/
ALTER TABLE TCONFIGRECEBER ADD ULTIMOFILTROSTATUS VARCHAR(20);

/*------ SYSDBA 06/02/2025 14:45:00 --------*/
ALTER TABLE TCONFIGRECEBER ADD GRAVARULTIMOFILTROSTATUS INTEGER DEFAULT 0 NOT NULL;

/*------ SYSDBA 06/02/2025 17:25:00 --------*/
ALTER TABLE TOPERACAO ADD IMPRIMIRQTDETRIB CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 07/02/2025 10:15:00 --------*/
ALTER TABLE TCONTABANCARIA ADD BOLETOHIBRIDO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 13/02/2025 16:58:00 --------*/
ALTER TABLE TOFICINAVEICULO ADD VEICULOPADRAO CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 13/02/2025 17:30:00 --------*/
update tconfigemitente tm set tm.produtorrural = 0 where tm.produtorrural is null;

/*------ SYSDBA 20/02/2025 09:00:00 --------*/
ALTER TABLE TCONFIGFISCAL ADD CLASSCONTRIBUINTE CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 20/02/2025 09:00:00 --------*/
ALTER TABLE TCONFIGFISCAL ADD ATIVIDADECONT CHAR(1) CHARACTER SET latin1 DEFAULT '0' COLLATE PT_BR;

/*------ SYSDBA 20/02/2025 15:25:00 --------*/
ALTER TABLE TOPERACAO ADD IMPRIMIRDISPOSICAOLEGAL CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 25/02/2025 09:10:00 --------*/
SET TERM ^ ;

CREATE OR ALTER trigger titemvendanfce_totalizaitem for titemvendanfce
active before insert or update position 1
as
declare variable VALORANTES numeric(15,2);
declare variable QTDEANTES numeric(15,4);
declare variable EXCLUIBCPISCOFINS CHAR(1);
begin
   VALORANTES = 0;
   QTDEANTES = 0;
   VALORANTES = old.VALORUNITARIO;
   QTDEANTES = old.QTDE;
   EXCLUIBCPISCOFINS = new.EXCLUSAOICMSPC;

   if (new.QTDE is null) then
      new.QTDE = '1';
   if ((cast(new.VALORUNITARIO as varchar(15)) is null) or (cast(new.VALORUNITARIO as varchar(15)) < 0.001) and (new.brinde <> '1')) then
   begin
      new.VALORUNITARIO = :VALORANTES;
   end
   if ((cast(new.QTDE as varchar(15)) is null) or (cast(new.QTDE as varchar(15)) < 0.001)) then
   begin
      new.QTDE = :QTDEANTES;
   end
   new.VALORTOTAL = cast((new.VALORUNITARIO) * (cast(new.QTDE as numeric(15,4))) as numeric(15,2));
   new.VALORLIQUIDO = coalesce(new.VALORTOTAL, 0) - coalesce(new.VALORDESCONTO, 0) - coalesce(new.VALORDESCONTOITEM, 0) + coalesce(new.VALORACRESCIMO, 0) + coalesce(new.VALORSEGURO, 0) + coalesce(new.VALORICMSST, 0) + coalesce(new.VALOROUTROS, 0) + coalesce(new.VALOROUTROSITEM, 0);
   new.VALORIMPOSTOMEDIO = iif(((coalesce(new.VALORLIQUIDO, 0) * coalesce((select PERCIMPOSTOMEDIO from TESTOQUE where CONTROLE = new.CODPRODUTO), 0)) / 100) > 0, 
                            ((coalesce(new.VALORLIQUIDO, 0) * coalesce((select PERCIMPOSTOMEDIO from TESTOQUE where CONTROLE = new.CODPRODUTO), 0)) / 100), 0);
   if ((new.CSOSN = 00) or (new.CSOSN = 0) or (new.CSOSN = 20) or (new.CSOSN = 90)) then
   begin
      if (coalesce(new.PERCICMS, 0) > 0) then
      begin
         if (coalesce(new.percreducaobc, 0) > 0) then
         begin
            new.VALORBCICMS = cast(new.VALORLIQUIDO as numeric(15,4)) * (1 - (new.percreducaobc / 100));
         end
         else
         begin
            new.VALORBCICMS = cast(new.VALORLIQUIDO as numeric(15,4));
         end
         new.VALORICMS = ((cast(new.VALORBCICMS as numeric(15,4)) / 100) * coalesce(new.PERCICMS, 0));
      end
   end
   if ((new.CFOP = '5933') and
       (new.CSOSN is null)) then
   begin
      if (coalesce(new.VALORALIQUOTAISSQN, 0) > 0) then
      begin
         new.VALORBCISSQN = cast(new.VALORLIQUIDO as numeric(15,4));
         new.VALORISSQN = ((cast(new.VALORBCISSQN as numeric(15,4)) / 100) * coalesce(new.VALORALIQUOTAISSQN, 0));
      end
   end
   if (EXCLUIBCPISCOFINS <> '1') then
   begin
     new.VALORBCPIS = cast(new.VALORLIQUIDO as numeric(15,4));
     new.VALORPIS = ((cast(new.VALORBCPIS as numeric(15,4)) / 100) * coalesce(new.PERCPIS, 0));
     new.VALORBCCOFINS = cast(new.VALORLIQUIDO as numeric(15,4));
     new.VALORCOFINS = ((cast(new.VALORBCCOFINS as numeric(15,4)) / 100) * coalesce(new.PERCCOFINS, 0));
   end
   if (new.cstpis = '03') then
        begin
            new.VALORPIS = (cast(new.QTDE as numeric(15,4)) * coalesce(new.PERCPIS, 0));
            new.VALORBCPIS = new.QTDE;
        end
   if (new.cstcofins = '03') then
        begin
            new.VALORCOFINS = (cast(new.QTDE as numeric(15,4)) * coalesce(new.PERCCOFINS, 0));
            new.VALORBCCOFINS = new.QTDE;
        end
end

^
SET TERM ; ^

/*------ SYSDBA 25/02/2025 09:10:00 --------*/
CREATE GENERATOR GEN_TPETCONSULTAANEXO_ID;

/*------ SYSDBA 25/02/2025 09:10:00 --------*/
CREATE TABLE TPETCONSULTAANEXO (
    CONTROLE           INTEGER NOT NULL,
    CODCONSULTA        INTEGER NOT NULL,
    ANEXOLOCAL         VARCHAR(200),
    ANEXOFTP           VARCHAR(50),
    DATAEHORACADASTRO  TIMESTAMP NOT NULL
);

/*------ SYSDBA 25/02/2025 09:10:00 --------*/
ALTER TABLE TPETCONSULTAANEXO ADD CONSTRAINT PK_TPETCONSULTAANEXO PRIMARY KEY (CONTROLE);

/*------ SYSDBA 25/02/2025 09:10:00 --------*/
ALTER TABLE TPETCONSULTAANEXO ADD FOREIGN KEY (CODCONSULTA) REFERENCES TPETCONSULTA (CONTROLE);

/*------ SYSDBA 25/02/2025 09:10:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TPETCONSULTAANEXO_BI FOR TPETCONSULTAANEXO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_tpetconsultaanexo_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 25/02/2025 13:55:00 --------*/
ALTER TABLE TCONFIGURACOESGERAIS ADD IMPRIMIRCODBARRASDAV INTEGER DEFAULT 0;

/*------ SYSDBA 25/02/2025 15:43:00 --------*/
ALTER TABLE TCONFIGCOMANDA ADD AGRUPARITENSMESMAIMPRESSORA CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 03/03/2025 10:05:00 --------*/
CREATE GENERATOR GEN_TOSINFADICIONAL_ID;

/*------ SYSDBA 03/03/2025 10:05:00 --------*/
CREATE TABLE TOSINFADICIONAL (
    CONTROLE           INTEGER NOT NULL,
    CODOS              INTEGER NOT NULL,
    TIPOAPLICACAODESC  INTEGER
);

/*------ SYSDBA 03/03/2025 10:05:00 --------*/
ALTER TABLE TOSINFADICIONAL ADD CONSTRAINT PK_TOSINFADICIONAL PRIMARY KEY (CONTROLE);

/*------ SYSDBA 03/03/2025 10:05:00 --------*/
ALTER TABLE TOSINFADICIONAL ADD CONSTRAINT FK_TOSINFADICIONAL_1 FOREIGN KEY (CODOS) REFERENCES TOS (CONTROLE);

/*------ SYSDBA 03/03/2025 10:05:00 --------*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TOSINFADICIONAL_BI FOR TOSINFADICIONAL
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.controle is null) then
    new.controle = gen_id(gen_tosinfadicional_id,1);
end

^
SET TERM ; ^

/*------ SYSDBA 03/03/2025 10:05:00 --------*/
COMMENT ON COLUMN TOSINFADICIONAL.TIPOAPLICACAODESC IS '0 PRODUTOS, 1 SERVICOS e 2 TODOS';

/*------ SYSDBA 04/03/2025 15:10:00 --------*/
ALTER TABLE TOPERACAO ADD ICMSBASEDUPLA CHAR(1) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 10/03/2025 15:10:00 --------*/
CREATE INDEX idx_tcaixa_codnfce ON tcaixa (codnfce);

/*------ SYSDBA 10/03/2025 15:10:00 --------*/
CREATE INDEX idx_tcaixa_documento ON tcaixa (documento);

/*------ SYSDBA 10/03/2025 15:10:00 --------*/
CREATE INDEX idx_tcaixa_datahoracadastro ON tcaixa (datahoracadastro);

/*------ SYSDBA 13/03/2025 08:35:00 --------*/
ALTER TABLE TETIQUETA ADD TOPVALORAVISTA INTEGER;

/*------ SYSDBA 13/03/2025 08:35:00 --------*/
ALTER TABLE TETIQUETA ADD LEFTVALORAVISTA INTEGER;

/*------ SYSDBA 13/03/2025 08:35:00 --------*/
ALTER TABLE TETIQUETA ADD FONTEVALORAVISTA VARCHAR(100) COLLATE PT_BR;

/*------ SYSDBA 13/03/2025 08:35:00 --------*/
ALTER TABLE TETIQUETA ADD ESTILOVALORAVISTA VARCHAR(100) COLLATE PT_BR;

/*------ SYSDBA 13/03/2025 08:35:00 --------*/
ALTER TABLE TETIQUETA ADD TAMANHOVALORAVISTA INTEGER;

/*------ SYSDBA 17/03/2025 15:00:00 --------*/
ALTER TABLE TCONFIGNFCE ADD CODBENEFICIO VARCHAR(17) CHARACTER SET latin1 COLLATE PT_BR;

/*------ SYSDBA 20/03/2025 08:25:00 --------*/
ALTER TABLE TMESA ADD FECHARMESA INTEGER DEFAULT 0;
