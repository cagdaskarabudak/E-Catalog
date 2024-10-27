<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\Product;
use App\Models\ProductImage;
use App\Models\Role;
use App\Models\Store;
use App\Models\User;
use App\Http\Controllers\StoreController;


class ExampleController extends Controller
{
    public function main(){

        return StoreController::active_store_reload();
    }
}
