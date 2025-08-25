SELECT
    MAX(mh.mail_histories_code)
FROM
    mail_histories mh

WHERE
    mh.issuer_id = ?