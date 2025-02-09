<?php

namespace App\Providers;

<<<<<<< HEAD

=======
use Illuminate\Support\Facades\Vite;
>>>>>>> 09d6a8667e4e814e97cf05470246ab3d6e3b7f24
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
<<<<<<< HEAD
=======
        Vite::prefetch(concurrency: 3);
>>>>>>> 09d6a8667e4e814e97cf05470246ab3d6e3b7f24
    }
}
