<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('product_code')->index();
            $table->unique(['issuer_id', 'product_code']);
            $table->unique(['issuer_id', 'barcode']);
            $table->unique(['issuer_id', 'barcode_internal']);
            
            $table->foreign('issuer_id')->references('id')->on('issuers')->onDelete('cascade');
            $table->unsignedBigInteger('issuer_id');
            $table->string('product', 120)->nullable();
            $table->string('barcode', 14)->nullable();
            $table->string('barcode_internal', 16)->nullable();
            $table->binary('image')->nullable();
            $table->unsignedBigInteger('group_id')->nullable();
            $table->foreign('group_id')->references('id')->on('groups')->onDelete('cascade');
            $table->string('group', 120)->nullable();
            $table->float('amount', 16,2)->nullable()->default(0);
            $table->decimal('cost_price', 16,2)->nullable();
            $table->decimal('sale_price', 16,2)->nullable();
            $table->decimal('profit_percentage', 16,2)->nullable();
            $table->string('cfop', 4)->nullable();
            $table->string('ncm', 8)->nullable();
            $table->string('cest', 7)->nullable();
            $table->string('unit', 4)->default('UN');

            // tributs
            $table->string('csosncst', 3)->nullable();
            $table->string('cod_origem_icms', 2)->nullable();
            $table->string('origem_icms', 120)->nullable();
            $table->float('icms_ecf', 16,2)->nullable();
            
            $table->float('taxable_amount', 16,2)->nullable();
            $table->string('taxable_unit', 4)->nullable();
            $table->string('tax_benefit', 50)->nullable();

            $table->string('cod_ipi', 3)->nullable();
            $table->float('aliquot_ipi', 16,2)->nullable();

            $table->string('cod_pis', 3)->nullable();
            $table->float('aliquot_pis', 16,2)->nullable();

            $table->string('cod_cofins', 3)->nullable();
            $table->float('aliquot_cofins', 16,2)->nullable();

            $table->string('cod_use_type', 3)->nullable();
            $table->string('use_type', 30)->nullable();

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