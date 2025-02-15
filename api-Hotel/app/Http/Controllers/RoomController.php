<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\CheckInRequest;
use App\Http\Requests\RoomRequest;
use App\Services\RoomService;

class RoomController extends Controller
{
    protected $roomService;
    public function __construct(RoomService $roomService)
    {
        $this->roomService = $roomService;
    }

    public function allRooms()
    {
        return $this->roomService->allRooms(1);
    }

    public function create(RoomRequest $request)
    {
        $data = $request->validated();
        return $this->roomService->create($data);
    }

    public function find(RoomRequest $request)
    {
        return $this->roomService->find($request->input('id'));
    }

    public function checkIn(/*CheckInRequest $request*/)
    {
        $data = array(
            'a' => 1, 'b' => 2
        );
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, env('ECOMMERCE_URL') . '/api/consumers/create');
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, false);

        $response = curl_exec($ch);
        if(curl_errno($ch))
        {
            return response()->json(curl_error($ch));

        }

        curl_close($ch);

        //return response()->json($response);
        
        /*$data = $request->validated();
        return $this->roomService->checkIn($data);*/
        return response()->json($response);
    }
}   
