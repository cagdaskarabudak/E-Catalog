<script setup>
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import { Link, usePage, useForm, router } from '@inertiajs/vue3';
import { watch } from 'vue';


const page = usePage();

let user = page.props.auth.user;
let active_store = page.props.auth.active_store != null ? page.props.auth.active_store : user.stores[0];

watch(page, () => {
    active_store = page.props.auth.active_store;
});

const form = useForm({
    active_store: active_store != undefined ? active_store.id : user.stores[0].id
});

const activestoreformsubmit = () => {
    form.post(route('active_store_change'));
};

</script>

<template>
    <div class="alerts"></div>
    <nav>
        <div class="navbar dashboard-nav">
            <div class="nav-item brand"><Link :href="route('dashboard')" :active="route().current('dashboard')"><ApplicationLogo /></Link></div>
            <div class="nav-item"><Link :href="route('dashboard')" :active="route().current('dashboard')">Ana Sayfa</Link></div>
            <div class="nav-item dropdown">
                <a href="Javascript:void(0);" :active="route().current('products') || route().current('categories')" class="dropdown-toggle" data-bs-toggle="dropdown">Mağaza</a>
                <div class="dropdown-menu">
                    <Link :href="route('products.list')" :active="route().current('products')" class="dropdown-item">Ürünler</Link>
                    <Link :href="route('categories.list')" :active="route().current('categories')" class="dropdown-item">Kategoriler</Link>
                </div>
            </div>
        </div>
        <div class="navbar user-nav">
            <div class="nav-item">
                <div class="input-group">
                    <div class="input-group-text">
                        <i class="fa-solid fa-store"></i>
                    </div>
                    <select class="form-select" v-model="form.active_store" @change="activestoreformsubmit()">
                        <option v-for="store in user.stores" :key="store.id" :value="store.id">{{ store.short_name }}</option>
                    </select>
                </div>
            </div>
            <div class="nav-item dropdown">
                <a href="Javascript:void(0);" :active="route().current('profile.edit')" class="dropdown-toggle" data-bs-toggle="dropdown">{{ $page.props.auth.user.name }}</a>
                <div class="dropdown-menu">
                    <Link :href="route('profile.edit')" :active="route().current('profile.edit')" class="dropdown-item">Profil</Link>
                    <Link method="POST" :href="route('logout')" as="button" class="dropdown-item">Çıkış Yap</Link>
                </div>
            </div>
        </div>
    </nav>
    <div class="auth-layout">
        <div class="container">

            <slot />
        </div>
    </div>
    <footer>
        Copyright &copy; {{ new Date().getFullYear() }} Alpagu Development | Tüm Hakları Saklıdır.
    </footer>
</template>
