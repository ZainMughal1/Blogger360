import 'package:blogger360/NewsWriter/NewsWriterProfile.dart';
import 'package:blogger360/ShowAllBlog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'ShowMyNews.dart';

import '../WriteNews.dart';
class BloggerHome extends StatefulWidget {
  const BloggerHome({Key? key}) : super(key: key);

  @override
  State<BloggerHome> createState() => _BloggerHomeState();
}

class _BloggerHomeState extends State<BloggerHome> {
  int _currentIndex = 0;
  List widgetsList = [
    WriteBlog(),
    ShowMyBlog(),
    ShowAllBlog(),
    NewsWriterProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetsList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (v){
          setState((){
            _currentIndex = v;
          });
          // if(v==3){
          //   Get.offAllNamed('/Login');
          // }
          // else{
          //
          // }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.edit),
            label: "Write Blog"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_snippet),
              label: "My Blogs"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Blogs"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"
          ),
        ],
      ),
    );
  }
}

