<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index()
    {
        return User::all();
    }

    public function show(User $user)
    {
        return $user;
    }

    public function create()
    {
        return 'Create a new customer';
    }

    public function store()
    {
        return false;
    }

    public function edit(User $user)
    {
        return $user;
    }

    public function update(User $user)
    {
    }

    public function destroy(User $user)
    {
        return $user->delete();
    }
}
