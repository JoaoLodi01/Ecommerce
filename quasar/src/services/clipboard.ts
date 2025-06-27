import ClipboardJS from "clipboard";

function clipBoard() {
    return new Promise((resolve, reject) => {    
        const clipboard = new ClipboardJS('.btn')
        clipboard.on('success', function(){
            clipboard.destroy();
            resolve(true);
        });

        clipboard.on('error', function (e) {
            console.error('Erro ao copiar', e)
            clipboard.destroy();
            reject(false);
        });

    });
};

export default clipBoard;