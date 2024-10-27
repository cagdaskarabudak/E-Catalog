import '../sass/app.sass';
import './bootstrap';
import 'alpagu-icons';

import { createInertiaApp } from '@inertiajs/vue3';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
import { createApp, h } from 'vue';
import { ZiggyVue } from '../../vendor/tightenco/ziggy';
import 'bootstrap';
import { Alert } from 'bootstrap';

const appName = import.meta.env.VITE_APP_NAME || 'Alpagu';

const bsAlert = (color, message, time = 3000) => {
    let alert = document.createElement('div');
    alert.classList.add('alert');
    alert.classList.add('alert-'+color);
    alert.classList.add('alert-dismissible');
    alert.classList.add('fade');
    alert.classList.add('show');
    alert.setAttribute('role', 'alert');

    let alertButton = document.createElement('button');
    alertButton.setAttribute('type', 'button');
    alertButton.classList.add('btn-close');
    alertButton.setAttribute('data-bs-dismiss', 'alert');
    alertButton.setAttribute('aria-label', 'Close');

    alert.innerHTML = message;
    alert.append(alertButton);

    let alertsdiv = document.querySelector('.alerts');
    alertsdiv.append(alert);

    let bsAlert = new Alert(alert);

    setTimeout(()=>{
        bsAlert.close();
    }, time);

};

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) =>
        resolvePageComponent(
            `./Pages/${name}.vue`,
            import.meta.glob('./Pages/**/*.vue'),
        ),
    setup({ el, App, props, plugin }) {
        const app = createApp({ render: () => h(App, props) });
            app.provide('bsAlert', bsAlert);
            app.use(plugin)
                .use(ZiggyVue)
                .mount(el);
    },
    progress: {
        color: '#696cff',
    },
});
