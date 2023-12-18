<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RoleModel extends Model
{
    use HasFactory;
    protected $table = "role";
    protected $fillable = [
        'role','person_id', 'user_id'
    ];

    public $timestamps = false;
}
