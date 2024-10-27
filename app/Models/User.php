<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
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
        'stores'
    ];

    protected function casts(): array
    {
        return [
            'password' => 'hashed',
        ];
    }

    public function role(){
        return $this->belongsTo(Role::class, 'role_id', 'id');
    }

    public function store_links()
    {
        return $this->hasMany(UserStore::class, 'user_id', 'id');
    }

    public function getStoresAttribute(){
        $stores = [];
        foreach($this->store_links as $store_link){
            $store = $store_link->store;
            $store->role = $store_link->role;
            $stores[] = $store;
        }

        return $stores;
    }
}
