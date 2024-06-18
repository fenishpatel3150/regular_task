import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:regular_task/screen/model/alubum.dart';

import 'homeProvider.dart';

class JsonProvider extends ChangeNotifier {
      List<Album> albumList = [];

      List<Album> get Albumlist => albumList;

      JsonProvider() {
            getData();
      }

      Future<void> getData() async {
            String json = await ApiService()
                .callApi('https://jsonplaceholder.typicode.com/album');
            List data = await jsonDecode(json);

            // convert into object data
            albumList = data.map((e) => Album.fromJson(e)).toList();

            // Notify listeners after updating the data
            notifyListeners();
      }
}







