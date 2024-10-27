<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\DB;
use App\Http\Requests\ProductCreateRequest;
use Illuminate\Http\RedirectResponse;
use Inertia\Inertia;
use Inertia\Response;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;
use App\Models\Product;
use App\Models\CategoryProduct;
use App\Models\ProductImage;
use App\Models\WholesalePrice;
use App\Http\Controllers\StoreController;

class ProductController extends Controller
{

    public function list_view(){
        return Inertia::render('Store/Products');
    }

    public function create(ProductCreateRequest $request)
    {

        DB::beginTransaction ();

        try{

            $store = session()->has('active_store') ? session()->get('active_store') : Auth::user()->stores[0];

            $product = new Product;
            $product->store_id = $store->id;
            $product->name = $request->name;
            $product->description = $request->description;
            $product->retail_price = $request->retail_price;
            $product->save();

            foreach($request->categories as $categoryid){
                $category_link = new CategoryProduct;
                $category_link->product_id = $product->id;
                $category_link->category_id = $categoryid;
                $category_link->save();
            }

            foreach($request->wholesale_prices as $request_wholesale_price){
                $wholesale_price = new WholesalePrice;
                $wholesale_price->product_id = $product->id;
                $wholesale_price->price = $request_wholesale_price['price'];
                $wholesale_price->min_count = $request_wholesale_price['count'];
                $wholesale_price->save();
            }

            if($request->hasFile('images'))
            {
                $files = $request->file('images');
    
                foreach ($files as $file) {
                    $path = Storage::disk('public')->putFile('product_images', $file, 'public');
                    $product_image = new ProductImage;
                    $product_image->product_id = $product->id;
                    $product_image->name = basename($path);
                    $product_image->save();
                }
            }

            $active_store_reload = StoreController::active_store_reload();

            DB::commit();

            return Inertia::render('Store/Products', [
                'request' => [
                    'status' => true,
                    'product' => $product,
                ],
            ]);



        }catch(\Exception $e){

            DB::rollBack();
            return Inertia::render('Store/Products', [
                'request' => [
                    'status' => false,
                    'error_message' => $e->getMessage(),
                    'error_line' => $e->getLine(),
                    'error_file' => $e->getFile(),
                    'trace' => $e->getTraceAsString(),
                ],
            ]);
        }

        


    }
}
