interface IPayBody
{
    issuerID: number,
    toPayCode?: number,
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
    addition: number,
    discount: number,
    valueEntry: number,
    valueToPay: number,
    valueOriginal: number,
    installmentAmount?: number;
    installmentOriginal?: number;

};