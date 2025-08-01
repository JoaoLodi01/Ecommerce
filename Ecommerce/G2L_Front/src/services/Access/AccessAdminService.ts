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
        console.error('Erro no AccessAdminService', error.response);
        const message: string = error.response?.message || error.response || error.response?.data.message || 'Erro no acesso de admin';

        return {
            status: false,
            message: message
            
        };
    };
};
