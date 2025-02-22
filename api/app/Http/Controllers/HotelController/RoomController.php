<?php

namespace App\Http\Controllers\HotelController;

use App\Http\Controllers\Controller;
use App\Http\Requests\HotelRequest\{
    RoomRequest,
    CheckInRequest
    
};
use App\Http\Requests\HotelRequest\ReservationRequest;
use App\Services\HotelServices\RoomService;
use Illuminate\Http\Request;

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

    public function checkIn(CheckInRequest $request)
    {
        $data = $request->validated();
        return $this->roomService->checkIn($data);        
    }

    public function reservation(ReservationRequest $request)
    {
        $data = $request->validated();
        return response()->json($data);
        return $this->roomService->reservation(request('payments_values'), request('room_id'));
        
    }
    
}   
