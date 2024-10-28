<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, usePage, Link } from '@inertiajs/vue3';
const all_users = usePage().props.users;
</script>
<template>
    <Head title="Tüm Kullanıcılar" />
    <AuthenticatedLayout>
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card bg-dark text-light">
                    <div class="card-body">
                        <table v-if="all_users.length > 0" class="table table-responsive table-hover table-dark align-middle table-striped">
                            <thead>
                                <tr class="text-center">
                                    <th>ID</th>
                                    <th>İsim</th>
                                    <th>Rol</th>
                                    <th>E-Posta</th>
                                    <th>Mağazalar</th>
                                    <th>Kayıt Tarihi</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="user in all_users" class="text-center">
                                    <td>#{{ user.id }}</td>
                                    <td>{{ user.name }}</td>
                                    <td><span :class="`btn btn-label-${user.role.color}`">{{ user.role.name }}</span></td>
                                    <td>{{ user.email }}</td>
                                    <td>
                                        <ul style="list-style-type: none; padding: 0;">
                                            <li v-for="store in user.stores">{{ store.short_name }}(#{{ store.id }}) - <span :class="`text-${store.role.color}`">{{ store.role.tr_name }}</span></li>
                                        </ul>
                                    </td>
                                    <td>{{ new Date(user.created_at).toLocaleString() }}</td>
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
                            Katalog Bulunamadı!
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>