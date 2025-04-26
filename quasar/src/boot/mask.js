import { boot } from 'quasar/wrappers';
import { VueTheMask } from 'vue-the-mask';

export default boot(({ app }) => {
  app.use(VueTheMask);
});