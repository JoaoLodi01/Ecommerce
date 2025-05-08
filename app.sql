select 
    nfe.naturezaoperacao as "Natureza",
	infe.produto as "Produto",
	infe.qtdecomercial as "Qtde",
	infe.precocustoitem as "Preço de custo",
	infe.totalprodutos as "Total dos produtos"
from
	titensvendanfe infe

inner join
	tvendanfe nfe on nfe.datacadastro = infe.datacadastro

where	
	nfe.datacadastro between '04-01-2025' and '04-30-2025' and
    infe.cfop = '1102'