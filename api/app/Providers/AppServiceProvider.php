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
        $this->app->bind(RegisterOwnerContract::class, RegisterOwnerRepository::class);
        $this->app->bind(RegisterIssuerContract::class, RegisterIssuerRepository::class);
        //$this->app->bind(FirstStepsContract::class, RegisterIssuerRepository::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Vite::prefetch(concurrency: 3);
    }
}
