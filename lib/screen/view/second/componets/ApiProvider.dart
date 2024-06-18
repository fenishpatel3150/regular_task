import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class ApiServer extends ChangeNotifier{

  Future<String?> Server(String text)
  async {

    String api ="https://pixabay.com/api/?key=44445525-46b8294a8d390d41c8a03a1ed&q=$text&image_type=photo&per_page=50";

    Uri uri = Uri.parse(api);
    Response response = await http.get(uri);

    if (response.statusCode==200)
      {
        return response.body;
      }
    return null;
  }

}