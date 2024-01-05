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
        Schema::create('class', function(Blueprint $table){
            $table->id();
            $table->string('class_id')->nullable();
            $table->string('room')->nullable();
            $table->string('name_class')->nullable();
            $table->integer('user_id')->nullable();
            $table->integer('person_id')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('class');
    }
};
