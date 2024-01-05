<?php

namespace App\Http\Controllers;

use App\Models\AllExamModel;
use App\Models\QuizModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\ExamResource;
use App\Models\AssignmentModel;
use App\Models\FinalExamModel;
use App\Models\MidtermModel;
use App\Models\YearModel;
use App\Http\Resources\YearResource;
use Illuminate\Support\Str;

class ExamController extends Controller
{
    public function AllExam(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'class_id' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $exam = AllExamModel::create($request->all(), [
                'class_id' => $request->class_id,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $exam,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function GetClass($id)
    {
        if (auth()->user()) {
            $exam = AllExamModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new ExamResource($exam),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function GetAllClass()
    {
        $exam = AllExamModel::all();
        return response($exam);
    }

    public function addFinalExam(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'class_id' => 'required',
                'title' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $final_exam = FinalExamModel::create($request->all(), [
                'class_id' => $request->class_id,
                'title' => $request->title,
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

    public function addMidtermExam(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'class_id' => 'required',
                'title' => 'required',
                'subject_id' => 'required',
                'date_time' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $midterm = MidtermModel::create($request->all(), [
                'class_id' => $request->class_id,
                'title' => $request->title,
                'subject_id' => $request->subject_id,
                'date_time' => $request->date_time,
            ]);
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

    public function addQize(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'class_id' => 'required',
                'title' => 'required',
                'subject_id' => 'required',
                'date_time' => 'required',
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }

            // $image_base64 = $request->image;
            // $extension = explode('/', explode(':', substr($image_base64, 0, strpos($image_base64, ';')))[1])[1];
            // $replace = substr($image_base64, 0, strpos($image_base64, ',') + 1);
            // $image = str_replace($replace, '', $image_base64);
            // $image = str_replace(' ', '+', $image);
            // $imageName = Str::random(10) . '.' . $extension;
            // Storage::disk('public')->put($imageName, base64_decode($image));


            $midterm = QuizModel::create([
                'class_id' => $request->class_id,
                'title' => $request->title,
                'date_time' => $request->date_time,
                'subject_id' => $request->subject_id,
                // 'image' => $imageName
            ]);
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

    public function addAssignment(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'class_id' => 'required',
                'title' => 'required',
                'subject_id' => 'required',
                'date_time' => 'required',
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $assignment = AssignmentModel::create($request->all(), [
                'class_id' => $request->class_id,
                'title' => $request->title,
                'subject_id' => $request->subject_id,
                'date_time' => $request->date_time,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $assignment,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function addYear(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'year' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $year = YearModel::create($request->all(), [
                'year' => $request->year,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $year,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function Year()
    {
        if (auth()->user()) {
            $year = YearModel::all();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => YearResource::collection($year),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }
}
