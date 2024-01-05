<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CommentQuizModel extends Model
{
    use HasFactory;
    protected $table = "comment_quize";
    protected $fillable = [
        'title', 'image', 'subject_id', 'quize_id', 'user_id'
    ];

    public function getUser(){
        return $this->belongsTo(User::class, 'user_id');
    }
}
