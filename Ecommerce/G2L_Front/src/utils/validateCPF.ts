function validateCPF (cpf: string): boolean
{
    cpf = cpf.replace(/\D/g, '');
    if(cpf.length !== 11)
    {
        return false;
    };

    const getFirstDigit = (incorretCPF: string) => 
    {
        let sum: number = 0;

        for(let i = 0; i < incorretCPF.length; i++)
        {
            let atualItem = incorretCPF.charAt(i);
            let constNumbers = (incorretCPF.length + 1 - i);

            sum += Number(atualItem) * constNumbers;
        };
        const rest = sum % 11;

        return rest < 2 ? "0" : (11 - rest).toString();
    };

    const firstDigit = getFirstDigit(cpf.substring(0, 9));
    const secondDigit = getFirstDigit(cpf.substring(0, 9) + firstDigit); 

    let correctCPF = cpf.substring(0, 9) + firstDigit + secondDigit;

    if(cpf !== correctCPF)
    {
        return false;
    } else {
        return true;

    };
};

export default validateCPF