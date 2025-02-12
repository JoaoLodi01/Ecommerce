<?php

namespace App\Service;

use App\Repositories\Eloquent\RoomRepository;

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
                'all' => $this->roomRepository->all($active)
                
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
}