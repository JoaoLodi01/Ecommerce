import axios from 'axios'

const resData = <IDataCEP>{
    cep: '',
    addres: ''
}

async function getCEPData(cep: string): Promise<IDataCEP>
{
    const res = await axios.get(`${process.env.API_CEP}/${cep}/json`);

    if(res)
    {
        console.log('getCEPData: res ', res, ' res.status: ', res.status);
        resData.cep = cep;
        resData.addres = res.data.logradouro;
        
    };

    return resData;
};

export default getCEPData;