function sumDigits(number = 0) 
{
    let sNumber =  number.toString().split('')
    let total = 0
    sNumber.map((v, i) => console.log(v))
    return sNumber
}

console.log(sumDigits(99))