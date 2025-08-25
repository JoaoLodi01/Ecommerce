SELECT
    pdv.pdv_code,
    pdv.is_nfce_nm,
    pdv.customer,
    pdv.created_at,
    pdv.description,
    pdv.net_value

FROM
    pdvs pdv

WHERE
    pdv.finished = 1 AND
    pdv.canceled <> 1 AND
    pdv.issuer_id = ?