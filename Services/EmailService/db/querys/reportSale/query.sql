SELECT
    pdv.pdv_code,
    pdv.is_nfce_nm,
    pdv.description,
    pdv.net_value

FROM
    pdvs pdv

WHERE
    pdv.finished = 1 AND
    pdv.canceled <> 1