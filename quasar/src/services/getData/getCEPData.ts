import axios from 'axios'

const resData = <IDataCEP>{
    cep: '',
    addres: ''
}

async function getCEPData(cep: string): Promise<IDataCEP>
{
    const fomratedCEP = cep.replace(/\D/g, '');
    const res = await axios.get(`${process.env.API_CEP}/${fomratedCEP}/json`);

    if(res)
    {
        resData.cep = fomratedCEP;
        resData.cep = res.data.logradouro;

    };

    return resData;
};

export default getCEPData;