<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CatalogItem extends Model
{
    protected $table = 'catalog_items';
    public $timestamps = false;
    protected $fillable = [
        'catalog_id',
        'title',
        'description',
        'type',
        'product_id',
        'content',
    ];

    public function catalog(){
        return $this->belongsTo(Catalog::class, 'catalog_id', 'id');
    }
}
