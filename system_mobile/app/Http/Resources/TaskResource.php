<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TaskResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id ?? null,
            'name' => $this->title ?? null,
            'image' => $this->image ?? null,
            'midterm' => $this->getMidterminSubject,
            'quize' => $this->getQuiz,
            'assignment' => $this->getAssignment
        ];
    }
}
