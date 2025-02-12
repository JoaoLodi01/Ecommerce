<?php

namespace App\Providers;

use App\Repositories\Eloquent\{
    HotelRepository,
    RoomRepository
};

use App\Repositories\Interface\{
    RoomContract,
    HotelDetailContract
};

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(HotelDetailContract::class, HotelRepository::class);
        $this->app->bind(RoomContract::class, RoomRepository::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
     
    }
}
