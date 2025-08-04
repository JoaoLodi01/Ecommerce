import { QrCodePix } from 'qrcode-pix';

type Issuer = {
    companyName: string,
    city: string,
    cep: string
};

async function generatePIX(
        totalOperation: number, 
        pix_key: string,
        issuer: Issuer
) {
    const qrCodePix = QrCodePix({
        version: '01',
        key: pix_key, 
        name: issuer.companyName,
        city: issuer.city,
        transactionId: 'TX123456789',
        message: 'Volte sempre!',
        cep: issuer.cep,
        value: totalOperation,
    });

    let payload = qrCodePix.payload();
    const base64 = await qrCodePix.base64();
    
    return {
        base64,
        payload,
        
    };
};

export default generatePIX
