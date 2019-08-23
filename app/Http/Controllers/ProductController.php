<?php

namespace App\Http\Controllers;

use App\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Product[]|\Illuminate\Database\Eloquent\Collection
     */
    public function index()
    {
        return Product::all();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return 'Create a new product';
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return bool
     */
    public function store(Request $request)
    {
        return false;
    }

    /**
     * Display the specified resource.
     *
     * @param  Product  $product
     * @return Product
     */
    public function show($product)
    {
        return $product;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  Product  $product
     * @return void
     */
    public function edit(Product $product)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  Product  $product
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Product $product)
    {
        return 'Update product';
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  Product  $product
     * @return bool|null
     */
    public function destroy(Product $product)
    {
        return $product->delete();
    }
}
