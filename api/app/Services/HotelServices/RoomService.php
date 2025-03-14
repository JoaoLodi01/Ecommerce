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

    public function reservation(array $paymentsValues, int $roomID, bool $generateCredit)
    {
        try {
            $total = 0;
            $forms = [];

            foreach ($paymentsValues as $value) {
                $total += $value;

            }
            for ($i=0; $i < count($paymentsValues); $i++) { 
                // posição do array com o valor > 0
                // Vai ser o ID da espécie
                if($paymentsValues[$i] > 0)
                {
                    $forms[] = $i + 1; 
                    
                }
            }    

            return response()->json(
                $this->roomRepository->reservation($forms, $paymentsValues, $total, $roomID, $generateCredit)
            );
            
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'th' => $th->getMessage(),
                'file' => $th->getFile(),
                'line' => $th->getLine()

            ], 400);
        }
    }

    public function checkReservation(int $customerID)
    {
        return response()->json([
            'customer' => $this->roomRepository->checkReservation($customerID) ? $this->roomRepository->checkReservation($customerID) : null
            
        ]);
    }
}