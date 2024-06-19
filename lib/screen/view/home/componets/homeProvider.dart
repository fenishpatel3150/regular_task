import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  Future<String> callApi(String url) async {
    Response response = await http.get((Uri.parse(url)));

    if (response.statusCode == 200){
    } else {
      log('Failed');
    }

    return response.body;
  }
}