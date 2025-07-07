interface IReceiveBody
{
    issuerID: number,
    receiveCod?: number,
    document: number|string,
    customerID: number,
    userID: number,
    description?: string,
    installmentNumber: number,
    installmentValue : number,
    name?: string,
    especieID: number,
    especie: string,
    dueDate: string,
    origem: string,
    typeInterest: string,
    interestValue: number,
    addition: number,
    discount: number,
    valueEntry: number,
    valuePaid: number,
    valueOriginal: number,
    
};

// interface IReceiveBody
// {
//     issuer_id: number,
//     description: string,
//     document: number,
//     customer_id: number,
//     user_id: number,
//     especie_id: number,
//     especie: string,
//     due_date: string,
//     installment_number: number,
//     installment_value: number,
//     type_interest: string,
//     interest_value: number,
//     addition: number,
//     discount: number,
//     value_entry: number,
//     value_paid: number,
//     value_original: number,
//     origem: string

// }