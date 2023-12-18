<?php

namespace App\Http\Controllers;

use App\Http\Resources\AssignmentResource;
use App\Http\Resources\CommentAssigmentResource;
use App\Http\Resources\CommentQuize;
use App\Models\AssignmentModel;
use App\Models\MajorModel;
use App\Models\QuizModel;
use App\Models\SubjectModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\SubjectResource;
use App\Models\ClassModel;
use App\Http\Resources\ClassSubjectResource;
use App\Http\Resources\CommentMidterm;
use App\Http\Resources\MidtermResource;
use App\Http\Resources\QuizResource;
use App\Models\PersonModel;
use App\Http\Resources\TaskResource;
use App\Models\CommentAssignmentModel;
use App\Models\CommentMidtermModel;
use App\Models\CommentQuizModel;
use App\Models\MidtermModel;

class SubjectController extends Controller
{
    public function CreateSubject(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'class_id' => 'required',
                'title' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $title = SubjectModel::where('title', $request->title)->first();
            if ($title) {
                return response([
                    "message" => "Subject has been added",
                    "statue" => false
                ]);
            }
            $subject = SubjectModel::create($request->all());
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $subject,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function Subject()
    {
        if (auth()->user()) {
            $subject = SubjectModel::all(
                'id',
                'title',
                'class_id',
                'persion_id'
            );
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => SubjectResource::collection($subject),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function SubectById($id)
    {
        if (auth()->user()) {
            if (request('query')) {
                $class = ClassModel::join('PersonModel', 'id_class', 'PersonModel.id_class')
                    ->where('name', 'like', '%' . request('query') . '%')->get()
                    ->where('codeId', 'like', '%' . request('query') . '%')->get();
            } else {
                // $class = ClassModel::all();
                $class = ClassModel::find($id);
            }
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new ClassSubjectResource($class),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AddPersonInSubject(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'person_id' => 'required',
                'id' => 'required',
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $person = SubjectModel::find($id);
            $person->person_id = $request->person_id;
            $person->id = $request->id;
            $person->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $person,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function GetSubjectById($id)
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

    public function AddPersonIntoSubject(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'subject_id' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $codeId = PersonModel::where('codeId', $request->codeId)->first();
            if ($codeId) {
                return response([
                    "message" => "Person has been added",
                    "statue" => false
                ]);
            }
            $person = PersonModel::find($id);
            $person->subject_id = $request->subject_id;
            $person->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $person
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AllTaskByOneSubject($id)
    {
        if (auth()->user()) {
            $subject = SubjectModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new TaskResource($subject)
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function Quize($id)
    {
        if (auth()->user()) {
            $subject = SubjectModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new QuizResource($subject)
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function Assignment($id)
    {
        if (auth()->user()) {
            $subject = SubjectModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new AssignmentResource($subject)
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function Midterm($id)
    {
        if (auth()->user()) {
            $subject = SubjectModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new MidtermResource($subject)
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function CommentInQuize(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'title' => 'required',
                'subject_id' => 'required',
                'quize_id' => 'required',
                // 'user_id' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $cmt_quize = CommentQuizModel::create($request->all(), [
                'title' => $request->title,
                'subject_id' => $request->subject_id,
                'quize_id' => $request->quize_id,
                // 'user_id' => $request->user_id,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $cmt_quize
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function CmtQuize()
    {
        $cmt = CommentQuizModel::all();
        return response($cmt);
    }

    public function CommnetQuize($id)
    {
        if (auth()->user()) {
            $quize = QuizModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new CommentQuize($quize)
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function CommentInMidterm(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'title' => 'required',
                'subject_id' => 'required',
                'midterm_id' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $cmt_quize = CommentMidtermModel::create($request->all(), [
                'title' => $request->title,
                'subject_id' => $request->subject_id,
                'midterm_id' => $request->midterm_id,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $cmt_quize
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function CommentMidterm($id)
    {
        if (auth()->user()) {
            $cmtMidterm = MidtermModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new CommentMidterm($cmtMidterm),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function CommentInAssignment(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'title' => 'required',
                'subject_id' => 'required',
                'assignment_id' => 'required',
                'user' => auth()->user()
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $cmt_quize = CommentAssignmentModel::create($request->all(), [
                'title' => $request->title,
                'subject_id' => $request->subject_id,
                'assignment_id' => $request->assignment_id,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $cmt_quize
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }
    public function Commentassignment($id)
    {
        if (auth()->user()) {
            $cmtMidterm = AssignmentModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new CommentAssigmentResource($cmtMidterm),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }
}
