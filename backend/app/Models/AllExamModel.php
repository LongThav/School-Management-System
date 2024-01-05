<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AllExamModel extends Model
{
    use HasFactory;
    protected $table = "allExam";
    protected $fillable = [
        'class_id',
        'major_id',
        'user_id',
        'persion_id',
    ];
    public $timestamps = false;

    public function getClass(){
        return $this->belongsTo(ClassModel::class, 'id_class');
    }

    public function getFinalExam(){
        return $this->hasMany(FinalExamModel::class, 'all_exam_id');
    }
    
}
