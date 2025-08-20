SELECT
    pdv.pdv_code "N° nota",

    CASE pdv.is_nfce_nm 
        WHEN 'nm' THEN "Nota Manual"  
        ELSE "Venda NFC-e"
    END "Venda",

    pdv.description "Descrição",
    pdv.net_value "Total líquido"

FROM
    pdvs pdv

WHERE
    pdv.finished = 1 AND
    pdv.canceled <> 1