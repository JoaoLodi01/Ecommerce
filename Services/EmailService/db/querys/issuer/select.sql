-- Active: 1753726163326@@localhost@3345@hoteldb
SELECT
    isu.id,
    COALESCE(isu.company_name, isu.trade_name),
    COALESCE(isu.cnpj, isu.cpf),
    COALESCE(isu.`address`, 'Sem endereço informad'),
    COALESCE(isu.`number`, 'Sem número informado'),
    COALESCE(isu.city, 'Sem cidade informada'),
    COALESCE(isu.cep, 'Sem CEP informado')

FROM
    issuers isu
    
WHERE
    isu.id = ?