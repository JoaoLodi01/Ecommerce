interface IPayBody
{
    toPayCode?: number,
    issuerID: number,
    document: number,
    description?: string,
    chartOfAccountCode: number,
    costCenterCode: number,
    customerID: number,
    name?: string,
    davCode?: number,
    especieID: number,
    especie: string,
    userID: number,
    user: string,
    dueDate: string,
    installmentAmount?: number;
    installmentNumber: number,
    installmentValue: number,
    typeInterest?: string,
    interestValue?: number,
    totalAmount?: number,
    origem: string,
    addition: number,
    discount: number,
    valueEntry: number,
    valueToPay: number,
    valueOriginal: number,
    canceld?: boolean

};