<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Model;

class User extends Authenticatable
{
    use HasFactory, Notifiable;
    protected $fillable = [
        'name',
        'email',
        'password',
        'role_id',
    ];

    protected $hidden = [
        'password',
    ];

    protected $appends = [
        'stores',
        'active_store',
    ];
    protected $with = [
        'role',
    ];

    protected $casts = [
        'password' => 'hashed',
    ];

    public function role(){
        return $this->belongsTo(Role::class, 'role_id', 'id');
    }

    public function store_links()
    {
        return $this->hasMany(UserStore::class, 'user_id', 'id');
    }


    public function getStoresAttribute()
    {
        return $this->store_links->map(function ($store_link) {
            $store = $store_link->store;
            $store->role = $store_link->role;
            $store->is_active = $store_link->is_active;
            return $store;
        });
    }

    public function getActiveStoreAttribute()
    {
        $active_store = collect($this->stores)->firstWhere('is_active', 1);

        if (!$active_store && $this->stores->isNotEmpty()) {
            $active_store = $this->stores[0];
        }
        elseif(!$active_store){
            $active_store = null;
        }

        return $active_store;
    }
}
