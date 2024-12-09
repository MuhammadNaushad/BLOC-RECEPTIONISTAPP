// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class PaginationController extends GetxController with StateMixin {
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // At the beginning, we fetch the first 20 posts
  int _page = 0;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 6;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    try {
      _isFirstLoadRunning = true;
      update();

      final res =
          await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
      _posts = json.decode(res.body);
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }
    _isFirstLoadRunning = false;
    update();
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      _isLoadMoreRunning = true;
      update();
      // Display a progress indicator at the bottom
      _page += 1; // Increase _page by 1
      try {
        final res =
            await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          _posts.addAll(fetchedPosts);
          update();
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          _hasNextPage = false;
          update();
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      _isLoadMoreRunning = false;
      update();
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void onInit() {
    super.onInit();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void onClose() {
    _controller.removeListener(_loadMore);
    super.onClose();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PaginationController());
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Kindacode.com',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: HomePage());
  }
}

class HomePage extends GetView<PaginationController> {
  // We will fetch data from this Rest api

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: GetBuilder<PaginationController>(builder: (controller) {
        return controller._isFirstLoadRunning
            ? const Center(
                child: const CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: controller._controller,
                      itemCount: controller._posts.length,
                      itemBuilder: (_, index) => Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: ListTile(
                          title: Text(controller._posts[index]['title']),
                          subtitle: Text(controller._posts[index]['body']),
                        ),
                      ),
                    ),
                  ),

                  // when the _loadMore function is running
                  if (controller._isLoadMoreRunning == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  // When nothing else to load
                  if (controller._hasNextPage == false)
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 40),
                      color: Colors.amber,
                      child: const Center(
                        child: Text('You have fetched all of the content'),
                      ),
                    ),
                ],
              );
      }),
    );
  }
}
