<script setup>
import { useForm } from '@inertiajs/vue3';
import { ref, onMounted } from 'vue';
import { Modal } from 'bootstrap';

const deletingModal = ref(null);
const passwordInput = ref(null);
const form = useForm({
    password: '',
});

let deletingModalClass = null;

onMounted(() => {
    // Modal öğesini `deletingModal.value` üzerinden alın
    deletingModalClass = new Modal(deletingModal.value);
});

// Modal'ı kapatma fonksiyonu
const closeModal = () => {
    if (deletingModalClass) {
        deletingModalClass.hide();
    }
};

// Kullanıcı silme işlemi
const deleteUser = () => {
    form.delete(route('profile.destroy'), {
        preserveScroll: true,
        onSuccess: () => closeModal(),
        onError: () => passwordInput.value.focus(),
        onFinish: () => form.reset(),
    });
};
</script>

<template>
    <div class="card-body">
        <h4 class="card-title">Hesabı Sil</h4>

        <p class="card-text">
            Hesabınızı silebilmek için şifrenizi girmeniz gerekmektedir.
        </p>

        <!-- Buton ile modalı açma -->
        <button type="button" class="btn btn-danger" @click="deletingModalClass.show()">Delete Account</button>

        <div class="modal fade" id="confirmingUserDeletion" ref="deletingModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-light">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Hesabınızı silmek istediğinize emin misiniz?</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="modal-text">
                            Hesabınızı silebilmek için şifrenizi girmeniz gerekmektedir.
                        </p>

                        <div class="mb-3">
                            <label for="deleting_password" class="form-label">Şifre</label>
                            <input type="password" class="form-control" v-model="form.password" ref="passwordInput" id="deleting_password" @keyup.enter="deleteUser">
                            {{ form.errors.password }}
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Vazgeç</button>
                        <button type="button" class="btn btn-danger" :class="{ 'opacity-25': form.processing }" :disabled="form.processing" @click="deleteUser">Hesabı Sil</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
