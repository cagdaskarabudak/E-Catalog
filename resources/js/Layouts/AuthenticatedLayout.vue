<script setup>
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import { Link, usePage, useForm, router } from '@inertiajs/vue3';
import { ref, watch, inject, defineEmits } from 'vue';

const bsAlert = inject('bsAlert');

const page = usePage();
let user = page.props.auth.user;
let active_store = page.props.auth.user.active_store;

watch(page, ()=>{
    active_store = page.props.auth.user.active_store;
});

const active_store_form = useForm({
    new_active_store_id: active_store != null ? active_store.id : null,
});


const activestoreformsubmit = () => {
    active_store_form.post(route('active_store_change'), {
        onSuccess: () => {
            router.reload();
        }
    });
};

</script>
<template>
<!--<div class="alpagu-loader">
        <div class="loader spinner-border" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
        <ApplicationLogo></ApplicationLogo>
    </div>-->
    <div class="alerts"></div>
    <nav>
        <div class="navbar dashboard-nav">
            <div class="nav-item brand"><Link :href="route('dashboard')" :active="route().current('dashboard')"><ApplicationLogo /></Link></div>
            <div class="nav-item"><Link :href="route('dashboard')" :active="route().current('dashboard')">Ana Sayfa</Link></div>
            <div class="nav-item dropdown" v-if="active_store != null">
                <a href="Javascript:void(0);" :active="route().current('product.list') || route().current('category.list') || route().current('catalog.list')" class="dropdown-toggle" data-bs-toggle="dropdown"><i class="fa-solid fa-store"></i>&nbsp;{{ active_store.short_name }}</a>
                <div class="dropdown-menu">
                    <Link :href="route('product.list')" :active="route().current('product.list')" class="dropdown-item"><i class="fa-solid fa-objects-column"></i>&nbsp;Ürünler</Link>
                    <Link :href="route('category.list')" :active="route().current('category.list')" class="dropdown-item"><i class="fa-solid fa-list"></i>&nbsp;Kategoriler</Link>
                    <Link :href="route('catalog.list')" :active="route().current('catalog.list')" class="dropdown-item"><i class="fa-solid fa-layer-group"></i>&nbsp;Kataloglar</Link>
                </div>
            </div>
            <div class="nav-item dropdown" v-if="user.role_id == 1">
                <a href="Javascript:void(0);" :active="route().current('admin.product.list') || route().current('admin.category.list') || route().current('admin.catalog.list') || route().current('admin.user.list') || route().current('admin.store.list')" class="dropdown-toggle" data-bs-toggle="dropdown"><i class="fa-solid fa-store"></i>&nbsp;Admin</a>
                <div class="dropdown-menu">
                    <Link :href="route('admin.user.list')" :active="route().current('admin.user.list')" class="dropdown-item"><i class="fa-solid fa-users"></i>&nbsp;Kullanıcılar</Link>
                    <Link :href="route('admin.store.list')" :active="route().current('admin.store.list')" class="dropdown-item"><i class="fa-solid fa-store"></i>&nbsp;Mağazalar</Link>
                    <Link :href="route('admin.product.list')" :active="route().current('admin.product.list')" class="dropdown-item"><i class="fa-solid fa-objects-column"></i>&nbsp;Ürünler</Link>
                    <Link :href="route('admin.category.list')" :active="route().current('admin.category.list')" class="dropdown-item"><i class="fa-solid fa-list"></i>&nbsp;Kategoriler</Link>
                    <Link :href="route('admin.catalog.list')" :active="route().current('admin.catalog.list')" class="dropdown-item"><i class="fa-solid fa-layer-group"></i>&nbsp;Kataloglar</Link>
                </div>
            </div>
        </div>
        <div class="navbar user-nav">
            <div class="nav-item active_store_select" v-if="active_store != null">
                <div class="input-group">
                    <div class="input-group-text">
                        <i class="fa-solid fa-store"></i>
                    </div>
                    <select class="form-select" v-model="active_store_form.new_active_store_id" @change="activestoreformsubmit()">
                        <option v-for="store in user.stores" :key="store.id" :value="store.id">{{ store.short_name }}</option>
                    </select>
                </div>
            </div>
            <div class="nav-item dropdown">
                <a href="Javascript:void(0);" :active="route().current('profile.edit')" class="dropdown-toggle" data-bs-toggle="dropdown">{{ $page.props.auth.user.name }}<span :class="`position-absolute bottom-0 start-50 translate-middle badge bg-${$page.props.auth.user.role.color}`">{{ $page.props.auth.user.role.tr_name }}</span></a>
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
