<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\StoreController;
use App\Http\Controllers\ExampleController;


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

    //Product
    Route::get('/products', [ProductController::class, 'list_view'])->name('products.list');
    Route::post('/products', [ProductController::class, 'create'])->name('product.create');

    //Category
    Route::get('/categories', [CategoryController::class, 'list_view'])->name('categories.list');

    //Store
    Route::get('/get-stores', [StoreController::class, 'getStores'])->name('getstores');
    Route::post('/active-store-change', [StoreController::class, 'active_store_change'])->name('active_store_change');
});

Route::get('/example', [ExampleController::class, 'main'])->name('example');

require __DIR__.'/auth.php';
