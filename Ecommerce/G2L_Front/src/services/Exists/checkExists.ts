import { api } from "src/boot/axios";

function formateCPF(cpf: string): string
{
    return cpf.replace(/\D/g, '');    
};

async function checkExistsCPF(cpf: string): Promise<boolean>
{
    const formatedCPF = formateCPF(cpf);

    if(formatedCPF.length === 11) 
    {
        const res = await api.get(`/registers/owner/last-cpf/${formatedCPF}`);
        const exists = res.data;
        
        if(!exists.data)
        {
            return false;

        } else {
            return true;
        };
    };
};

async function checkIssuerExistsCPF(cpf: string): Promise<boolean>
{
    const formatedCPF = formateCPF(cpf);

    if(formatedCPF.length === 11) 
    {
        const res = await api.get(`/registers/issuer/last-cpf/${formatedCPF}`);
        const exists = res.data;

        console.log(exists)

        if(!exists.data)
        {
            return false;

        } else {
            return true;    
        };
    };
};

export default { checkExistsCPF, checkIssuerExistsCPF }