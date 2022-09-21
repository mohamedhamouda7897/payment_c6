import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{

  static late Dio dio;

  static init(){

    dio=Dio(BaseOptions(baseUrl: 'https://accept.paymob.com/api/'
        ,receiveDataWhenStatusError: true));
  }
  static Future<Response> postData({required String endPoint,required Map<String,dynamic> data})async{
    dio.options.headers={"Content-Type":"application/json"};
    return dio.post(endPoint,data: data);
  }

}