<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, usePage } from '@inertiajs/vue3';
import { watch } from 'vue';

const page = usePage();
const user = page.props.auth.user;

let active_store = page.props.auth.active_store != null ? page.props.auth.active_store : user.stores[0];

watch(page, () => {
    active_store = page.props.auth.active_store;
    console.log(active_store);
});

</script>

<template>
    <Head title="Kategoriler" />

    <AuthenticatedLayout>
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card bg-dark text-light">
                    <div class="card-header">
                        <button class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#createProductModal"><i class="fa-solid fa-plus"></i> Yeni Kategori</button>
                        <div class="modal" tabindex="-1" id="createProductModal">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Yeni Kategori Oluştur</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        //Creatae Category Component
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <table v-if="active_store.categories.length > 0" class="table table-responsive table-hover table-dark align-middle table-striped">
                            <thead>
                                <tr class="text-center">
                                    <th>#</th>
                                    <th>İsim</th>
                                    <th>Ürün Sayısı</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="category in active_store.categories" class="text-center">
                                    <td>{{ category.id }}</td>
                                    <td>{{ category.name }}</td>
                                    <td>{{ category.products.length }}</td>
                                    <td><div class="dropdown">
                                        <button class="btn btn-label-info" data-bs-toggle="dropdown"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <div class="dropdown-menu">
                                            <Link href="#" class="dropdown-item text-info"><i class="fa-solid fa-edit"></i> Düzenle</Link>
                                            <Link href="#" class="dropdown-item text-danger"><i class="fa-solid fa-trash"></i> Sil</Link>
                                        </div>
                                    </div></td>
                                </tr>
                            </tbody>
                        </table>
                        <div v-else class="alert alert-danger" role="alert">
                            <i class="fa-solid fa-warning me-2"></i>
                            Kategori Bulunamadı!
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
