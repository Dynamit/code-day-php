<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Store extends Model
{
    use SoftDeletes;

    public static function import()
    {
        $file = '/var/www/data/stores.csv';

        Csv::fileToArray($file)->each(function ($item) {
            $store = new Store();
            $store->id = $item['id'];
            $store->name = $item['name'];
            $store->address1 = $item['address1'];
            $store->city = $item['city'];
            $store->state = $item['state'];
            $store->zip = $item['zip'];
            $store->latitude = $item['latitude'];
            $store->longitude = $item['longitude'];
            $store->timezone = $item['timezone'];
            $store->phone = $item['phone'];
            $store->email = $item['email'];
            $store->manager = $item['manager'];
            $store->save();
        });
    }
}
