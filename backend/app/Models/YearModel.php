<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class YearModel extends Model
{
    use HasFactory;
    protected $table = "year";
    protected $fillable = ['id_class', 'year', 'major_id', 'user_id', 'persion_id', 'year_id'];

    public function getMajor(){
        return $this->hasMany(MajorModel::class, 'year_id');
    }

    public function getAllStudent(){
        return $this->hasMany(PersonModel::class, 'year_id');
    }

    public function getAllClass(){
        return $this->hasMany(ClassModel::class, 'id_class');
    }
}


