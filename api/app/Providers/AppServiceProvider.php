<?php

namespace App\Providers;

use App\Repositories\Contracts\HotelContract\RoomContract;
use App\Repositories\Eloquent\HotelEloquent\RoomRepository;
use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(RoomContract::class, RoomRepository::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Vite::prefetch(concurrency: 3);
    }
}
