import { api } from "src/boot/axios";
import { LocalStorage } from "quasar";
import camelcaseKeys from "camelcase-keys";

async function getColors(issuerID: number)
{
    if(issuerID)
    {
        const res = await api.get(`/configs/all-configs/${issuerID}`);
        const data: TColorOptions = camelcaseKeys(res.data.data.color, { deep: true });

        LocalStorage.set("buttonColor", data.buttonColor);
        LocalStorage.set("painelColor", data.painelColor);
    } else {
        return;
    };
};

export default getColors;   