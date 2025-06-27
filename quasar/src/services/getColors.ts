import { api } from "src/boot/axios";
import camelcaseKeys from "camelcase-keys";
import { LocalStorage } from "quasar";

async function getColors(issuerID: number)
{
    console.log('Chamou o getColors');
    const res = await api.get(`/configs/all-configs/${issuerID}`);
    const data: TColorOptions = camelcaseKeys(res.data.data.color[0], { deep: true });

    LocalStorage.set("buttonColor", data.buttonColor);
    LocalStorage.set("painelColor", data.painelColor);

}

export default getColors;