<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\User;
use App\Models\Store;
use App\Models\Product;
use App\Models\Category;
use App\Models\Catalog;

class AdministratorController extends Controller
{
    public function list_products_view(){
        return Inertia::render('Admin/Products', [
            'products' => Product::with(['categories', 'store'])->get(),
        ]);
    }

    public function list_categories_view(){
        return Inertia::render('Admin/Categories', [
            'categories' => Category::with(['products', 'store'])->get(),
        ]);
    }

    public function list_catalogs_view(){
        return Inertia::render('Admin/Catalogs', [
            'catalogs' => Catalog::with('store')->get(),
        ]);
    }

    public function list_users_view(){
        return Inertia::render('Admin/Users', [
            'users' => User::all(),
        ]);
    }

    public function list_stores_view(){
        return Inertia::render('Admin/Stores', [
            'stores' => Store::all(),
        ]);
    }
}
