-- Active: 1753726163326@@localhost@3345@hoteldb
SELECT
    `issuer`.id,
    COALESCE(`issuer`.company_name, `issuer`.trade_name),
    COALESCE(`issuer`.cnpj, `issuer`.cpf),
    `issuer`.`address`,
    `issuer`.`number`,
    `issuer`.city,
    `issuer`.cep

FROM
    issuers `issuer`
    
WHERE
    `issuer`.id = ?