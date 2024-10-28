<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, usePage, Link } from '@inertiajs/vue3';
const all_catalogs = usePage().props.catalogs;
</script>
<template>
    <Head title="Tüm Kataloglar" />
    <AuthenticatedLayout>
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card bg-dark text-light">
                    <div class="card-body">
                        <table v-if="all_catalogs.length > 0" class="table table-responsive table-hover table-dark align-middle table-striped">
                            <thead>
                                <tr class="text-center">
                                    <th>ID</th>
                                    <th>Başlık</th>
                                    <th>Açıklama</th>
                                    <th>Tarih</th>
                                    <th>Mağaza</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="catalog in all_catalogs" class="text-center">
                                    <td>#{{ catalog.id }}</td>
                                    <td>{{ catalog.title }}</td>
                                    <td>{{ catalog.description }}</td>
                                    <td>{{ new Date(catalog.created_at).toLocaleString() }}</td>
                                    <td>{{ catalog.store.short_name }}(#{{ catalog.store.id }})</td>
                                    <td><div class="dropdown">
                                        <button class="btn btn-label-info" data-bs-toggle="dropdown"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <div class="dropdown-menu">
                                            <Link :href="route('catalog.edit', catalog.id)" class="dropdown-item text-info"><i class="fa-solid fa-edit"></i> Düzenle</Link>
                                            <div class="dropdown-item text-danger"><i class="fa-solid fa-trash"></i> Sil</div>
                                        </div>
                                    </div></td>
                                </tr>
                            </tbody>
                        </table>
                        <div v-else class="alert alert-danger text-center" role="alert">
                            <i class="fa-solid fa-warning me-2"></i>
                            Katalog Bulunamadı!
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>