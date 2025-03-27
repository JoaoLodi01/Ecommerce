import { createApp, h } from 'vue';
import { createInertiaApp } from '@inertiajs/vue3';

createInertiaApp({
    resolve: name => require(`./pages/${name}`).default,
    setup({ el, App, props }) {
        createApp({ render: () => h(App, props) }).mount(el);
    },
});