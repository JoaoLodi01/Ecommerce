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
        
        if(res.success) return {
            status: true,
            message: 'success'
        };

    } catch (error) {
        console.error('Erro no AccessAdminService');
        console.table('error.response?.data.message', error.response?.data.message || error.response?.data || 'Erro no acesso de admin');
        console.table('error.response?.data', error.response?.data);

        const sqlMsg = 'SQLSTATE[23000]'
        const isSQLSTATE23000 = String(error.response?.data.message).split('').some(char => sqlMsg.includes(char))
        // Se tiver SQLSTATE[23000] - Vai estar true

        const message: string = isSQLSTATE23000 ? 'Erro interno, por favor contate o suporte técnico!' : error.response?.data.message || error.response?.data || 'Erro no acesso de admin';

        return {
            status: false,
            message: message
            
        };
    };
};
