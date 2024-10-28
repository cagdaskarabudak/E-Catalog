<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\DB;
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

        $request->validate([
            'new_active_store_id' => ['required', 'integer'],
        ]);

        DB::beginTransaction();

        try{
            $user = User::where('id', '=', Auth::user()->id)->with('store_links')->first();
            foreach($user->store_links as $auth_store_link){
                $store_link = UserStore::where('id', '=', $auth_store_link->id)->first();
                $store_link->is_active = 0;
                $store_link->save();
            }

            $store = Store::where('id', '=', $request->new_active_store_id)->first();
            $store_link = UserStore::where('store_id', '=', $store->id)->where('user_id', '=', $user->id)->first();
            if($store_link){
                $store_link->is_active = 1;
                $store_link->save();
            }
            else{
                throw new \Exception('Store_Link is not found!');
            }

            DB::commit();

        }catch(\Exception $e){
            return response()->json([
                'status' => false,
                'error_message' => $e->getMessage(),
                'error_line' => $e->getLine(),
                'error_file' => $e->getFile(),
            ]);
        }
    }
}
