<?php

namespace App\Services;

use App\Repositories\Eloquent\HotelRepository;

class HotelService
{
    protected $hotelRepository;
    public function __construct(HotelRepository $hotelRepository)
    {
        $this->hotelRepository = $hotelRepository;

    }

    public function all(int $active)
    {
        try {
            $hotel = $this->hotelRepository->all($active);
            if($hotel['success'] == true)
            {
                return response()->json([
                    'success' => true,
                    'all' => $this->hotelRepository->all($active)

                ], 200);

            }
            
            return response()->json([
                'success' => false,
                'message' => $hotel['message']

            ], 400);

        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => $th->getMessage(),
             'line' => $th->getLine(),
                'file' => $th->getFile()

            ]);
        }
    }

    public function create(array $data)
    {
        try {
            $hotel = $this->hotelRepository->create($data);
            
            return response()->json([
               'success' => true,
               'hotel' => $hotel

            ], 201);

        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => $th->getMessage(),
                'line' => $th->getLine()

            ]);
        }
    }
    
    public function update(array $data, int $id)
    {
        try {
            $this->hotelRepository->update($data, $id);
            
            return response()->json([
               'success' => true

            ], 201);

        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => $th->getMessage(),
                'line' => $th->getLine()

            ]);
        }
    }

    public function findHotel(string  $id)
    {
        try {
            
            return response()->json([
                'success' => true,
                'customer' => $this->hotelRepository->find($id)

            ], 201);

        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => $th->getMessage(),
                'line' => $th->getLine()

            ]);
        }
    }

    public function delete(int $id)
    {
        try {
            $this->hotelRepository->delete($id);
            return response()->json([
                'success' => true,
                'customer' => $this->hotelRepository->find($id)

            ], 201);

        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => $th->getMessage(),
                'line' => $th->getLine()

            ]);
        }
    }
}