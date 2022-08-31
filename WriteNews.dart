import 'dart:convert';
import 'package:blogger360/Services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class WriteBlog extends StatefulWidget {
  const WriteBlog({Key? key}) : super(key: key);

  @override
  State<WriteBlog> createState() => _WriteBlogState();
}

class _WriteBlogState extends State<WriteBlog> {
  final titleC = TextEditingController();
  final blogC = TextEditingController();
  File? imageFile;
  var img;
  String data = "null";
  String imageName = "noImage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write Blog"),
        actions: [
          IconButton(
              onPressed: () async {
                var connectivityResult =
                    await (Connectivity().checkConnectivity());
                if (connectivityResult == ConnectivityResult.mobile) {
                  print("I am connected to a mobile network.");
                } else if (connectivityResult == ConnectivityResult.wifi) {
                  print("I am connected to a wifi network.");
                }
              },
              icon: Icon(Icons.network_check))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: titleC,
              decoration: const InputDecoration(
                label: Text("Title"),
                hintText: "Title",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: blogC,
              decoration: const InputDecoration(
                label: Text("Blog"),
                hintText: "Blog",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            imageFile == null
                ? Text("No Image")
                : Image.file(
                    imageFile!,
                    width: 200,
                    height: 200,
                  ),
            ElevatedButton(
                onPressed: () async {
                  img = await ImagePicker()
                      .pickImage(source: ImageSource.camera);
                  imageName = img.name;
                  setState(() {
                    imageFile = File(img!.path);
                    data = base64Encode(imageFile!.readAsBytesSync());
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Upload Image")
                  ],
                )),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  Services.uploadNews(GetStorage().read('currentUserId'),
                      titleC.text, blogC.text, imageName, data);
// print(result);
                },
                child: const Text("Upload")),
          ],
        ),
      ),
    );
  }
}
