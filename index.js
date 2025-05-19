const makeWASocket = require('@whiskeysockets/baileys').default;
const { useMultiFileAuthState, DisconnectReason } = require('@whiskeysockets/baileys');
const { Boom } = require('@hapi/boom');
const qrcode = require('qrcode');
const express = require('express');
const path = require('path');
const fs = require('fs'); 

const app = express();
const PORT = process.env.PORT || 3010;

app.use(express.json());

let sock = null; // Variável global para o socket
let connectionStatus = 'disconnected'; // Status da conexão
let currentQR = null; // QR Code atual

async function connectToWhatsApp() {
    if (sock && connectionStatus === 'connected') {
        return { status: 'already_connected' };
    }

    const { state, saveCreds } = await useMultiFileAuthState(path.join(__dirname, 'auth_info_baileys'));

    sock = makeWASocket({
        auth: state,
        printQRInTerminal: false
    });

    sock.ev.on('creds.update', saveCreds);

    sock.ev.on('connection.update', (update) => {
        const { connection, lastDisconnect, qr } = update;

        if (qr) {
            // Armazena o QR Code como Data URL
            qrcode.toDataURL(qr, (err, url) => {
                if (err) {
                    console.error('Erro ao gerar QR Code:', err);
                } else {
                    currentQR = url;
                    console.log('QR Code gerado e armazenado.');
                }
            });
        }

        if (connection === 'close') {
            const shouldReconnect = lastDisconnect && lastDisconnect.error && lastDisconnect.error.output && lastDisconnect.error.output.statusCode !== DisconnectReason.loggedOut;
            console.log('Conexão fechada devido a', lastDisconnect ? lastDisconnect.error : 'erro desconhecido', ', reconectando', shouldReconnect);
            connectionStatus = 'disconnected';
            if (shouldReconnect) {
                connectToWhatsApp();
            }
        } else if (connection === 'open') {
            console.log('Conexão estabelecida');
            connectionStatus = 'connected';
            currentQR = null; // Limpa o QR Code após a conexão
        }
    });

    // Escuta para mensagens recebidas
    // sock.ev.on('messages.upsert', async (m) => {
    //     console.log(JSON.stringify(m, undefined, 2));

    //     const message = m.messages[0];

    //     // Verifica se a mensagem foi enviada pelo próprio bot
    //     if (!message.key.fromMe) {
    //         const remoteJid = message.key.remoteJid;
    //         if (remoteJid) {
    //             console.log('Respondendo para', remoteJid);
    //             await sock.sendMessage(remoteJid, { text: 'Olá! Esta é uma mensagem automática.' });
    //         }
    //     }
    // });

    return { status: 'connecting' };
}
app.get('/status-con-wpp', (req, res) => {
    res.json({ status: connectionStatus});
});
// Rota GET para iniciar a conexão e obter o QR Code
app.get('/connect', async (req, res) => {
    try {
        const connectionInfo = await connectToWhatsApp();

        if (connectionInfo.status === 'already_connected') {
            return res.status(200).json({ status: 'Já conectado' });
        }

        // Espera até que o QR Code seja gerado ou a conexão seja estabelecida
        const waitForQR = () => {
            return new Promise((resolve, reject) => {
                const checkQR = () => {
                    if (currentQR) {
                        resolve(currentQR);
                    } else if (connectionStatus === 'connected') {
                        resolve(null); // Conexão estabelecida sem necessidade de QR
                    } else {
                        setTimeout(checkQR, 500);
                    }
                };
                checkQR();
            });
        };

        const qr = await waitForQR();

        if (qr) {
            res.status(200).json({ status: 'Aguardando autenticação', qr });
        } else if (connectionStatus === 'connected') {
            res.status(200).json({ status: 'Conectado com sucesso' });
        } else {
            res.status(500).json({ status: 'Erro na conexão' });
        }
    } catch (error) {
        console.error('Erro na rota /connect:', error);
        res.status(500).json({ error: 'Erro ao conectar ao WhatsApp' });
    }
});

// Rota para enviar mensagem via API
app.post('/send-message', async (req, res) => {
    const { number, message } = req.body;
    if (!number || !message) {
        return res.status(400).json({ error: 'Número e mensagem são obrigatórios' });
    }

    if (!sock || connectionStatus !== 'connected') {
        return res.status(400).json({ error: 'Não conectado ao WhatsApp' });
    }

    try {
        // Tratar a mensagem para substituir \n por o caractere de quebra de linha correto
        const mensagemTratada = message.replace(/\\n/g, '\n');

        // Verifica o número como ele foi recebido
        let [result] = await sock.onWhatsApp(number);

        // Se não encontrar ou se o contato não parecer correto, tenta com o "9"
        let numberWithNine = null;
        if (!result || !result.exists || result.jid !== `${number}@s.whatsapp.net`) {
            // Tenta adicionar o "9" no lugar correto
            numberWithNine = number.replace(/^(55\d{2})(\d{8})$/, '$19$2');
            [result] = await sock.onWhatsApp(numberWithNine);
        }

        // Se encontrar o número correto (com ou sem o "9")
        if (result && result.exists) {
            const jid = result.jid;  // JID correto para envio da mensagem
            await sock.sendMessage(jid, { text: mensagemTratada });
            return res.status(200).json({ status: 'Mensagem enviada com sucesso' });
        }

        // Se nenhum dos números for encontrado
        res.status(400).json({ error: 'Número não encontrado no WhatsApp' });
    } catch (error) {
        console.error('Erro ao enviar mensagem:', error);
        return res.status(500).json({ error: 'Erro ao enviar mensagem' });
    }
});


app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
});
