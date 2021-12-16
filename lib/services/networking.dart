import 'dart:developer';
import 'dart:io';
import 'package:grocery_app/woo/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ApiBaseHelper {
  bool status;
  var s;
  Future<dynamic> postLogin(String path, var body, String contentType) async {
    print('Api Post, url ${Config.tokenUrl}');
    try {
      print(body);
      final response =
          await http.post(Uri.parse(Config.tokenUrl), body: body, headers: {
        HttpHeaders.contentTypeHeader: contentType,
        'Access-Control-Allow-Origin': 'true',
      });
      log(response.statusCode.toString(), name: "resStat");
      log(response.body.toString(), name: "res");
      if (response.statusCode == 200 || response.statusCode == 400) {
        var jsonResponse = convert.jsonDecode(response.body);
        print('$jsonResponse');
        return jsonResponse;
      }
      return {
        'success': 'no',
        'message': 'Request failed with status: ${response.statusCode}.'
      };
    } on SocketException {
      return {'success': 'no', 'message': 'Socket Exception.'};
    }
  }

  Future<dynamic> postSignUp(String path, var body, String contentType) async {
    print('Api Post, url ${Config.url + Config.customerURL}');
    try {
      print(body);
      final response = await http.post(
          Uri.parse(Config.url +
              "$path/?consumer_key=${Config.key}&consumer_secret=${Config.secret}"),
          body: body,
          headers: {
            HttpHeaders.contentTypeHeader: contentType,
            'Access-Control-Allow-Origin': 'true',
          });
      log(response.statusCode.toString(), name: "resStat");
      log(response.body.toString(), name: "res");
      if (response.statusCode == 201 || response.statusCode == 400) {
        var jsonResponse = convert.jsonDecode(response.body);
        // String reply = await response.transform(utf8.decoder).join();
        print('$jsonResponse');
        return jsonResponse;
      }
      return {
        'success': 'no',
        'message': 'Request failed with status: ${response.statusCode}.'
      };
    } on SocketException {
      return {'success': 'no', 'message': 'Socket Exception.'};
    }
  }

  // Future<void> requestPermission(Permission permission) async {
  //   final status = await permission.request();

  //   print(status);
  //   s = status;
  //   print(s);
  // }

  // Future<dynamic> get(String url, cookie) async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse(Config.url+Config.customerURL), headers: {"cookie": "$cookie"});
  //     print(response.statusCode);
  //     print(response);
  //     log(response.headers.toString(), name: "getr");
  //     if (response.statusCode == 200 || response.statusCode == 400) {
  //       var jsonResponse = convert.jsonDecode(response.body);
  //       print('$jsonResponse');

  //       return jsonResponse;
  //     }
  //     return {
  //       'success': 'no',
  //       'message': 'Request failed with status: ${response.statusCode}.'
  //     };
  //   } on SocketException {
  //     return {'success': 'no', 'message': 'Socket Exception.'};
  //   }
  // }

  // Future<dynamic> postLogin(String url, String body) async {
  //   print('Api Post, url ${Config.url+Config.customerURL}');
  //   List value = [];
  //   try {
  //     print(body);
  //     final response =
  //         await http.post(Uri.parse(Config.url+Config.customerURL), body: body, headers: {
  //       "content-type": "application/json",
  //       "accept": "application/json",
  //     });
  //     print(response.statusCode);
  //     print(response);
  //     log(response.headers.toString(), name: "ApiBaseHelper");
  //     value.add(response.headers["set-cookie"]);
  //     if (response.statusCode == 200 || response.statusCode == 400) {
  //       var jsonResponse = convert.jsonDecode(response.body);
  //       print('$jsonResponse');
  //       value.add(jsonResponse);
  //       log(value.toString(), name: "list");
  //       return value;
  //     }
  //     return {
  //       'success': 'no',
  //       'message': 'Request failed with status: ${response.statusCode}.'
  //     };
  //   } on SocketException {
  //     return {'success': 'no', 'message': 'Socket Exception.'};
  //   }
  // }

  // Future<dynamic> postView(String url, String body, cookie) async {
  //   print('Api Post, url $baseUrl$url');
  //   try {
  //     print(body);
  //     final response =
  //         await http.post(Uri.parse('$baseUrl$url'), body: body, headers: {
  //       "content-type": "application/json",
  //       "accept": "application/json",
  //       "cookie": "$cookie"
  //     });
  //     print(response.statusCode);
  //     // log(response.body.toString(), name: "responseBody");
  //     // log(response.headers.toString(), name: "ApiBaseHelper");
  //     if (response.statusCode == 200 || response.statusCode == 400) {
  //       var jsonResponse = convert.jsonDecode(response.body);
  //       return jsonResponse["data"];
  //     }
  //     return {
  //       'success': 'no',
  //       'message': 'Request failed with status: ${response.statusCode}.'
  //     };
  //   } on SocketException {
  //     return {'success': 'no', 'message': 'Socket Exception.'};
  //   }
  // }
}
