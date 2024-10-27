<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use Inertia\Response;
use Illuminate\Support\Facades\Redirect;
use App\Models\User;
use App\Models\UserStore;
use App\Models\Store;
use App\Models\Product;
use App\Models\CategoryProduct;
use App\Models\Category;

class StoreController extends Controller
{
    public function active_store_change(Request $request){

        $authstores = Auth::user()->stores;
        foreach($authstores as $store){
            if($store->id == $request->active_store){
                $active_store = $store;
            }
        }
        session()->put('active_store', $active_store);

        return Redirect::back();
    }

    public static function active_store_reload(){

        try{

            $authstores = Auth::user()->stores;
            $active_store = session()->has('active_store') ? session()->get('active_store') : $authstores[0];
    
            foreach($authstores as $store){
                if($store->id == $active_store->id){
                    $active_store = $store;
                }
            }
            session()->put('active_store', $active_store);
    
            return true;
        }catch(\Exception $e){
            return false;
        }
    }

    public function getStores(Request $request){
        try{
            $data = User::all();

            return response()->json([
                'data' => $data,
                'status' => true
            ]);
        }
        catch(\Exception $e){
            return response()->json([
                'data' => $e->getMessage(),
                'status' => false
            ]);
        }

    }

    public function example(){
        return Product::with('categories')->get();
    }
}
