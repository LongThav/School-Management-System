<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaymentModel extends Model
{
    use HasFactory;
    protected $table = "payment";
    protected $fillable = [
        'name', 
        'person_id', 
        'total_payment', 
        'major', 
        'major_id', 
        'user_id',
        'id_class',
    ];

    public $timestamps = false;


    public function getUser(){
        return $this->belongsTo(User::class, 'user_id');
    }

    public function getPerson(){
        return $this->belongsTo(PersonModel::class, 'person_id');
    }
}
