// ignore_for_file: prefer_single_quotes

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:path/path.dart';

class Crud {
  getRequest(String url) async {
    try {
//url put link of the page php pdo
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print('error ${response.statusCode}');
      }
    } catch (e) {
      print('error catch $e');
    }
  }

  //data is name of requst like name pass email

  postRequest(String url, Map data) async {
    try {
//url put link of the page php pdo
      var response = await http.post(Uri.parse(url), body: data);
      //اذا الصفحة موجودة وتم الاتصال بنجاح
      //كود الصفحة الزابطة 200
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print('error ${response.statusCode}');
      }
    } catch (e) {
      print('error catch $e');
    }
  }

  postRequestwithFile(String url, Map data, File file) async {
    var requset = http.MultipartRequest("POST", Uri.parse(url));

    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile(
      'file', stream, length,
       filename: basename(file.path));
       requset.files.add(multipartFile);

    data.forEach((key, value) {
      requset.fields[key] = value;
    });

    var myrequest = await requset.send();

    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("error ${myrequest.statusCode}");
    }
  }
}
