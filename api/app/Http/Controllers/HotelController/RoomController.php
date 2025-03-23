<?php

namespace App\Http\Controllers\HotelController;

use App\Http\Controllers\Controller;
use App\Http\Requests\HotelRequest\{
    RoomRequest,
    CheckInRequest
    
};

use App\Services\HotelServices\RoomService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class RoomController extends Controller
{
    public function __construct(
        protected RoomService $roomService
    )
    {}

    public function allRooms()
    {
        Log::info('allRooms, memória: ' . memory_get_usage(true));
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

    public function reservation(Request $request)
    {
        return $this->roomService->reservation($request['paymentsValues'], $request['roomID'], $request['generateCredit'] ?? false);
        
    }
    
    public function checkReservation()
    {
        return $this->roomService->checkReservation(request('customerID'));
    }
}