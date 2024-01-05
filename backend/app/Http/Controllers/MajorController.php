<?php

namespace App\Http\Controllers;

use App\Http\Resources\YearResource;
use App\Models\MajorModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\MajorResource;
use App\Models\ClassModel;
use App\Models\YearModel;

class MajorController extends Controller
{
    public function AddMajor(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'major_name' => 'required',
                'year_id' => 'required',
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $major = MajorModel::create($request->all(), [
                'major_name' => $request->major_name,
                'year_id' => $request->year_id,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $major,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function GetMajor($id)
    {
        if (auth()->user()) {
            $major = MajorModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new MajorResource($major),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AllMajor()
    {
        if (auth()->user()) {
            $major = MajorModel::all($MajorModel = "*");
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => MajorResource::collection($major),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function MajorById($id)
    {
        if (auth()->user()) {
            $major = MajorModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new MajorResource($major),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function UpdateMajor(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'year_id' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $major = MajorModel::find($id);
            $major->year_id = $request->year_id;
            $major->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $major,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function UpdateClassByYear(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'id_class' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $class = YearModel::find($id);
            $class->id_class = $request->id_class;
            $class->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $class,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function AddClass(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'id_class' => 'required',
                'name_class' => 'required',
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $class = ClassModel::create($request->all(), [
                'id_class' => $request->id_class,
                'name_class' => $request->name_class,
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $class,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function MajorByIdYear($id){
        if (auth()->user()) {
            $year = YearModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new YearResource ($year),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }
}
