<?php

namespace App\Http\Controllers\HotelController;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Http\Requests\HotelRequest\HotelDetailRequest;
use App\Services\HotelServices\HotelService;

class HotelController extends Controller
{
    protected $hotelService;
    public function __construct(HotelService $hotelService)
    {
        $this->hotelService = $hotelService;
    }

    public function allHotel()
    {
        return $this->hotelService->all(1);
    }

    public function create(HotelDetailRequest $request)
    {
        $data = $request->validated();
        return $this->hotelService->create($data);

    }

    public function update(HotelDetailRequest $request, int $id)
    {
        $data = $request->validated();
        return $this->hotelService->update($data, $id);

    }

    public function findHotel(Request $request)
    {
        return $this->hotelService->findHotel($request->input('param'));
        
    }

    public function delete(int $id)
    {
        return $this->hotelService->delete($id);

    }
}
