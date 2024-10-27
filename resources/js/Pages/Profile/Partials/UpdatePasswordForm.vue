<script setup>
import { useForm } from '@inertiajs/vue3';
import { ref } from 'vue';

const passwordInput = ref(null);
const currentPasswordInput = ref(null);

const form = useForm({
    current_password: '',
    password: '',
    password_confirmation: '',
});

const updatePassword = () => {
    form.put(route('password.update'), {
        preserveScroll: true,
        onSuccess: () => form.reset(),
        onError: () => {
            if (form.errors.password) {
                form.reset('password', 'password_confirmation');
                passwordInput.value.focus();
            }
            if (form.errors.current_password) {
                form.reset('current_password');
                currentPasswordInput.value.focus();
            }
        },
    });
};
</script>

<template>
    <div class="card-body">
        <h4 class="card-title">
            Şifreyi Güncelle
        </h4>

        <p class="card-text text-secondary">
            Hesap şifreni güncelle.
        </p>

        <form @submit.prevent="updatePassword">
            <div class="mb-3">
                <label for="current_password" class="form-label">Mevcut Şifren</label>

                <input type="password" ref="currentPasswordInput" class="form-control" id="current_password" name="current_password" v-model="form.current_password" autocomplete="current-password">

                {{ form.errors.current_password }}
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Yeni Şifre</label>

                <input type="password" ref="passwordInput" id="password" name="password" v-model="form.password" class="form-control" autocomplete="new-password">

                {{ form.errors.password }}
            </div>

            <div class="mb-3">
                <label for="password_confirmation" class="form-label">Şifre Tekrar</label>

                <input type="password" class="form-control" id="password_confirmation" name="password_confirmation" v-model="form.password_confirmation" autocomplete="new-password">

                {{ form.errors.password_confirmation }}
            </div>

            <div class="mb-3 justify-content-center align-items-center">
                <button type="submit" class="btn btn-success me-2" :disabled="form.processing">Kaydet</button>
                <p v-if="form.recentlySuccessful">Saved.</p>
            </div>
        </form>
    </div>
</template>
