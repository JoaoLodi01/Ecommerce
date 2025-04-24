<?php

namespace App\Providers;

use App\Repositories\Contracts\RegisterContract\{
    RegisterIssuerContract,
    RegisterOwnerContract
};

use App\Repositories\Eloquent\RegisterEloquent\{
    RegisterIssuerRepository,
    RegisterOwnerRepository
};

use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(RegisterOwnerRepository::class, RegisterOwnerContract::class);
        $this->app->bind(RegisterIssuerRepository::class, RegisterIssuerContract::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Vite::prefetch(concurrency: 3);
    }
}
