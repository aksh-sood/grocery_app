import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:grocery_app/models/customer.dart';
import 'package:grocery_app/woo/config.dart';
class ApiService{
  Future<bool> createCustomer(CustomerModel model)async{
    var authToken=base64.encode(utf8.encode(Config.key+":"+Config.secret));
    bool ret=false;
    try{
      var response=await Dio().post(Config.url+Config.customerURL,
      data:model.toJson(),
      options:new Options(
        headers:{
          HttpHeaders.authorizationHeader:"Basic $authToken",
          HttpHeaders.contentTypeHeader:"application/json",
        }
      ));
      log(response.toString(),name:"res");
      if (response.statusCode == 201){
        ret=true;
      }
    }on DioError catch(e){
      if(e.response.statusCode == 404){
        ret=false;
      }else{
        ret=false;
      }
    }return ret;
  }
}