<h2 align = "center"> 1. REGULAR TASK </h2>



<h2 align = "center"> 1 TASK </h2>

To call the JSONPlaceholder API in a Flutter application, you can use the `http` package, which provides a convenient way to make HTTP requests. Below is a step-by-step guide on how to set up and call the JSONPlaceholder API in Flutter:

### 1. Set up your Flutter environment

Ensure you have Flutter installed and set up. You can check this by running:

```sh
flutter doctor
```

### 2. Create a new Flutter project

Create a new Flutter project by running:

```sh
flutter create json_placeholder_example
cd json_placeholder_example
```

### 3. Add the `http` package

Open `pubspec.yaml` and add the `http` package under dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.4
```

Run `flutter pub get` to install the package.

### 4. Create a model class

Create a model class to represent the data you will fetch from the API. For example, to fetch posts:

```dart
// lib/models/post.dart
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
```

### 5. Create a service to fetch data

Create a service to handle the API call:

```dart
// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Post> posts = body.map((dynamic item) => Post.fromJson(item)).toList();
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
```

### 6. Fetch and display data in a widget

Use the service in a Flutter widget to fetch and display the data:

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'models/post.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSONPlaceholder Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostListScreen(),
    );
  }
}

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = ApiService().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Post post = snapshot.data![index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            );
          }
        },
      ),
    );
  }
}
```

### Summary

This guide outlines how to:

1. Set up a Flutter project and add dependencies.
2. Create a model class to represent JSON data.
3. Write a service to fetch data from the JSONPlaceholder API.
4. Display the fetched data in a Flutter widget using a `FutureBuilder`.

This example can be expanded to include more features and handle other endpoints provided by the JSONPlaceholder API.



<img src = "https://github.com/fenishpatel3150/regular_task/assets/143187609/c1a286d0-e617-4680-b2b5-5cb2b25538d2" width=22% height=35%>

https://github.com/fenishpatel3150/regular_task/assets/143187609/42b2439d-3b0b-42c0-bab6-78c59a3e9c5a






<h2 align = "center"> 2 TASK </h2>

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




