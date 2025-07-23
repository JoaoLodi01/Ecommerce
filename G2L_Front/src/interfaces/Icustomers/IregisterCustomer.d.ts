interface IRegisterCustomer
{
    customer_type?: string,
    company_name: string,
    trade_name: string,
    cpf: string,
    cnpj: string,
    cep: string,
    uf: string,
    im: string,
    ie: string,
    address: string,
    number: number|string,
    is_customer: boolean,
    is_driver: boolean,
    is_supplier: boolean,
    phone: string,
    issuer_id: number

};