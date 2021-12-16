import 'package:grocery_app/services/networking.dart';
import 'package:grocery_app/woo/config.dart';

class CustomerModel {
  String email;
  String firstName;
  String lastName;
  String password;
  String phNo;
  String address;
  CustomerModel.a(
      {this.email,
      this.firstName,
      this.lastName,
      this.password,
      this.phNo,
      this.address});
  CustomerModel.b({this.email, this.password});

  Future<dynamic> createUser() async {
    var body =
        '{"email":"$email","first_name": "$firstName","last_name": "$lastName","password":"$password","username": "$email"}';
    var res = await ApiBaseHelper()
        .postSignUp(Config.customerURL, body, "application/json");
    return res;
  }

  Future<dynamic> loginUser() async {
    var res = await ApiBaseHelper().postLogin(Config.tokenUrl,
        '{"username":"$email","password":"$password"}', "application/json");
    return res;
  }
}
