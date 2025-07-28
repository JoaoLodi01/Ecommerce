import { apiAccess } from "src/boot/axios";
import { LocalStorage } from "quasar";

type TLiberations = {
    hotel: boolean,
    site: boolean,
    ecommerce: boolean
}

export async function getLiberations(issuerID: number): Promise<boolean>
{
    if(!issuerID)
    {
        return false;

    } else {
        const res = await apiAccess.get(`/customers/liberations/${issuerID}`);
        const data: TLiberations = res.data.data;
        console.log(data);
        LocalStorage.set("liberationHotel", data.hotel);
        LocalStorage.set("liberationEcommerce", data.ecommerce);
        LocalStorage.set("liberationSite", data.site);
        
        return true;
    };
};