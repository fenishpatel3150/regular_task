import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:regular_task/screen/view/second/componets/ApiProvider.dart';

class HomeProvider extends ChangeNotifier{
  Map data={};
  bool isLoading=false;
  Future<void> FetchData (String text)
  async {
    isLoading =false;
    notifyListeners();
    ApiServer apiServer =ApiServer();
    String? Json = await apiServer.Server(text);
    if (Json != null){
      data = jsonDecode(Json);
      log('--- Fetched Data --');
    } else {
      log('--- Null Data ---');
    }
    notifyListeners();
  }

  HomeProvider()
  {
    FetchData('nature');
  }


}