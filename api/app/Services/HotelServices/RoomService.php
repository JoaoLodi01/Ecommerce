<?php

namespace App\Services\HotelServices;

use App\Repositories\Eloquent\HotelEloquent\RoomRepository;

class RoomService
{
    protected $roomRepository;

    public function __construct(RoomRepository $roomRepository)
    {
        $this->roomRepository= $roomRepository;
        
    }

    public function allRooms(int $active)
    {
        try {
            return response()->json([
                'success' => true,
                'all' => $this->roomRepository->allRooms($active)
                
            ]);

        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'th' => $th->getMessage(),
                'line' => $th->getLine()

            ]);
        }
    }

    public function create(array $data)
    {
        try {
            $create = $this->roomRepository->create($data);
            if($create == true)
            {
                return response()->json([
                    'success' => true,
                    'crate' => $create
    
                ], 201);
            }

            return response()->json([
                'success' => false,
                'crate' => $create

            ], 400);
            
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'th' => $th->getMessage(),
                'file' => $th->getFile(),
                'line' => $th->getLine()

            ], 400);
        }
    }

    public function find(string $param)
    {
        try {
            return $this->roomRepository->find($param);
            
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'th' => $th->getMessage(),
                'file' => $th->getFile(),
                'line' => $th->getLine()

            ], 400);
        }
    }
    
    public function checkIn(array $data)
    {
        try {
            
            return response()->json([
                'success' => true,
                'message' => 'Check-in bem sucedido!',
                'chek-in' => $this->roomRepository->checkIn($data)

            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'th' => $th->getMessage(),
                'file' => $th->getFile(),
                'line' => $th->getLine()

            ], 400);
        }
    }

    public function reservation(array $data, int $room_id)
    {
        try {
            $result = 0;
            $formas = [];

            foreach ($data as $value) {
                $result += $value;
                
            }

            for ($i=0; $i < count($data); $i++) { 
                if($data[$i] > 0)
                {
                    $formas[] = $i + 1;
                }
            }    
        
            return response()->json($this->roomRepository->reservation($formas, $result, $room_id));
            
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'th' => $th->getMessage(),
                'file' => $th->getFile(),
                'line' => $th->getLine()

            ], 400);
        }
    }
}