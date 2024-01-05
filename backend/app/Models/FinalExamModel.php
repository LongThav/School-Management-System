<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FinalExamModel extends Model
{
    use HasFactory;
    protected $table = "final_exam";
    protected $fillable = [
        'class_id', 'major_id', 'all_exam_id', 'user_id', 'persion_id', 'title', 'image','subject_id', 'date_time'
    ];
    
    public function getSubject(){
        return $this->belongsTo(SubjectModel::class, 'subject_id');
    }
}
