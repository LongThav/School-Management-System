<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ClassResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'class_name' => $this->name_class ?? null,
            'all_class' => $this->getClass->major_name ?? "no-major",
            'major_id' => $this->major_id ?? null,
            'student_id' => $this->user_id ?? null,
            'students' => $this->getAllStudent ?? null,
            'all_exam' => [
                // 'all_exam' => $this->getAllExam,
                'final_exam' => $this->getFinalExam ?? null,
                'midterm_exam' => $this->getMidtermExam ?? null,
                'quiz' => $this->getQuiz ?? null,
                'assignment' => $this->getAssignment ?? null,
            ],
            'subect' => $this->getSubject ?? null,
            // 'midterm_by_subject' => $this->getSubjectMidterm ?? null
            // 'code_id' => $this->getAllStudent->codeId,
            // 'payment_id' => $this->getAllStudent->person_id,
            // 'year' => $this->getYear
            // 'year' => $this->getAllStudent->getYear ?? null,
            // 'student' => [
            //     'user' => $this->getAllStudent,
            //     'username' => $this->getUser ?? [],
            // ],
        ];
    }
}
