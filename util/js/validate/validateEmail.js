function validateEmail(email) 
{
    const pos = email.split('@')[1];
    
    if(email.split('').includes('@') && pos.length >= 3)
    {
        return 'Válido';

    } else {
        return 'Inválido';

    };
};

const email = 'gabikochem55@gmail.com';
const validate = validateEmail(email);

console.log(validate);