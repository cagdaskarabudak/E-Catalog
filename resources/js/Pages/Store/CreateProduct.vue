<script setup>
import { useForm, usePage, router } from '@inertiajs/vue3';
import { ref, watch, defineEmits, inject, defineProps } from 'vue';

const bsAlert = inject('bsAlert');

const props = defineProps({
  active_store: {
    required: true,
  },
});

const emit = defineEmits(['form-response']);

const wholesaleinputs = ref(null);
const imagesinput = ref(null);
const images = ref([]);
const form = useForm({
    name: '',
    retail_price: 0,
    wholesale_prices: [],
    description: '',
    images: [],
    categories: []
});

const addImages = () => {
    form.images = Array.from(imagesinput.value.files);
    images.value = [];

    form.images.forEach(file => {
        const reader = new FileReader();
        reader.onload = () => {
            images.value.push(reader.result);
        };
        reader.readAsDataURL(file);
    });
};

const addwholesaleinput = () => {
    let group = document.createElement('div');
    group.classList.add('input-group');
    group.classList.add('mb-1');

    let countinput = document.createElement('input');
    countinput.setAttribute('type', 'number');
    countinput.setAttribute('placeholder', 'adet');
    countinput.classList.add('countinput');
    countinput.classList.add('form-control');
    countinput.setAttribute('required', 'true');

    let priceinput = document.createElement('input');
    priceinput.setAttribute('type', 'number');
    priceinput.setAttribute('placeholder', 'fiyat');
    priceinput.classList.add('priceinput');
    priceinput.classList.add('form-control');
    priceinput.setAttribute('required', 'true');

    let destroybutton = document.createElement('button');
    destroybutton.classList.add('btn');
    destroybutton.classList.add('btn-outline-danger');
    destroybutton.innerHTML = '<i class="fa-solid fa-trash"></i>';
    destroybutton.setAttribute('type', 'button');
    destroybutton.addEventListener('click', function(e){
        let thisgroup = e.currentTarget.parentElement;
        thisgroup.remove();
    });

    group.append(countinput);
    group.append(priceinput);
    group.append(destroybutton);

    wholesaleinputs.value.append(group);
}

const submitform = () => {
    form.wholesale_prices = [];
    const groups = wholesaleinputs.value.querySelectorAll('.input-group');
    for (let group of groups) {
        let count = Number(group.querySelector('input.countinput').value);
        let price = Number(group.querySelector('input.priceinput').value);
        form.wholesale_prices.push({
            "count": count,
            "price": price
        });
    }
    form.post(route('product.create'), {
        onSuccess: (successresponse) => {
            if(successresponse.props.request.status == true){
                form.reset();
                wholesaleinputs.value.innerHTML = '';
                imagesinput.value.value = '';
                images.value = [];
                emit('form-response', successresponse.props);
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
                <label for="name" class="form-label">Ürün Adı</label>

                <input type="text" id="name" name="name" class="form-control" v-model="form.name" autofocus autocomplete="name" required>

                <div class="invalid-feedback">
                    {{ form.errors.name }}
                </div>
        </div>
        <div class="mb-3">
            <label for="images" class="form-label">Ürün Görüntüleri</label>
            <div v-if="images.length" class="mb-3" style="display: flex; justify-content: center; align-items: center; column-gap: 1%; row-gap: 5px; overflow: hidden; flex-wrap: wrap;">
                <div v-for="(image, index) in images">
                    <img :src="image" width="100" class="rounded" alt="Preview" />
                </div>
            </div>
            <input type="file" id="images" ref="imagesinput" @change="addImages" name="images" class="form-control" autocomplete="images" multiple required>
            <div class="invalid-feedback">
                {{ form.errors.images }}
            </div>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Ürün Açıklaması</label>

            <textarea id="description" name="description" class="form-control" v-model="form.description" autocomplete="description" minlength="20" required></textarea>
            <div class="invalid-feedback">
                {{ form.errors.description }}
            </div>
        </div>
        <div class="mb-3">
            <label for="categories" class="form-label">Ürün Kategorileri</label>
            <select name="categories" id="categories" class="form-control" v-model="form.categories" multiple required>
                <option v-for="category in active_store.categories" :key="category.id" :value="category.id">{{ category.name }}</option>
            </select>
            <div class="invalid-feedback">
                {{ form.errors.categories }}
            </div>
        </div>
        <div class="mb-3">
            <label for="retail_price" class="form-label">Perakende Fiyat</label>

            <input type="number" id="retail_price" name="retail_price" class="form-control" min="1" v-model="form.retail_price" required>
            
            <div class="invalid-feedback">
                {{ form.errors.retail_price }}
            </div>
        </div>
        <div class="mb-1">
            <label for="wholesale_input" class="form-label me-2">Toptan Fiyatlar (Adet / Fiyat)</label>
            <button type="button" @click="addwholesaleinput" class="btn btn-outline-success btn-sm rounded-circle wholesale-input-add"><i class="fa-solid fa-plus"></i></button>
        </div>
        <div class="mb-3" ref="wholesaleinputs"></div>
        <div class="invalid-feedback">
                {{ form.errors.wholesale_prices }}
            </div>
        <div class="mb-3">
            <button type="submit" class="btn btn-success" :disabled="form.progressing">Oluştur</button>
            <p v-if="form.recentlySuccessful">
                Ürün Oluşturuldu.
            </p>
        </div>
    </form>
</template>
