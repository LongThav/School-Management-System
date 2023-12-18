<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use App\Models\PaymentModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\PaymentResource;
use App\Models\User;

class PaymentController extends Controller
{
    public function AddPayment(Request $request)
    {
        if (auth()->user()) {
            $validator = Validator::make($request->all(), [
                'user_id' => 'required',
                'person_id' => 'required',
                'total_payment' => 'required'
            ]);
            if ($validator->fails()) {
                return response($validator->errors());
            }
            $payment = PaymentModel::create($request->all(), [
                'user_id' => $request->user_id,
                'person_id' => $request->person_id,
                'total_payment' => $request->total_payment
            ]);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $payment,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function GetPayment()
    {
        if (auth()->user()) {
            $payment = PaymentModel::all($payment = "*");
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => PaymentResource::collection($payment),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function ByIdPayment($id)
    {
        if (auth()->user()) {
            $payment = PaymentModel::find($id);
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => new PaymentResource($payment),
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }

    public function Payment ($id)
    {
        if (auth()->user()) {
            $user = User::find($id);
            $payment = PaymentModel::find($user);
            $user->payment = $payment;
            return response([
                "code" => 200,
                "status" => "reponse successfully",
                "data" => $user,
            ]);
        } else {
            return response([
                "status" => false,
                "message" => "User not authorized",
            ]);
        }
    }
}
