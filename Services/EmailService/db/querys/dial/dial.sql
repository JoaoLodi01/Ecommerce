SELECT
    mail.host,
    mail.user_name,
    mail.password,
    mail.port,
    '' AS `from`,
    '' AS `to`,
    '' AS `subject`,
    '' AS `message`

FROM 
    configs_email mail

WHERE
    mail.issuer_id = ?