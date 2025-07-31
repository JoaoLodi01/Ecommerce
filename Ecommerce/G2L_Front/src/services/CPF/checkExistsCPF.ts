import { api } from "src/boot/axios";
import { useQuasar } from "quasar";

async function checkExistsCPF(cpf: string): Promise<boolean>
{
    const $q = useQuasar();
    const formatedCPF = cpf.replace(/\D/g, '');    
    if(formatedCPF.length === 11) 
    {
        const res = await api.get(`/registers/owner/last-cpf/${formatedCPF}`);
        const exists = res.data;
        
        if(!exists.data)
        {
            return false;

        } else {
            $q.notify({
                color: 'red',
                message: 'CPF já cadastrado!',
                position: 'top',
                timeout: 1800
            });
            return true;
        };
    };
};

export default checkExistsCPF;