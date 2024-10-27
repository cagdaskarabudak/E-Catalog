<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Store extends Model
{
    protected $table = 'stores';
    public $timestamps = true;
    protected $fillable = [
        'name',
        'short_name',
        'logo'
    ];
    protected $with = [
        'products',
        'categories',
    ];

    public function products(){
        return $this->hasMany(Product::class, 'store_id', 'id')->with('categories');
    }

    public function categories(){
        return $this->hasMany(Category::class, 'store_id', 'id')->with('products');
    }

    public function users(){
        $this->belongsToMany(User::class, UserStore::class, 'store_id', 'id', 'id', 'user_id');
    }
}
