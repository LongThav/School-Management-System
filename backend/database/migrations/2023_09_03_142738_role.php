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
        Schema::create('role', function(Blueprint $table){
            $table->id();
            $table->string('role')->nullable();
            $table->integer('class_id')->nullable();
            $table->integer('major_id')->nullable();
            $table->integer('person_id')->nullable();
            $table->integer('role_id')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('role');
    }
};
