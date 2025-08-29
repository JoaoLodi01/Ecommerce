SELECT
    mail.host, 
    mail.user_name, 
    mail.password, 
    mail.port

FROM 
    configs_email mail

WHERE
    mail.issuer_id = ?