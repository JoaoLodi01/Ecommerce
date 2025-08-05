import axios from "axios";

export async function createCustomerInAccess(data: ICustomerData)
{
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
        
        if(res.success) return {
            status: true,
            message: 'success'
        };

    } catch (error) {
        console.error('Erro no AccessAdminService');
        console.error('error.response?.data.message', error.response?.data.message || error.response?.data || 'Erro no acesso de admin');
        const message: string = error.response?.data.message || error.response?.data || 'Erro no acesso de admin';

        return {
            status: false,
            message: message
            
        };
    };
};
