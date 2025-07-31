interface IReceiveBody {
    issuerID: number;
    receiveDocument?: number;
    document: number | string;
    customerID: number;
    userID: number;
    description?: string;
    installmentAmount: number;
    installmentNumber: number;
    installmentValue: number;
    installmentOriginal?: number;
    name?: string;
    especieID: number;
    especie: string;
    dueDate: string;
    paidDate: string;
    origem: string;
    typeInterest: string;
    interestValue: number;
    addition: number;
    discount: number;
    valueEntry: number;
    valuePaid: number;
    status: string;
    paid: boolean;
    installments: [];
}
