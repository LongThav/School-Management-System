<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MajorModel extends Model
{
    use HasFactory;
    protected $table = 'Major';
    protected $fillable = [
        'major_name', 'person_id', 'user_id', 'major_id','year_id'
    ];

    public $timestamps = false;

    public function getUser(){
        return $this->belongsTo(PersonModel::class, 'person_id');
    }

    public function getAllClass(){
        return $this->hasMany(ClassModel::class, 'major_id');
    }

    public function getYear(){
        return $this->belongsTo(YearModel::class, 'year_id');
    }
}
