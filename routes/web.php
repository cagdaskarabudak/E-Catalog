<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\StoreController;
use App\Http\Controllers\CatalogController;
use App\Http\Controllers\ExampleController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\AdministratorController;


Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::get('/', function () {
    return redirect('login');
})->name('welcome');

Route::middleware('auth')->group(function () {
    //Profile
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::middleware('validated')->group(function () {
        //Product
        Route::get('/products', [ProductController::class, 'list_view'])->name('product.list');
        Route::post('/products', [ProductController::class, 'create'])->name('product.create');
        Route::delete('products', [ProductController::class, 'destroy'])->name('product.destroy');

        //Category
        Route::get('/categories', [CategoryController::class, 'list_view'])->name('category.list');
        Route::post('/categories', [CategoryController::class, 'create'])->name('category.create');
        Route::delete('categories', [CategoryController::class, 'destroy'])->name('category.destroy');

        //Catalog
        Route::get('/catalogs', [CatalogController::class, 'list_view'])->name('catalog.list');
        Route::get('/catalog/edit/{id}', [CatalogController::class, 'edit_view'])->name('catalog.edit');
        Route::post('/catalogs', [CatalogController::class, 'create'])->name('catalog.create');
        Route::delete('catalogs', [CatalogController::class, 'destroy'])->name('catalog.destroy');

        //Store
        Route::post('/active-store-change', [StoreController::class, 'active_store_change'])->name('active_store_change');
    });

    Route::middleware('admin')->group(function () {
        Route::get('/manage-users', [AdministratorController::class, 'list_users_view'])->name('admin.user.list');
        Route::get('/manage-stores', [AdministratorController::class, 'list_stores_view'])->name('admin.store.list');
        Route::get('/manage-products', [AdministratorController::class, 'list_products_view'])->name('admin.product.list');
        Route::get('/manage-categories', [AdministratorController::class, 'list_categories_view'])->name('admin.category.list');
        Route::get('/manage-catalogs', [AdministratorController::class, 'list_catalogs_view'])->name('admin.catalog.list');
    });
});

Route::get('/example', [ExampleController::class, 'main'])->name('example');

require __DIR__.'/auth.php';
