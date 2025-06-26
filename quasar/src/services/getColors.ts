import { api } from "src/boot/axios";

async function getColors(issuerID: number) 
{
    const res = await api.get();
}

export default getColors;