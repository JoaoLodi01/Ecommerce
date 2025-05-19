const specialChars = '`!@#$^&;:?~';

const password = 'teste'

console.log(specialChars.split('').some(specialChars => password.includes(specialChars)))

