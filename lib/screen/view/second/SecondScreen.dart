import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/second/HomeProvider.dart';
TextEditingController controller = TextEditingController();

class UrlScreen extends StatelessWidget {
  const UrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final providerF = context.read<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          width: 330,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black)
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              icon: IconButton(
                onPressed: (){
                  providerF.FetchData(controller.text);
                },
                icon: const Icon(Icons.search),
              ),

              hintText: 'Search',
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.history),
          )
        ],

      ),
      body: provider.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
        itemCount: provider.data['hits'].length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => Card(
            child: Image.network(
                fit: BoxFit.cover,
                '${provider.data['hits'][index]['largeImageURL']}')),
      ),
    );
  }
}
