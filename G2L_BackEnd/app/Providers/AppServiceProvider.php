<?php

namespace App\Providers;

use App\Exceptions\Handler;
use App\Repositories\Contracts\RegisterContract\{
    RegisterIssuerContract,
    RegisterUserContract
};

use App\Repositories\Eloquent\RegisterEloquent\{
    RegisterIssuerRepository,
    RegisterUserRepository
};
use App\Services\Contract\PayMentMethodContract;
use App\Services\PayMentMethodService;
use Illuminate\Contracts\Debug\ExceptionHandler;
use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(RegisterUserContract::class, RegisterUserRepository::class);
        $this->app->bind(RegisterIssuerContract::class, RegisterIssuerRepository::class);
        $this->app->bind(PayMentMethodContract::class, PayMentMethodService::class);
    
        $this->app->singleton(ExceptionHandler::class, Handler::class);
        
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Vite::prefetch(concurrency: 3);
    }
}
