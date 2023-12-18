<?php

namespace App\Http\Controllers;

use App\Models\ClassModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\ClassResource;
use App\Models\PaymentModel;
use App\Models\PersonModel;

class ClassController extends Controller
{
    public function AddClass(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'name_class' => 'required',
                'major_id' => 'required',
                // 'user_id' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $name_class = ClassModel::where('name_class', $request->name_class)->first();
            if ($name_class) {
                return response([
                    "message" => "Class has already",
                    "statue" => false
                ]);
            }
            $class = ClassModel::create($request->all(), [
                'major_id' => $request->major_id,
                // 'user_id' => $request->user_id,
                'name_class' => $request->name_class
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

    public function getClass()
    {
        if (auth()->user()) {
            $class = ClassModel::all($ClassModel = "*");
            if (!$class) {
                return response([
                    "status" => "No Class",
                ]);
            }
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => ClassResource::collection($class),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function ClassById($id)
    {
        if (auth()->user()) {
            if (request('query')) {
                $class = ClassModel::join('PersonModel', 'id_class', 'PersonModel.id_class')
                    ->where('name', 'like', '%' . request('query') . '%')->get()
                    ->where('codeId', 'like', '%' . request('query') . '%')->get();
            } else {
                // $class = ClassModel::all();
                $class = ClassModel::find($id);
                // $classId = ClassModel::find($id);
                $personId = PersonModel::all();
                $payment = PaymentModel::find($personId);
                $payment->payment = $payment;
                // // $personId->payment_count = $payment->count();
            }
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new ClassResource($class),
                'payment' => $payment
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function UpdatePayment(Request $request, $id)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'payment' => 'required',
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $updatePayment = PersonModel::find($id);
            $updatePayment->payment = $request->payment;
            $updatePayment->save();
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $updatePayment,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }
}
