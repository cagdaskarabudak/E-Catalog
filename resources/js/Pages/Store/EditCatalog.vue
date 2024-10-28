<script setup>
import { usePage, useForm, Head } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';

const page = usePage();
let user = page.props.auth.user;
let active_store = page.props.auth.user.active_store;

watch(page, ()=>{
    active_store = page.props.auth.user.active_store;
});

const catalog = page.props.catalog;
const items = ref(null);

const form = useForm({
    user: catalog.user.name,
    store: catalog.store.short_name,
    title: catalog.title,
    description: catalog.description
});

const itemform = useForm({
    title: '',
    description: '',
    type: '',
    product_id: null,
    content: '',
});

</script>

<template>
    <Head :title="`Düzenle ${catalog.title}`" />
    <AuthenticatedLayout>
        <div class="row justift-content-center">
            <div class="col-lg-12">
                <div class="card bg-dark">
                    <div class="card-header">
                        <h5 class="card-title">Düzenleniyor: <i>{{ catalog.title }}</i></h5>
                        <div class="catalog-info d-flex justify-content-between">
                            <small class="card-text">Oluşturan Kullanıcı: {{ catalog.user.name }}</small>
                            <small class="card-text">Mağaza: {{ catalog.store.short_name }}</small>
                            <small class="card-text">Oluşturulma Tarihi: {{ new Date(catalog.created_at).toLocaleString() }}</small>
                        </div>
                    </div>
                    <div class="card-body">
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

                                <input type="text" id="description" name="description" class="form-control" v-model="form.description" autocomplete="description" required>

                                <div class="invalid-feedback">
                                    {{ form.errors.description }}
                                </div>
                            </div>
                            <div class="mb-3">
                                <button class="btn btn-label-success" data-bs-toggle="modal" data-bs-target="#createItemModal"><i class="fa-solid fa-plus"></i> Öğe Ekle</button>
                            </div>
                            <div class="mb-3 items" ref="items"></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal" tabindex="-1" id="createItemModal">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Öğe Ekle</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex justify-content-center">
                        <button class="btn btn-label-success btn-lg w-50 me-2" data-bs-toggle="modal" data-bs-target="#createHTMLItemModal"><i class="fa-solid fa-align-left"></i> Yazı</button>
                        <button class="btn btn-label-success btn-lg w-50" data-bs-toggle="modal" data-bs-target="#createProductItemModal"><i class="fa-solid fa-objects-column"></i> Ürün</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal" tabindex="-1" id="createHTMLItemModal">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Öğe Ekle</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex justify-content-center">
                        HTML Item Append
                    </div>
                </div>
            </div>
        </div>
        <div class="modal" tabindex="-1" id="createProductItemModal">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Öğe Ekle</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex justify-content-center">
                        Product Item Append
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>>
</template>

