<script setup>
import { useForm, usePage } from '@inertiajs/vue3';

defineProps({
    status: {
        type: String,
    },
});

const user = usePage().props.auth.user;

const form = useForm({
    name: user.name,
    email: user.email,
});
</script>

<template>
    <div class="card-body">
        <h4 class="card-title">Profil Bilgileri</h4>
        <p class="card-text text-secondary mb-3">İsim ve E-posta bilgilerini güncelle.</p>
        <form @submit.prevent="form.patch(route('profile.update'))">
            <div class="mb-3">
                <label for="name" class="form-label">İsim</label>

                <input type="text" id="name" name="name" class="form-control" v-model="form.name" required autofocus autocomplete="name">

                {{ form.errors.name }}
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">E-Posta</label>

                <input type="email" id="email" name="email" class="form-control" v-model="form.email" required autocomplete="username">

                {{ form.errors.email }}
            </div>

            <div class="d-flex align-items-center">
                <button type="submit" :disabled="form.processing" class="btn btn-success me-2">Kaydet</button>
                <p v-if="form.recentlySuccessful">
                    Kaydedildi.
                </p>
            </div>
        </form>
    </div>
</template>
