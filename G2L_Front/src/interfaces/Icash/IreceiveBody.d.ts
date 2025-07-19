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
    installmentAmount?: number;
    installmentOriginal?: number;
    
};
