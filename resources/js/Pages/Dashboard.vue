<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, usePage } from '@inertiajs/vue3';
import { watch, inject, } from 'vue';

const bsAlert = inject('bsAlert');

const page = usePage();
let user = page.props.auth.user;
let active_store = page.props.auth.user.active_store;

watch(page, () => {
    active_store = page.props.auth.user.active_store;
});

</script>

<template>
    <AuthenticatedLayout>
        <div class="row justify-content-center" v-if="active_store != null">
            <Head title="Yönetim Paneli" />
            <h5><span class="text-success">Aktif Mağaza: </span> {{ active_store.short_name }}</h5>
            <h6 :class="`text-${active_store.role.color}`"><span class="text-secondary">Rol: </span>{{ active_store.role.tr_name }}</h6>
            <div class="col-lg-auto mb-3">
                <div class="card bg-primary text-center">
                    <div class="card-header">
                        <div class="card-title">Ürünler</div>
                    </div>
                    <div class="card-body">
                        <h1 class="card-text">{{ active_store.products.length }}</h1>
                    </div>
                    <Link :href="route('product.list')" class="card-footer">Tüm Ürünleri Gör</Link>
                </div>
            </div>
            <div class="col-lg-auto mb-3">
                <div class="card bg-warning text-center">
                    <div class="card-header">
                        <div class="card-title">Kategoriler</div>
                    </div>
                    <div class="card-body">
                        <h1 class="card-text">{{ active_store.categories.length }}</h1>
                    </div>
                    <Link :href="route('category.list')" class="card-footer">Tüm Kategorileri Gör</Link>
                </div>
            </div>
            <div class="col-lg-auto mb-3">
                <div class="card bg-danger text-center">
                    <div class="card-header">
                        <div class="card-title">Kataloglar</div>
                    </div>
                    <div class="card-body">
                        <h1 class="card-text">{{ active_store.catalogs.length }}</h1>
                    </div>
                    <Link :href="route('catalog.list')" class="card-footer">Tüm Katalogları Gör</Link>
                </div>
            </div>
        </div>
        <div v-else class="row justify-content-center">
            <Head :title="`Hoşgeldin, ${user.name} 🎉 `" />
            <div class="col-lg-9 mb-3">
                <div class="card bg-dark">
                    <div class="card-body text-center">
                        <h4 class="card-title mt-3 mb-3">Hoşgeldin, {{ user.name }} 🎉</h4>
                        <div class="mb-5">
                            <p>
                                Burada internet sitesi açmayı maliyetli bulan işletme sahipleri için
                                en azından ürünlerini müşterilerine sergilemeyi kolaylaştırıyoruz.
                            </p>
                            <p>
                                Müşterileriniz ürünlerinizi dijital olarak tıpkı bir e-ticaret sitesindeymiş gibi inceleyebilir,
                                ürün görüntülerini detaylı inceleyebilir, ürünler ile ilgili detayları öğrenebilir ve
                                sizinle belirttiğiniz kanallardan iletişim kurabilirler.
                            </p>
                        </div>
                        <div class="text-start mb-5">
                            Burada mağazanı kaydedip; 
                            <ul>
                                <li>Mağazandaki ürünleri düzenli bir şekilde ekleyebilir,</li>
                                <li>Ürünlerini kategorize edebilir,</li>
                                <li>Mağazanı ve ürünlerini tanıtan kataloglar hazırlayabilir,</li>
                                <li>Ve kataloglarını dijital veya dosya olarak müşterilerinle paylaşabilirsin.</li>
                                <li>Tüm bunları senin ile birlikte kaydedeceğin çalışanların da yapabilir.</li>
                            </ul> 
                        </div>
                        <p class="mb-5">
                            İşletmeni kaydedebilmemiz için
                            <a href="mailto:store_catalog@alpagu.net">store_catalog@alpagu.net</a> adresine aşağıdaki bilgileri göndermen gerekiyor:
                            <ul class="text-start">
                                <li>Kullanıcı numarası (Sizin kullanıcı numaranız: #{{ user.id }})</li>
                                <li>İletişim Numarası</li>
                                <li>İşletme Tam Adı (Örneğin: X Ticaret ve Pazarlama A.Ş.)</li>
                                <li>İşletme Kısa Adı (Örneğin: X Ticaret)</li>
                                <li>İşletme Logosu (zorunlu değil)</li>
                            </ul>
                        </p>
                        <p class="mb-5">
                            Not: İsim ve E-Posta bilgin doğru olmalı. Hesabının bilgilerini düzenlemek için <Link :href="route('profile.edit')">Profil Ayarları</Link>'na gidebilirsin.
                        </p>
                        <p class="mb-3">
                            E-Postanı aldığımız gün içerisinde mağazanı aktive edeceğiz. Şimdiden aramıza Hoşgeldin. 😇
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
