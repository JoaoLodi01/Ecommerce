import { QrCodePix } from 'qrcode-pix';

async function generatePIX(totalOperation: number, pix_key: string) {

    const qrCodePix = QrCodePix({
        version: '01',
        key: pix_key, 
        name: 'Fulano de Tal',
        city: 'SAO PAULO',
        transactionId: 'TX123456789',
        message: 'Teste',
        cep: '99999999',
        value: totalOperation,
    });

    let payload = qrCodePix.payload()
    console.log('Payload PIX:\n', payload);

    const base64 = await qrCodePix.base64();
    console.log('\nQR Code base64:\n', base64);
    return {
        base64,
        payload,
        
    }

}

export default generatePIX
