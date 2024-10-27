<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserStore extends Model
{

    protected $table = 'user_store';
    public $timestamps = false;
    protected $fillable = [
        'user_id',
        'store_id',
        'role_id',
    ];

    public function user(){
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function store(){
        return $this->belongsTo(Store::class, 'store_id', 'id');
    }

    public function role(){
        return $this->belongsTo(Role::class, 'role_id', 'id');
    }
}
