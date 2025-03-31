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
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->string('product', 255);
            $table->unsignedBigInteger('group_id');
            $table->foreign('group_id')->references('id')->on('groups')->onDelete('cascade');
            $table->string('group', 255);
            $table->integer('amount');
            $table->decimal('cost_price', 16,2);
            $table->decimal('sale_price', 16,2);
            $table->decimal('perc_lucro', 16,2);
            $table->string('cfop', 4);
            $table->string('csosn', 3);
            $table->string('ncm', 8);
            $table->string('cest', 7);
            $table->string('unit', 4)->default('UN');
            $table->boolean('active')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
