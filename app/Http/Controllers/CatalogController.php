<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Models\Catalog;
use App\Models\CatalogItem;
use App\Models\Product;
use App\Models\Store;
use App\Http\Controllers\StoreController;
use Inertia\Inertia;

class CatalogController extends Controller
{
    public function list_view(){
        return Inertia::render('Store/Catalogs');
    }

    public function edit_view($id, Request $request){

        $catalog = Catalog::with(['user', 'store'])->find($id);
        $user = Auth::user();
        $active_store = $user->active_store;

        if($catalog){

            if($catalog->store_id == $active_store->id){

                return Inertia::render('Store/EditCatalog', [
                    'catalog' => $catalog,
                ]);
            }
            else{
                return redirect()->route('catalogs.list');
            }
        }
        else{
            return redirect()->route('catalogs.list');
        }

    }

    public function create(Request $request){
        $request->validate([
            'store_id' => ['required', 'integer'],
            'user_id' => ['required', 'integer'],
            'title' => ['required', 'string'],
            'description' => ['required', 'string'],
        ]);

        DB::beginTransaction();

        try{

            if($request->user_id == Auth::user()->id){
                $user = Auth::user();
            }
            else{
                throw new \Exception('No action can be taken by anyone other than the logged in user!');
            }

            $isUserStore = false;

            foreach($user->stores as $store){
                if($store->id == $request->store_id){
                    $isUserStore = true;
                    break;
                }
            }

            if ($isUserStore) {
                $store = Store::where('id', '=', $request->store_id)->first();
            } else {
                throw new \Exception('User does not own this store.');
            }

            $catalog = new Catalog;
            $catalog->user_id = $user->id;
            $catalog->store_id = $store->id;
            $catalog->title = $request->title;
            $catalog->description = $request->description;
            $catalog->save();
            
            DB::commit();

            return Inertia::render('Store/Catalogs', [
                'request' => [
                    'status' => true,
                ],
            ]);

        }catch(\Exception $e){
            DB::rollBack();
            return Inertia::render('Store/Catalogs', [
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

    public function destroy(Request $request){
        $request->validate([
            'catalog_id' => ['required'],
        ]);

        DB::beginTransaction();

        try{
            $user = Auth::user();

            $catalog = Catalog::where('id', '=', $request->catalog_id)->with('store')->first();
    
            if($catalog){
                $store = $catalog->store;

                if($user->active_store->id == $store->id){
                    $catalog->delete();
                }
                else{
                    throw new \Exception('This Store is have not this catalog');
                }
            }
            else{
                throw new \Exception('Catalog not found!');
            }

            DB::commit();

            return Inertia::render('Store/Catalogs', [
                'request' => [
                    'status' => true,
                ],
            ]);
        }catch(\Exception $e){
            return Inertia::render('Store/Catalogs', [
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
