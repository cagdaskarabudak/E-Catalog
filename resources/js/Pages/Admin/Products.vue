<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, usePage } from '@inertiajs/vue3';
const all_products = usePage().props.products;
</script>
<template>
    <Head title="Tüm Ürünler" />
    <AuthenticatedLayout>
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card bg-dark text-light">
                    <div class="card-body">
                        <table v-if="all_products.length > 0" class="table table-responsive table-hover table-dark align-middle table-striped">
                            <thead>
                                <tr class="text-center">
                                    <th>ID</th>
                                    <th>İsim</th>
                                    <th>Perakende Fiyatı</th>
                                    <th>Toptan Fiyatlar</th>
                                    <th>Kategoriler</th>
                                    <th>Mağaza</th>
                                    <th>Tarih</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="product in all_products" class="text-center">
                                    <td>#{{ product.id }}</td>
                                    <td>{{ product.name }}</td>
                                    <td>{{ product.retail_price }} ₺</td>
                                    <td>
                                        <ul style="list-style-type: none; padding: 0;">
                                            <li v-for="wholesale_price in product.wholesale_prices">{{ wholesale_price.price + '₺' + ' / ' + wholesale_price.min_count + ' Adet' }}</li>
                                        </ul>
                                    </td>
                                    <td>
                                        <ul style="list-style-type: none; padding: 0;">
                                            <li v-for="category in product.categories">
                                                {{ category.name }}
                                            </li>
                                        </ul>
                                    </td>
                                    <td>{{ product.store.short_name }}(#{{ product.store.id }})</td>
                                    <td>{{ new Date(product.created_at).toLocaleString() }}</td>
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
                            Ürün Bulunamadı!
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>