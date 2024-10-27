<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WholesalePrice extends Model
{
    protected $table = 'wholesale_prices';
    public $timestamps = true;
    protected $fillable = [
        'product_id',
        'price',
        'min_count',
    ];
}
