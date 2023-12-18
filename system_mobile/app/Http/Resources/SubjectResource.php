<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SubjectResource extends JsonResource
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
            'class_id' => $this->class_id,
            'class' => $this->getClass->name_class ?? null,
            'subjects' => [
                'title' => $this->title,
                'class_id' => $this->class_id,
                'person_id' => $this->persion_id ?? null,
                'person' => $this->getPersonInSubject ?? null,
            ],
            'final_exam' => $this->getFinalExam ?? null,
            // 'subejct' => $this->getFinalExam->getSubject ?? null,
        ];
    }
}
