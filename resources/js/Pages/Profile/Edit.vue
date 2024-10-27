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
                <div class="card bg-dark text-light mb-3">
                    <UpdateProfileInformationForm :status="status" class="max-w-xl" />
                </div>

                <div class="card bg-dark text-light mb-3">
                    <UpdatePasswordForm class="max-w-xl" />
                </div>

                <div class="card bg-dark text-light mb-3">
                    <DeleteUserForm />
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
