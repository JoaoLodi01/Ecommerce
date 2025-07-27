import axios from "axios";
import { useQuasar } from "quasar";

const $q = useQuasar();

export async function createCustomerInAccess(data: ICustomerData): Promise<boolean>
{
    try {
        const accessCreateRes = await axios.post(`/customers/create`, {
            fullName: data.fullName,
            email: data.email,
            cpf: data.cpf,
        }, {
            headers: {
                Accept: 'application/json'
            }
        });

        const res = accessCreateRes.data;
        
        if(res.success) return true;

    } catch (error) {
        const message: string = error.response?.message || error.response || 'Erro no acesso de admin';
        $q.notify({
            color: 'red',
            message: message,
            position: 'top',
            timeout: 1500

        });

        return false;
    };
};
