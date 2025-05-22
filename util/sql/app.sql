select
    tes.controle as "Controle",
    sum(tes.qtde) as "Qtde total"

from
    testoque tes

group by
    tes.controle