<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ClassSubjectResource extends JsonResource
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
            'subject' => $this->getSubject ?? null,
            'final_exam' => $this->getFinalExam ?? null,
            // 'midterm' => $this->getSubject->getMidterminSubject ?? null
        ];
    }
}
