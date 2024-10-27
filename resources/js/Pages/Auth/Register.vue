<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Üye Ol" />

        <form @submit.prevent="submit">
            <div>
                <label for="name" class="form-label">İsim</label>

                <input type="text" id="name" name="name" class="form-control" v-model="form.name" required autofocus autocomplete="name">

                {{ form.errors.name }}
            </div>

            <div class="mt-4">
                <label for="email" class="form-label">E-Posta</label>

                <input type="email" class="form-control" id="email" name="email" v-model="form.email" required autocomplete="username">

                {{ form.errors.email }}
            </div>

            <div class="mt-4">
                <label for="password" class="form-label">Şifre</label>
                <input type="password" class="form-control" id="password" name="password" v-model="form.password" required autocomplete="new-password">

                {{ form.errors.password }}
            </div>

            <div class="mt-4">
                <label for="password_confirmation" class="form-label">Şifre Tekrar</label>

                <input type="password" id="password_confirmation" name="password_confirmation" class="form-control" v-model="form.password_confirmation" required autocomplete="new-password">

                {{ form.errors.password_confirmation }}
            </div>

            <div class="mt-4 flex items-center justify-end">
                <Link :href="route('login')">
                    Zaten üye misin? Giriş Yap
                </Link>

                <button type="submit"
                    class="btn btn-primary ms-4"
                    :class="{ 'opacity-25': form.processing }"
                    :disabled="form.processing"
                >
                    Üye Ol
                </button>
            </div>
        </form>
    </GuestLayout>
</template>
