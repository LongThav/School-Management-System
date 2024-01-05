<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class QuizResource extends JsonResource
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
            'quize' => $this->getQuiz,
            'cmt' => $this->getCommentInQuiz ?? null,
            'answer_quiz' => $this->getAllAsnwerQuiz ?? null,
            // 'user_anser' => $this->getAllAsnwerQuiz->getUser ?? null
        ];
    }
}
