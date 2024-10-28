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
        'logo',
        'address',
        'phone',
    ];
    protected $with = [
        'products',
        'categories',
        'catalogs',
    ];

    public function products(){
        return $this->hasMany(Product::class, 'store_id', 'id')->with('categories');
    }

    public function categories(){
        return $this->hasMany(Category::class, 'store_id', 'id')->with('products');
    }

    public function catalogs(){
        return $this->hasMany(Catalog::class, 'store_id', 'id');
    }

    public function users(){
        $this->belongsToMany(User::class, UserStore::class, 'store_id', 'id', 'id', 'user_id');
    }
}
