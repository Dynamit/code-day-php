<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use Notifiable, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public static function import()
    {
        $file = '/var/www/data/customers.csv';

        Csv::fileToArray($file)->each(function ($customer) {
            $user = new User();
            $user->id = $customer['id'];
            $user->first_name = $customer['first_name'];
            $user->last_name = $customer['last_name'];
            $user->email = $customer['email'];
            $user->address1 = $customer['address1'];
            $user->city = $customer['city'];
            $user->state = $customer['state'];
            $user->zip = $customer['zip'];
            $user->home_phone = $customer['home_phone'];
            $user->cell_phone = $customer['cell_phone'];
            $user->allow_text = $customer['allow_text'] == 'true' ? 1 : 0;
            $user->allow_email = $customer['allow_email'] == 'true' ? 1 : 0;
            $user->password = bcrypt($customer['first_name'].$customer['last_name']);
            $user->save();
        });
    }
}
