<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function auth(Request $request)
    {
        if(Auth::check() === true)
        {
            return response()->json([
                'message' => 'Já logado',
                'request' => $request->all()
            ]);
        }

        $data = [
            'name' => $request->name,
            'password' => $request->password
        ];

        if(!Auth::attempt($data))
        {
            return response()->json([
                'message' => 'Dados errados',
                'request' => $request->all(),
                'data' => $data
            ]);
        }

        return response()->json([
            'message' => 'Não logado',
            'request' => $request->all(),
            'data' => $data
        ]);

    }
}