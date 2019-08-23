<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use SoftDeletes;

    public static function import()
    {
        $file = '/var/www/data/products.csv';

        Csv::fileToArray($file)->each(function ($item) {
            $product = new Product();
            $product->id = $item['id'];
            $product->name = $item['name'];
            $product->description = $item['description'];
            $product->weight = $item['weight'];
            $product->height = $item['height'];
            $product->color = $item['color'];
            $product->price = $item['price'];
            $product->sku = $item['sku'];
            $product->inventory_cnt = $item['inventory_cnt'];
            $product->save();
        });
    }
}
