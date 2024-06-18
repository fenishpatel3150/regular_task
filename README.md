<h2 align = "center"> 1. REGULAR TASK </h2>

To resolve this issue, I will break it down into a step-by-step process:

1. **Ensure Dependencies**: Make sure you have the necessary dependencies in your `pubspec.yaml` file for both `provider` and `http` (for API calls).
2. **HomeProvider**: Implement the `HomeProvider` class that fetches data from an API and manages the loading state.
3. **Main App Configuration**: Set up the `main.dart` to initialize the `HomeProvider`.
4. **UrlScreen Widget**: Use the `UrlScreen` widget to display the data fetched by the `HomeProvider`.

Here's how to do it:

### Step 1: Update `pubspec.yaml`
Ensure you have the dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  http: ^0.13.3
```

### Step 2: Implement `HomeProvider`

Create a new file `home_provider.dart` under `lib/screen/provider/second/`:

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeProvider extends ChangeNotifier {
  bool isLoading = true;
  Map<String, dynamic> data = {};

  HomeProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    final url = 'YOUR_API_URL_HERE'; // Replace with your API URL
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }
}
```

### Step 3: Initialize `HomeProvider` in `main.dart`

Update your `main.dart` file:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regular_task/screen/provider/second/home_provider.dart';
import 'package:regular_task/screen/view/second/url_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: MaterialApp(
        home: UrlScreen(),
      ),
    );
  }
}
```

### Step 4: Update `UrlScreen` Widget

Make sure your `UrlScreen` widget is using the correct paths and structure. Update the import paths if necessary:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regular_task/screen/provider/second/home_provider.dart';

class UrlScreen extends StatelessWidget {
  const UrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: homeProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: homeProvider.data['hits'].length,
              itemBuilder: (context, index) => Container(
                height: 50,
                width: 50,
                child: Image.network(
                  homeProvider.data['hits'][index]['largeImageURL'],
                ),
              ),
            ),
    );
  }
}
```

### Summary
1. Add necessary dependencies in `pubspec.yaml`.
2. Create and implement `HomeProvider` to fetch data and manage loading state.
3. Initialize `HomeProvider` in `main.dart` using `ChangeNotifierProvider`.
4. Use `UrlScreen` widget to display the data fetched by `HomeProvider`.

Replace `'YOUR_API_URL_HERE'` with the actual URL of your API. This should solve the problem and correctly display the images in a grid view once the data is fetched.


<img src = "https://github.com/fenishpatel3150/regular_task/assets/143187609/5d4ccf6e-6569-401b-9a94-8a87a04a5916" width=22% height=35%>



https://github.com/fenishpatel3150/regular_task/assets/143187609/8c57674a-f20d-4230-8191-4196fa37523b




