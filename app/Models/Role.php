<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    protected $table = 'roles';
    public $timestamps = true;
    protected $fillable = [
        'name',
        'tr_name',
        'color',
    ];
}
