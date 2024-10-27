<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import CreateProduct from '@/Pages/Store/CreateProduct.vue';
import { Head, Link, usePage, router } from '@inertiajs/vue3';
import { watch, ref, onMounted, inject } from 'vue';
import { Modal } from 'bootstrap';

const page = usePage();
const user = page.props.auth.user;
const bsAlert = inject('bsAlert');

let active_store = page.props.auth.active_store != null ? page.props.auth.active_store : user.stores[0];

watch(page, () => {
    active_store = page.props.auth.active_store;
});
const productCreateModal = ref(null);

let productCreateModalClass = null;

onMounted(() => {
    productCreateModalClass = new Modal(productCreateModal.value);
});

const productCreateResponseHandle = (data) => {
  if(data.request.status == true){
    productCreateModalClass.hide();
    router.reload();
    bsAlert('success', 'Ürün başarıyla oluşturulmuştur.');
  }
  
};

</script>

<template>
    <Head title="Ürünler" />

    <AuthenticatedLayout>
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card bg-dark text-light">
                    <div class="card-header">
                        <button class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#createProductModal"><i class="fa-solid fa-plus"></i> Yeni Ürün</button>
                        <div class="modal" tabindex="-1" id="createProductModal" ref="productCreateModal">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Yeni Ürün Oluştur</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <CreateProduct @form-response="productCreateResponseHandle"></CreateProduct>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <table v-if="active_store.products.length > 0" class="table table-responsive table-hover table-dark align-middle table-striped">
                            <thead>
                                <tr class="text-center">
                                    <th>#</th>
                                    <th>Görüntü</th>
                                    <th>İsim</th>
                                    <th>Perakende Fiyat</th>
                                    <th>Toptan Fiyatlar</th>
                                    <th>Kategoriler</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="product in active_store.products" class="text-center">
                                    <td>{{ product.id }}</td>
                                    <td>
                                        <img v-if="product.images.length > 0" :src="`/storage/product_images/${product.images[0].name}`" width="100px" class="rounded" alt="">
                                        <img v-else src="/storage/alpagu.webp" width="100px" class="rounded" alt="">
                                    </td>
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
                            Ürün Bulunamadı!
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
