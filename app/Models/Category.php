<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $table = 'categories';
    public $timestamps = false;
    protected $fillable = [
        'store_id',
        'name',
    ];

    public function products(){
        return $this->hasManyThrough(Product::class, CategoryProduct::class, 'category_id', 'id', 'id', 'product_id');
    }
}
