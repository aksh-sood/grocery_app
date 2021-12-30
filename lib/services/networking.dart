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

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(
        Uri.parse(Config.url + url),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        var jsonResponse = convert.jsonDecode(response.body);

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
}
