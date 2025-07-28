interface ICustomers
{
    code: string,
    fullName: string,
    email: string,
    cpf: string,

    // liberações
    activeLicense: string,
    expireLicense: string,
    hotel: boolean,
    ecommerce: boolean,
    site: boolean,
    active: boolean,

    monthlyFee: number|string,
    companies: number,
    
};