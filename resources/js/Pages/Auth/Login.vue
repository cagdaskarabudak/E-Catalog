<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

defineProps({
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};

</script>

<template>
    <GuestLayout>
        <Head title="Giriş" />

        <div v-if="status" class="mb-4 text-sm font-medium text-green-600">
            {{ status }}
        </div>

        <form @submit.prevent="submit">
            <div>
                <label for="email" class="form-label">E-Posta</label>

                <input type="email" name="email" class="form-control" id="email" v-model="form.email" required autofocus autocomplete="username">

                {{ form.errors.email }}
            </div>

            <div class="mt-4">
                <label for="password" class="form-label">Şifre</label>

                <input type="password" name="password" id="password" class="form-control" v-model="form.password" required autocomplete="current-password">

                {{ form.errors.password }}
            </div>

            <div class="mt-4 form-check">
                <input type="checkbox" class="form-check-input" name="remember" id="remember" v-model="form.remember">
                
                <label class="form-check-label" for="remember">Beni Hatırla</label>
            </div>

            <div class="mt-4 flex items-center justify-end">
                <Link :href="route('register')">
                    Üyeliğin yok mu? Üye Ol
                </Link>
                <button type="submit" class="btn btn-primary ms-4" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">Log in</button>
            </div>
        </form>
    </GuestLayout>
</template>
