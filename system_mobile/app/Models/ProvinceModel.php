<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProvinceModel extends Model
{
    use HasFactory;
    protected $table = "province";
    protected $fillable = [
        'name_province', 'person_id', 'user_id'
    ];
}
