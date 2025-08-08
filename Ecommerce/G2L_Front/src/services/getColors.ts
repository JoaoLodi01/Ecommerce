import { api } from "src/boot/axios";
import { LocalStorage } from "quasar";
import camelcaseKeys from "camelcase-keys";

async function getColors(issuerID: number)
{
    if(issuerID)
    {
        const res = await api.get(`/configs/all-configs/${issuerID}`);
        const data: TColorOptions = camelcaseKeys(res.data.data.color, { deep: true });

        if(res.data.success)
        {
            LocalStorage.set("buttonColor", data.buttonColor);
            LocalStorage.set("painelColor", data.painelColor);
            LocalStorage.set("textColor", data.textColor);

            
        };
    };
};

export default getColors;   