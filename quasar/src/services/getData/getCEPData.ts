import axios from 'axios'

const resData = <IDataCEP>{
    cep: '',
    addres: ''
}

let errorMessage = <string> '';

async function getCEPData(cep: string): Promise<IDataCEP|string>
{
    const res = await axios.get(`${process.env.API_CEP}/${cep}/json`);

    if(res.data.erro !== 'true')
    {
        console.log('getCEPData: res ', res.data, ' res.status: ', res.status);
        resData.cep = cep;
        resData.addres = res.data.logradouro;
        return resData;;
    };

    if(res.data.erro === 'true')
    {
        errorMessage = 'Erro na busca do CEP'
        return errorMessage;
    };
};

export default getCEPData;