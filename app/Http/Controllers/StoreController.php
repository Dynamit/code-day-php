<?php

namespace App\Http\Controllers;

use App\Store;

use Illuminate\Http\Request;

class StoreController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Store[]|\Illuminate\Database\Eloquent\Collection
     */
    public function index()
    {
        return Store::all();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return 'Create a new store';
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
     * @param  Store  $store
     * @return Store
     */
    public function show(Store $store) {
        return $store;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  Store  $store
     * @return Store
     */
    public function edit(Store $store)
    {
        return $store;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  Store  $store
     * @return Store
     */
    public function update(Request $request, Store $store)
    {
        return $store;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  Store  $store
     * @return bool|null
     */
    public function destroy(Store $store)
    {
        return $store->delete();
    }
}
