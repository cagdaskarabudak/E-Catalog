<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Catalog extends Model
{
    protected $table = 'catalogs';
    public $timestamps = true;
    protected $fillable = [
        'user_id',
        'store_id',
        'title',
        'description'
    ];
    protected $with = [
        'items',
    ];

    public function items(){
        return $this->hasMany(CatalogItem::class, 'catalog_id', 'id');
    }

    public function store(){
        return $this->belongsTo(Store::class, 'store_id', 'id');
    }

    public function user(){
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
