<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import DeleteUserForm from './Partials/DeleteUserForm.vue';
import UpdatePasswordForm from './Partials/UpdatePasswordForm.vue';
import UpdateProfileInformationForm from './Partials/UpdateProfileInformationForm.vue';
import { Head } from '@inertiajs/vue3';

defineProps({
    status: {
        type: String,
    },
});
</script>

<template>
    <Head title="Profil" />

    <AuthenticatedLayout>
        <div class="row">
            <div class="col-lg-12">

                <div class="card bg-dark mb-1">
                    <div class="card-body">
                        <h3>Kullanıcı ID: <code>#{{ $page.props.auth.user.id }}</code></h3><br>
                        <h6>Durum: <code :class="`text-${$page.props.auth.user.role.color}`">{{ $page.props.auth.user.role.tr_name }}</code></h6>
                    </div>
                </div>

                <div class="card bg-dark mb-3">
                    <UpdateProfileInformationForm :status="status" class="max-w-xl" />
                </div>

                <div class="card bg-dark mb-3">
                    <UpdatePasswordForm class="max-w-xl" />
                </div>

                <div class="card bg-dark mb-3">
                    <DeleteUserForm />
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
