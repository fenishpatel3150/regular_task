import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regular_task/screen/provider/Json/jsonProvider.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {

    JsonProvider jsonProviderTrue =Provider.of<JsonProvider>(context);
    JsonProvider jsonProviderFalse =Provider.of<JsonProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body:  Consumer<JsonProvider>(
        builder: (context, commentClass, child) {
          if (commentClass.albumList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: List.generate(jsonProviderTrue.albumList.length, (index) => ListTile(
            title: Text('${jsonProviderTrue.albumList[index].title}'),

              leading:        Text('${jsonProviderTrue.albumList[index].id}'),

            )),
          );
        }
      )
    );
  }
}