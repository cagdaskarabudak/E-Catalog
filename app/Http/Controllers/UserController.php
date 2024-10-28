<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
    public function reload_user(Request $request){
        $request->validate([
            'userid' => ['required', 'integer'],
        ]);

        DB::beginTransaction();

        try{
            if($request->userid == Auth::user()->id){
                return response()->json([
                    'status' => true,
                    'user' => Auth::user(),
                ]);
            }
            else{
                throw new \Exception('Permission error!');
            }
        }catch(\Exception $e){
            return response()->json([
                'status' => false,
                'error_message' => $e->getMessage(),
            ]);
        }
    }
}
