import { QrCodePix } from 'qrcode-pix';

type Issuer = {
    company_name: string,
    cep: string
}

async function generatePIX(
        totalOperation: number, 
        pix_key: string,
        issuer: Issuer
) {
    const qrCodePix = QrCodePix({
        version: '01',
        key: pix_key, 
        name: issuer.company_name,
        city: 'SAO PAULO',
        transactionId: 'TX123456789',
        message: 'Isso ai',
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
