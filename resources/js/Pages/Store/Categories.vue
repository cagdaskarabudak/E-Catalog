<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import CreateCategory from './CreateCategory.vue';
import { Head, Link, usePage, router, useForm } from '@inertiajs/vue3';
import { watch, onMounted, inject, ref } from 'vue';
import { Modal } from 'bootstrap';

const bsAlert = inject('bsAlert');

const page = usePage();
let user = page.props.auth.user;
let active_store = page.props.auth.user.active_store;

watch(page, ()=>{
    active_store = page.props.auth.user.active_store;
});

const categoryCreateModal = ref(null);

let categoryCreateModalClass = null;

onMounted(() => {
    categoryCreateModalClass = new Modal(categoryCreateModal.value);
});

const categoryCreateResponseHandle = (data) => {
  if(data.request.status == true){
    categoryCreateModalClass.hide();
    router.reload();
    bsAlert('success', 'Kategori başarıyla oluşturulmuştur.');
  }
  
};

const deleteCategory = (categoryid) => {
    const confirmDeleteCategory = confirm('Kategoriyi silmek istediğinize emin misiniz?');
    if(confirmDeleteCategory){
        let deleteCategoryForm = useForm({
            category_id: categoryid,
        });

        deleteCategoryForm.delete(route('category.destroy'), {
            preserveScroll: true,
            onSuccess: (response) => {
                if(response.props.request.status == true){
                    router.reload();
                    bsAlert('success', 'Kategori silindi.');
                }
                else{
                    bsAlert('danger', `Kategori silinemedi. error_message: ${response.props.request.error_message}, error_line: ${response.props.request.error_line}, error_file: ${response.props.request.error_file}`);
                }
                
            },
            onFinish: () => deleteCategoryForm.reset(),
        });
    }
};

</script>

<template>
    <Head title="Kategoriler" />

    <AuthenticatedLayout>
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card bg-dark text-light">
                    <div class="card-header">
                        <button class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#createCategoryModal"><i class="fa-solid fa-plus"></i> Yeni Kategori</button>
                        <div class="modal" tabindex="-1" id="createCategoryModal" ref="categoryCreateModal">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Yeni Kategori Oluştur</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <CreateCategory @form-response="categoryCreateResponseHandle"></CreateCategory>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <table v-if="active_store.categories.length > 0" class="table table-responsive table-hover table-dark align-middle table-striped">
                            <thead>
                                <tr class="text-center">
                                    <th>ID</th>
                                    <th>İsim</th>
                                    <th>Ürün Sayısı</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="category in active_store.categories" class="text-center">
                                    <td>#{{ category.id }}</td>
                                    <td>{{ category.name }}</td>
                                    <td>{{ category.products.length }}</td>
                                    <td><div class="dropdown">
                                        <button class="btn btn-label-info" data-bs-toggle="dropdown"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <div class="dropdown-menu">
                                            <Link href="#" class="dropdown-item text-info"><i class="fa-solid fa-edit"></i> Düzenle</Link>
                                            <div @click="deleteCategory(category.id)" class="dropdown-item text-danger"><i class="fa-solid fa-trash"></i> Sil</div>
                                        </div>
                                    </div></td>
                                </tr>
                            </tbody>
                        </table>
                        <div v-else class="alert alert-danger text-center" role="alert">
                            <i class="fa-solid fa-warning me-2"></i>
                            Kategori Bulunamadı!
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
