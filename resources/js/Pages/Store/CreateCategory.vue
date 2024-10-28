<script setup>
import { useForm, usePage } from '@inertiajs/vue3';
import { watch, defineEmits, inject } from 'vue';

const bsAlert = inject('bsAlert');

const page = usePage();
let user = page.props.auth.user;
let active_store = page.props.auth.user.active_store;

watch(page, ()=>{
    active_store = page.props.auth.user.active_store;
});

const emit = defineEmits(['form-response']);

const form = useForm({
    store_id: active_store.id,
    name: '',
});

const submitform = () => {
    form.post(route('category.create'), {
        onSuccess: (successresponse) => {
            if(successresponse.props.request.status == true){
                emit('form-response', successresponse.props);
                form.reset();
            }
            else{
                bsAlert('danger', successresponse.props.request.error_message + '(' + successresponse.props.request.error_line + ')');
            }
        }
    });
};

</script>
<template>
    <form @submit.prevent="submitform" :class="form.hasErrors ? 'was-validated' : 'needs-validation'" novalidate>
        <div class="mb-3">
                <label for="name" class="form-label">Kategori Adı</label>

                <input type="text" id="name" name="name" class="form-control" v-model="form.name" autofocus autocomplete="name" required>

                <div class="invalid-feedback">
                    {{ form.errors.name }}
                </div>
        </div>
        <div class="mb-3">
            <button type="submit" class="btn btn-success" :disabled="form.progressing">Oluştur</button>
            <p v-if="form.recentlySuccessful">
                Kategori Oluşturuldu.
            </p>
        </div>
    </form>
</template>
