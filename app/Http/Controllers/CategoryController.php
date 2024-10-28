<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Category;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\StoreController;

class CategoryController extends Controller
{
    public function list_view(){
        return Inertia::render('Store/Categories');
    }

    public function create(Request $request){
        $request->validate([
            'store_id' => ['required', 'integer'],
            'name' => ['string', 'required', 'min:3'],
        ]);

        DB::beginTransaction();

        try{
            $category = new Category;
            $category->store_id = $request->store_id;
            $category->name = $request->name;
            $category->save();

            DB::commit();

            return Inertia::render('Store/Categories', [
                'request' => [
                    'status' => true,
                ],
            ]);
        }
        catch(\Exception $e){
            DB::rollBack();
            return Inertia::render('Store/Categories', [
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
            'category_id' => ['required'],
        ]);

        DB::beginTransaction();

        try{
            $user = Auth::user();

            $category = Category::where('id', '=', $request->category_id)->with('store')->first();
    
            if($category){
                $store = $category->store;

                if($user->active_store->id == $store->id){
                    $category->delete();
                }
                else{
                    throw new \Exception('This Store is have not this category');
                }
            }
            else{
                throw new \Exception('Category not found!');
            }

            DB::commit();

            return Inertia::render('Store/Categories', [
                'request' => [
                    'status' => true,
                ],
            ]);
        }catch(\Exception $e){
            return Inertia::render('Store/Categories', [
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
