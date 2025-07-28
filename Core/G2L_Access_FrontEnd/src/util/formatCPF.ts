export function formatCPFField(val: string): string 
{
    if(val === '') return ``;
    return val.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
}