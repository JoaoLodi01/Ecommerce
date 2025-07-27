const cep = '89711226'

console.log(cep.replace(/(\d{5})(\d{3})/, '$1-$2'));