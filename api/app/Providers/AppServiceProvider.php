<?php

namespace App\Providers;

use App\Repositories\Contracts\CashRegister;
use App\Repositories\Eloquent\EcommerceEloquent\CashRegisterRepository;
use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(CashRegisterRepository::class, CashRegister::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Vite::prefetch(concurrency: 3);
    }
}
