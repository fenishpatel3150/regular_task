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
      body: Consumer<JsonProvider>(
        builder: (context, JsonProvider, child) {
          if (jsonProviderTrue.albumList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: List.generate(
              jsonProviderTrue.albumList.length,
                  (index) => ListTile(
                // id, post id
                leading: Column(
                  children: [
                    Text(
                      '${jsonProviderTrue.albumList[index].id}',
                    ),
                  ],
                ),
                // title

                // body, email

              ),
            ),
          );
        },
      ),
    );
  }
}