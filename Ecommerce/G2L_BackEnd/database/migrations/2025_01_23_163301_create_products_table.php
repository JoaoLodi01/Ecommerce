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


            // XML Base -> Imposto Group
            $table->decimal('tot_trib', 15, 2)->nullable();

            // XML Base -> Icms Group
            $table->decimal('orig', 15, 2)->nullable();
            $table->string('cst', 3)->nullable();
            $table->decimal('mod_bc', 15, 2)->nullable();
            $table->decimal('bc', 15, 2)->nullable();
            $table->decimal('p_icms', 15, 4)->nullable();
            $table->decimal('icms', 15, 2)->nullable();

            // XML Base -> Ipi Group
            $table->string('cst', 3)->nullable();
            $table->decimal('c', 15, 2)->nullable();
            $table->decimal('p_ipi', 15, 4)->nullable();
            $table->decimal('ipi', 15, 2)->nullable();


            // XML Base -> Cofins Group
            $table->string('cst', 3)->nullable();
            $table->decimal('bc', 15, 2)->nullable();
            $table->decimal('p_cofins', 15, 4)->nullable();
            $table->decimal('cofins', 15, 2)->nullable();


            // XML Base -> Total Group
            $table->decimal('bc', 15, 2)->nullable();
            $table->decimal('icms', 15, 2)->nullable();
            $table->decimal('icms_deson', 15, 2)->nullable();
            $table->decimal('fcp', 15, 2)->nullable();
            $table->decimal('bcst', 15, 2)->nullable();
            $table->decimal('st', 15, 2)->nullable();
            $table->decimal('fcpst', 15, 2)->nullable();
            $table->decimal('fcpst_ret', 15, 2)->nullable();
            $table->decimal('prod', 15, 2)->nullable();
            $table->decimal('frete', 15, 2)->nullable();
            $table->decimal('seg', 15, 2)->nullable();
            $table->decimal('desc', 15, 2)->nullable();
            $table->decimal('ii', 15, 2)->nullable();
            $table->decimal('ipi', 15, 2)->nullable();
            $table->decimal('ipi_devol', 15, 2)->nullable();
            $table->decimal('pis', 15, 2)->nullable();
            $table->decimal('cofins', 15, 2)->nullable();
            $table->decimal('outro', 15, 2)->nullable();
            $table->decimal('nf', 15, 2)->nullable();
            $table->decimal('tot_trib', 15, 2)->nullable();





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
