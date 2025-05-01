<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('ncms', function (Blueprint $table) {
            $table->id();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->string('ncm', 8);
            $table->unique(['issuer_id', 'ncm']);
            $table->string('description', 500);
            $table->float('nacional_federal', 16,2);
            $table->float('importados_federal', 16,2);
            $table->float('estadual', 16,2);
            $table->float('municipal', 16,2);
            $table->date('inicio');
            $table->date('fim');
            $table->string('chave');
            $table->string('versao', 8);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ncms');
    }
};
