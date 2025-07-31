import axios from "axios";
import { useQuasar } from "quasar";

export async function createCustomerInAccess(data: ICustomerData): Promise<boolean>
{
    const $q = useQuasar();
    const apiAccess = process.env.API_ACCESS_URL;
    try {
        const accessCreateRes = await axios.post(`${apiAccess}/customers/create`, {
            fullName: data.fullName,
            email: data.email,
            cpf: data.cpf,
        }, {
            headers: {
                Accept: 'application/json'
            }
        });

        const res = accessCreateRes.data;

        console.log('in createCustomerInAccess: ', res);
        
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
