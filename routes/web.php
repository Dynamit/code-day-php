<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

// Customer routes
Route::get('/customers', 'UserController@index');
Route::get('/customers/create', 'UserController@create');
Route::get('/customers/{user}', 'UserController@show');
Route::get('/customers/{user}/edit', 'UserController@edit');
Route::post('/customers', 'UserController@store');
Route::put('/customers/{user}', 'UserController@update');
Route::delete('/customers/{user}', 'UserController@destroy');

// Product routes
Route::get('/products', 'ProductController@index');
Route::get('/products/create', 'ProductController@create');
Route::get('/products/{product}', 'ProductController@show');
Route::get('/products/{product}/edit', 'ProductController@edit');
Route::post('/products', 'ProductController@store');
Route::put('/products/{product}', 'ProductController@update');
Route::delete('/products/{product}', 'ProductController@destroy');

// Store routes
Route::get('/stores', 'StoreController@index');
Route::get('/stores/create', 'StoreController@create');
Route::get('/stores/{store}', 'StoreController@show');
Route::get('/stores/{store}/edit', 'StoreController@edit');
Route::post('/stores', 'StoreController@store');
Route::put('/stores/{store}', 'StoreController@update');
Route::delete('/stores/{store}', 'StoreController@destroy');
