import axios from 'axios'

const resData = <IDataCEP>{
    cep: '',
    addres: '',
    uf: '',
    city: ''
}

let errorMessage = <string> '';

async function getCEPData(cep: string): Promise<IDataCEP|string>
{
    const res = await axios.get(`${process.env.API_CEP}/${cep}/json`);

    if(res.data.erro !== 'true')
    {
        resData.cep = cep;
        resData.addres = res.data.logradouro;
        resData.uf = res.data.uf;
        resData.city = res.data.localidade;
        return resData;;
    };

    if(res.data.erro === 'true')
    {
        errorMessage = 'CEP não encontrado'
        return errorMessage;
    };
};

export default getCEPData;