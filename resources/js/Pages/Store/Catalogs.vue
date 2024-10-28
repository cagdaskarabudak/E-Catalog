<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
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

const catalogCreateModal = ref(null);

let catalogCreateModalClass = null;

onMounted(() => {
    catalogCreateModalClass = new Modal(catalogCreateModal.value);
});

const form = useForm({
    user_id: user.id,
    store_id: active_store.id,
    title: '',
    description: '',
    items: [],
});

const submitform = () => {
    form.post(route('catalog.create'), {
        onSuccess: async (successresponse) => {
            if(successresponse.props.request.status == true){
                form.reset();
                catalogCreateModalClass.hide();
                bsAlert('success', 'Katalog başarıyla oluşturulmuştur.');
                router.reload();
            }
            else{
                bsAlert('danger', successresponse.props.request.error_message + '(' + successresponse.props.request.error_line + ')');
            }
        }
    });
};

const deleteCatalog = (catalogid) => {
    const confirmDeleteCatalog = confirm('Kataloğu silmek istediğinize emin misiniz?');
    if(confirmDeleteCatalog){
        let deleteCatalogForm = useForm({
            catalog_id: catalogid,
        });

        deleteCatalogForm.delete(route('catalog.destroy'), {
            preserveScroll: true,
            onSuccess: (response) => {
                if(response.props.request.status == true){
                    router.reload();
                    bsAlert('success', 'Katalog silindi.');
                }
                else{
                    bsAlert('danger', `Katalog silinemedi. error_message: ${response.props.request.error_message}, error_line: ${response.props.request.error_line}, error_file: ${response.props.request.error_file}`);
                }
                
            },
            onFinish: () => deleteCatalogForm.reset(),
        });
    }

};

</script>

<template>
    <Head title="Kataloglar" />

    <AuthenticatedLayout>
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card bg-dark text-light">
                    <div class="card-header">
                        <button class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#createCatalogModal"><i class="fa-solid fa-plus"></i> Yeni Katalog</button>
                        <div class="modal" tabindex="-1" id="createCatalogModal" ref="catalogCreateModal">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Yeni Katalog Oluştur</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form @submit.prevent="submitform" :class="form.hasErrors ? 'was-validated' : 'needs-validation'" novalidate>
                                            <div class="mb-3">
                                                    <label for="title" class="form-label">Katalog Başlığı</label>

                                                    <input type="text" id="title" name="title" class="form-control" v-model="form.title" autofocus autocomplete="title" required>

                                                    <div class="invalid-feedback">
                                                        {{ form.errors.title }}
                                                    </div>
                                            </div>
                                            <div class="mb-3">
                                                    <label for="description" class="form-label">Katalog Açıklaması</label>

                                                    <input type="text" id="description" name="description" class="form-control" v-model="form.description" autofocus autocomplete="description" required>

                                                    <div class="invalid-feedback">
                                                        {{ form.errors.description }}
                                                    </div>
                                            </div>
                                            <div class="mb-3">
                                                <button type="submit" class="btn btn-success" :disabled="form.progressing">Oluştur</button>
                                                <p v-if="form.recentlySuccessful">
                                                    Kategori Oluşturuldu.
                                                </p>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <table v-if="active_store.catalogs.length > 0" class="table table-responsive table-hover table-dark align-middle table-striped">
                            <thead>
                                <tr class="text-center">
                                    <th>ID</th>
                                    <th>Başlık</th>
                                    <th>Açıklama</th>
                                    <th>Tarih</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="catalog in active_store.catalogs" class="text-center">
                                    <td>#{{ catalog.id }}</td>
                                    <td>{{ catalog.title }}</td>
                                    <td>{{ catalog.description }}</td>
                                    <td>{{ new Date(catalog.created_at).toLocaleString() }}</td>
                                    <td><div class="dropdown">
                                        <button class="btn btn-label-info" data-bs-toggle="dropdown"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <div class="dropdown-menu">
                                            <Link :href="route('catalog.edit', catalog.id)" class="dropdown-item text-info"><i class="fa-solid fa-edit"></i> Düzenle</Link>
                                            <div type="button" class="dropdown-item text-danger" @click="deleteCatalog(catalog.id)"><i class="fa-solid fa-trash"></i> Sil</div>
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
