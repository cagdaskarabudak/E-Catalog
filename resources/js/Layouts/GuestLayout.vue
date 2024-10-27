<script setup>
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
</script>

<template>
    <div class="guest-layout">
        <div class="brand">
            <ApplicationLogo />
        </div>
        <div class="content">
            <slot />
        </div>
    </div>
</template>
