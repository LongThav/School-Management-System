<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GenderModel extends Model
{
    use HasFactory;
    protected $table = "gender";
    protected $fillable = [
        'sex', 'person_id', 'gender_id'
    ];
    public $timestamps = false;

}
