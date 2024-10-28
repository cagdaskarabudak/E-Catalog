<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import CreateProduct from '@/Pages/Store/CreateProduct.vue';
import { Head, Link, usePage, router, useForm } from '@inertiajs/vue3';
import { watch, ref, onMounted, inject } from 'vue';
import { Modal } from 'bootstrap';

const bsAlert = inject('bsAlert');
const page = usePage();
let user = page.props.auth.user;
let active_store = page.props.auth.user.active_store;

watch(page, ()=>{
    active_store = page.props.auth.user.active_store;
});

const productCreateModal = ref(null);

let productCreateModalClass = null;

onMounted(() => {
    productCreateModalClass = new Modal(productCreateModal.value);
});

const productCreateResponseHandle = (data) => {
  if(data.request.status == true){
    productCreateModalClass.hide();
    bsAlert('success', 'Ürün başarıyla oluşturulmuştur.');
    router.reload();
  }
};

const deleteProduct = (productid) => {
    const confirmDeleteProduct = confirm('Ürünü silmek istediğinize emin misiniz?');
    if(confirmDeleteProduct){
        let deleteProductForm = useForm({
            product_id: productid,
        });

        deleteProductForm.delete(route('product.destroy'), {
            preserveScroll: true,
            onSuccess: (response) => {
                if(response.props.request.status == true){
                    router.reload();
                    bsAlert('success', 'Ürün silindi.');
                }
                else{
                    bsAlert('danger', `Ürün silinemedi. error_message: ${response.props.request.error_message}, error_line: ${response.props.request.error_line}, error_file: ${response.props.request.error_file}`);
                }
                
            },
            onFinish: () => deleteProductForm.reset(),
        });
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
                                        <CreateProduct @form-response="productCreateResponseHandle" :active_store="active_store"></CreateProduct>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <table v-if="active_store.products.length > 0" class="table table-responsive table-hover table-dark align-middle table-striped">
                            <thead>
                                <tr class="text-center">
                                    <th>ID</th>
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
                                    <td>#{{ product.id }}</td>
                                    <td>
                                        <img class="product-image rounded" v-if="product.images.length > 0" :src="`/storage/product_images/${product.images[0].name}`" width="100px" alt="">
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
                                            <div class="dropdown-item text-danger" @click="deleteProduct(product.id)"><i class="fa-solid fa-trash"></i> Sil</div>
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
