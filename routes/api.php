<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ArticleController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

 // Select All
Route::get('article',[ArticleController::class , 'index'] );

// Select one
Route::get('article/{article}',[ArticleController::class , 'show'] );

// Create one:post
Route::post('article',[ArticleController::class , 'store'] );

// Update one:post
Route::put('/article/{article}',[ArticleController::class , 'update'] );

// Delete one:post
Route::delete('/article/{article}',[ArticleController::class , 'destroy'] );