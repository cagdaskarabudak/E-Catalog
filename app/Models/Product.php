<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    
    protected $table = 'products';
    public $timestamps = true;
    protected $fillable = [
        'store_id',
        'name',
        'retail_price',
        'description'
    ];
    protected $with = [
        'wholesale_prices',
        'images',
    ];

    public function store(){
        return $this->belongsTo(Store::class, 'store_id', 'id');
    }

    public function categories()
    {
        return $this->belongsToMany(Category::class);
    }

    public function wholesale_prices(){
        return $this->hasMany(WholesalePrice::class, 'product_id', 'id');
    }

    public function images(){
        return $this->hasMany(ProductImage::class, 'product_id', 'id');
    }
}
