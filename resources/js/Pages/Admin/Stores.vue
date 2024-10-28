<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, usePage } from '@inertiajs/vue3';
const all_stores = usePage().props.stores;
</script>
<template>
    <Head title="Tüm Mağazalar" />
    <AuthenticatedLayout>
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card bg-dark text-light">
                    <div class="card-body">
                        <table v-if="all_stores.length > 0" class="table table-responsive table-hover table-dark align-middle table-striped">
                            <thead>
                                <tr class="text-center">
                                    <th>ID</th>
                                    <th>İsim</th>
                                    <th>Kısa İsim</th>
                                    <th>Ürünler</th>
                                    <th>Kategoriler</th>
                                    <th>Kataloglar</th>
                                    <th>Tarih</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="store in all_stores" class="text-center">
                                    <td>#{{ store.id }}</td>
                                    <td>{{ store.name }}</td>
                                    <td>{{ store.short_name }}</td>
                                    <td>{{ store.products.length }}</td>
                                    <td>{{ store.categories.length }}</td>
                                    <td>{{ store.catalogs.length }}</td>
                                    <td>{{ new Date(store.created_at).toLocaleString() }}</td>
                                    <td><div class="dropdown">
                                        <button class="btn btn-label-info" data-bs-toggle="dropdown"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <div class="dropdown-menu">
                                            <Link href="#" class="dropdown-item text-info"><i class="fa-solid fa-edit"></i> Düzenle</Link>
                                            <div class="dropdown-item text-danger"><i class="fa-solid fa-trash"></i> Sil</div>
                                        </div>
                                    </div></td>
                                </tr>
                            </tbody>
                        </table>
                        <div v-else class="alert alert-danger text-center" role="alert">
                            <i class="fa-solid fa-warning me-2"></i>
                            Mağaza Bulunamadı!
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>