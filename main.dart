import 'dart:math';

import 'package:blogger360/DetailNews.dart';

import 'NewsWriter/NewsWriterHome.dart';
import 'ShowAllBlog.dart';
import 'package:blogger360/ShowAllBlog.dart';
import 'package:blogger360/Signup.dart';
import 'package:blogger360/WriteNews.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Login.dart';
bool loginflag = false;
getlogiflag()async{
  loginflag =   await GetStorage().read('loginflag');
}
void main() async{
  await GetStorage.init();
  getlogiflag();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      themeMode: ThemeMode.dark,
      initialRoute: loginflag == true ? '/BloggerHome': '/Login',
      routes: {
        '/Login': (context) => Login(),
        '/Signup': (context) => Signup(),
        '/WriteBlog': (context) => WriteBlog(),
        '/ShowAllBlog': (context) => ShowAllBlog(),
        '/BloggerHome': (context) => BloggerHome(),
        '/DetailNews': (context) => DetailNews(),
      },
    );
  }

}
