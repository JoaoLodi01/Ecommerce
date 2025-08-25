-- Active: 1753726163326@@localhost@3345@hoteldb
SELECT
    isu.id,
    COALESCE(isu.company_name, isu.trade_name),
    COALESCE(isu.cnpj, isu.cpf),
    isu.`address`,
    isu.`number`,
    isu.city,
    isu.cep

FROM
    issuers isu
    
WHERE
    isu.id = ?