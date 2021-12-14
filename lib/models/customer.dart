import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:grocery_app/models/login_model.dart';
import 'package:grocery_app/services/networking.dart';
import 'package:grocery_app/woo/config.dart';

class CustomerModel {
  String email;
  String firstName;
  String lastName;
  String password;
  CustomerModel.a({this.email, this.firstName, this.lastName, this.password});
  
  Map<String, dynamic>  toJson() {
    Map<String, dynamic> map = {};
    map.addAll({
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "username": email
    });
    return map;
  }

   Future<dynamic> createUser(String body)async{
  var res=await ApiBaseHelper().post(Config.customerURL,body);
  return res;
  }
   Future<dynamic> loginUser(String username, String password)async{
     LoginResponseModel model;
  // var res=await ApiBaseHelper().post(Config.tokenUrl,body);

  try{
    var res=await Dio().post(Config.tokenUrl,
    data: {
      "username":username,
      "password":password,
      },
   options:Options(
     headers:{
                 'Access-Control-Allow-Origin':'true',
                 HttpHeaders.contentTypeHeader:"application/x-www-form-urlencoded"
     }
   )
    );
    if(res.statusCode==200){
      model=LoginResponseModel.fromJson(res.data);
    }
  }on DioError catch(e){
    log(e.message,name:"errorsignin");
  }
  return model;
  }
}
