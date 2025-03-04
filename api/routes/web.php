<?php
/*
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Inertia\Inertia;

Route::get('/', function () {
    return view('welcome');
});
<<<<<<< HEAD
=======

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;

use Inertia\Inertia;
<<<<<<< HEAD
>>>>>>> 802d3bb03fc86b4e442dcac5d0aa85d99a734f11
=======
>>>>>>> 154e4af3df38832173add8d8e14ad0f29aaae777
>>>>>>> 53fd96d2408dda43e97fc42c5c84c9ae61314947

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
*/