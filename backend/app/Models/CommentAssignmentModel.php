<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CommentAssignmentModel extends Model
{
    use HasFactory;
    protected $table = "comment_assignment";
    protected $fillable = [
        'title', 'image', 'subject_id', 'assignment_id', 'user_id'
    ];
}
