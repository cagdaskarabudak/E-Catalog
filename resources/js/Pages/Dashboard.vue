<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, usePage } from '@inertiajs/vue3';
import { watch } from 'vue';

const page = usePage();
const user = page.props.auth.user;

let active_store = page.props.auth.active_store != null ? page.props.auth.active_store : user.stores[0];

watch(page, () => {
    active_store = page.props.auth.active_store;
});

console.log(active_store);


</script>

<template>
    <Head title="Yönetim Paneli" />

    <AuthenticatedLayout>
        <div class="row justify-content-center">
            <h5><span class="text-success">Aktif Mağaza: </span> {{ active_store.short_name }}</h5>
            <h6><span class="text-secondary">Rol: </span>{{ active_store.role.name }}</h6>
            <div class="col-lg-auto mb-3">
                <div class="card bg-primary text-center">
                    <div class="card-header">
                        <div class="card-title">Ürünler</div>
                    </div>
                    <div class="card-body">
                        <h1 class="card-text">{{ active_store.products.length }}</h1>
                    </div>
                    <Link :href="route('products.list')" class="card-footer">Tüm Ürünleri Gör</Link>
                </div>
            </div>
            <div class="col-lg-auto mb-3">
                <div class="card bg-warning text-center">
                    <div class="card-header">
                        <div class="card-title">Kategoriler</div>
                    </div>
                    <div class="card-body">
                        <h1 class="card-text">{{ active_store.categories.length }}</h1>
                    </div>
                    <Link :href="route('categories.list')" class="card-footer">Tüm Kategorileri Gör</Link>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
