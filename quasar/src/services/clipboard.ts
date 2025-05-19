import ClipboardJS from "clipboard";

function clipBoard() {
    console.log('Copiando ...')
    const clipboard = new ClipboardJS('.btn')
    clipboard.on('success', function(e){
        console.info('Ação: ', e.action)
        console.info('Texto: ', e.text)
        clipboard.destroy()
    })

    clipboard.on('error', function (e) {
        console.error('Erro ao copiar', e)
        clipboard.destroy()
    })
    
}

export default clipBoard