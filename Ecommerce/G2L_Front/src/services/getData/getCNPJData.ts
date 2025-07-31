import axios from 'axios';

const resData = <IDataCNPJ>{
    alias: '',
    cnpj: '',
    cep: '',
    number: 0,
    address: ''

};

let errorMessage = <string> '';

async function getCNPJData(cnpj: string): Promise<IDataCNPJ|string>
{
    try {
        const res = await axios.get(`${process.env.API_CNPJ}/${cnpj}`);
        if(res)
        {
            resData.alias = res.data.alias;
            resData.cnpj = cnpj;
            resData.cep = res.data.address.zip;
            resData.number = Number(res.data.address.number);
            resData.address = res.data.address.street;
            return resData;

        };
        
    } catch (error) {
        console.error('Erro na busca do cep', error);

        error.response.data.constraints[0] === "taxId must be a string that obeys cnpj verification algorithm" ?
                                                errorMessage = 'CNPJ não encontrado ou inválido' :
                                                errorMessage = error.response.data.constraints;
        
        return errorMessage;
        
    };
};

export default getCNPJData;