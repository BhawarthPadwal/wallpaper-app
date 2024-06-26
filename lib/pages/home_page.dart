import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_wallpaper_app/pages/full_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [];
  int page = 1;

  fetchApi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'), headers: {
      'Authorization':
          'iMylXmXW5pf4ThqIWxTC247cTqO6JsL5zdsAtAoNQOx630uQe6Kdj3tX'
    }).then((value) {
      // print(value.body);
      Map<String, dynamic> result = jsonDecode(value.body);
      // print(result);
      setState(() {
        images = result['photos'];
        print(images[0]);
      });
    });
  }

  loadMore() async {
    setState(() {
      page = page + 1;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=$page';
    await http.get(Uri.parse(url), headers: {
      'Authorization':
      'iMylXmXW5pf4ThqIWxTC247cTqO6JsL5zdsAtAoNQOx630uQe6Kdj3tX'
    }).then((value) {
      // print(value.body);
      Map<String, dynamic> result = jsonDecode(value.body);
      // print(result);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreen(imgUrl: images[index]['src']['large2x'],)));
                      },
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          images[index]['src']['tiny'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
          ),
          InkWell(
            onTap: () {
              loadMore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Text(
                  'Load More',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
