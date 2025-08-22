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
        Schema::create('configs_email', function (Blueprint $table) {
            $table->id();
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->unsignedBigInteger('config_email_code');
            $table->string('host', 14)->default('');
            $table->string('port', 5)->default('');
            $table->string('user_name', 80)->default('');
            $table->string('password', 80)->default('');
            $table->string('use_tls', 3)->default('no');
            $table->string('use_ssl', 3)->default('no');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('configs_email');
    }
};
