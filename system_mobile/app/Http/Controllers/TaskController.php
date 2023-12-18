<?php

namespace App\Http\Controllers;

use App\Http\Resources\AllAnswerQuizResource;
use App\Http\Resources\AllAssignmentResource;
use App\Http\Resources\AllMidtermResource;
use App\Http\Resources\SubjectResource;
use App\Http\Resources\TaskAssignmentResource;
use App\Http\Resources\TaskMidtermResource;
use App\Http\Resources\WhoSubmitResource;
use App\Models\AnswerQuizModel;
use App\Models\ClassModel;
use App\Models\QuizModel;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Http\Resources\TaskQuizResoure;
use App\Models\AnswerAssignmentModel;
use App\Models\AnswerMidtermModel;
use App\Models\AssignmentModel;
use App\Models\EventModel;
use App\Models\FinalExamModel;
use App\Models\MidtermModel;
use App\Models\PersonModel;
use App\Models\SubjectModel;
use App\Models\User;

class TaskController extends Controller
{
    public function SubmitAnswerQuiz(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'subject_id' => 'required',
                'quiz_id' => 'required',
                'title' => 'required',
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $answer_quiz = AnswerQuizModel::create([
                'subject_id' => $request->subject_id,
                'quiz_id' => $request->quiz_id,
                'title' => $request->title,
                'user_id' => auth()->user()->id,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $answer_quiz,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function QuestionQuiz($id)
    {
        if (auth()->user()) {
            $quiz = QuizModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new TaskQuizResoure($quiz),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AddAnserMidterm(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'subject_id' => 'required',
                'midterm_id' => 'required',
                'title' => 'required',
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $answer_quiz = AnswerMidtermModel::create([
                'subject_id' => $request->subject_id,
                'midterm_id' => $request->midterm_id,
                'title' => $request->title,
                'user_id' => auth()->user()->id,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $answer_quiz,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function QuestionMidterm($id)
    {
        if (auth()->user()) {
            $quiz = MidtermModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new TaskMidtermResource($quiz),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AddAnserAssignment(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'subject_id' => 'required',
                'assignment_id' => 'required',
                'title' => 'required',
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $answer_quiz = AnswerAssignmentModel::create([
                'subject_id' => $request->subject_id,
                'assignment_id' => $request->assignment_id,
                'title' => $request->title,
                'user_id' => auth()->user()->id,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $answer_quiz,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function QuestionAssignment($id)
    {
        if (auth()->user()) {
            $quiz = AssignmentModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new TaskAssignmentResource($quiz),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AllAnswerQuiz($id)
    {
        if (auth()->user()) {
            $quiz = QuizModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new AllAnswerQuizResource($quiz),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AllAssignment($id)
    {
        if (auth()->user()) {
            $quiz = AssignmentModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new AllAssignmentResource($quiz),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }
    public function AllMidterm($id)
    {
        if (auth()->user()) {
            $quiz = MidtermModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new AllMidtermResource($quiz),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function WhoSubmit($id)
    {
        if (auth()->user()) {
            $user = User::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new WhoSubmitResource($user),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AddScoreQuiz(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'score' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $quiz = AnswerQuizModel::find($id);
            $quiz->score = $request->score;
            $quiz->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $quiz,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AddScoreMidterm(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'score' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $quiz = AnswerMidtermModel::find($id);
            $quiz->score = $request->score;
            $quiz->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $quiz,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AddScoreAssignment(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'score' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $quiz = AnswerAssignmentModel::find($id);
            $quiz->score = $request->score;
            $quiz->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $quiz,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function UpdateAnswerQuiz(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'title' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $quiz = AnswerQuizModel::find($id);
            $quiz->title = $request->title;
            $quiz->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $quiz,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function UpdateAnswerMidterm(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'title' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $midterm = AnswerMidtermModel::find($id);
            $midterm->title = $request->title;
            $midterm->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $midterm,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function UpdateAnswerAssignment(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'title' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $quiz = AnswerAssignmentModel::find($id);
            $quiz->title = $request->title;
            $quiz->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $quiz,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function FinalExam(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'subject_id' => 'required',
                'title' => 'required',
                'class_id' => 'required',
                'date_time' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $final_exam = FinalExamModel::create([
                'subject_id' => $request->subject_id,
                'title' => $request->title,
                'class_id' => $request->class_id,
                'date_time' => $request->date_time
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $final_exam,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }


    public function finalExamInSubject($id)
    {
        if (auth()->user()) {
            $subject = SubjectModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new SubjectResource($subject),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AddEvent(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'event_title' => 'required',
                'date_time' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $event = EventModel::create([
                'event_title' => $request->event_title,
                'date_time' => $request->date_time,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $event,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function GetEvent()
    {
        if (auth()->user()) {
            $event = EventModel::all();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $event,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AddLatLong(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'lat' => 'required',
                'long' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }

            $added = PersonModel::find($id);
            $added->lat = $request->lat;
            $added->long = $request->long;
            $added->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $added,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function InfoById($id)
    {
        if (auth()->user()) {
            $info = PersonModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $info,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function FindCodeIdChild($codeId)
    {
        if (auth()->user()) {
            $codeId = PersonModel::all($codeId);
            
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }
}
