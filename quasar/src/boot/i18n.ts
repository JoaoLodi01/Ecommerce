import { createI18n } from "vue-i18n";
import ptBR from "src/i18n/pt-BR";

const messages = {
    'pt-BR': ptBR
};

const i18n = createI18n({
   locale: 'pt-BR',
   fallbackLocale: 'en-US',
   messages 
});

export default i18n;