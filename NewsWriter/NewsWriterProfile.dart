import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/BloggerModel.dart';
import '../Services.dart';


class NewsWriterProfile extends StatefulWidget {
  const NewsWriterProfile({Key? key}) : super(key: key);

  @override
  State<NewsWriterProfile> createState() => _NewsWriterProfileState();
}

class _NewsWriterProfileState extends State<NewsWriterProfile> {
  final nameC = TextEditingController();
  final passC = TextEditingController();
  late Future<BloggerModel> model;
  File? imageFile;
  var img;
  String data = "null";
  String imageName = "noImage";


  Future<BloggerModel> getData(){
    model  = Services.getUserInfo(GetStorage().read('currentUserId'));
    return model;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(onPressed: (){
            GetStorage().write('loginflag', false);
            Get.offAllNamed('/Login');
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<BloggerModel> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.connectionState == ConnectionState.none){
            return Text("No data found");
          }
          if(snapshot.hasError){
            return Text("Some Thing is Wrong!");
          }
          if(snapshot.hasData){
            return Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 170,),
                      CircleAvatar(
                        minRadius: 40,
                        backgroundImage: NetworkImage("http://10.211.0.190/Blogger360/profileimage/${snapshot.data!.image}"),
                        child: IconButton(onPressed: ()async{
                          img = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          imageName = img.name;
                          setState(() {
                            imageFile = File(img!.path);
                            data = base64Encode(imageFile!.readAsBytesSync());
                          });
                          setState((){});
                        }, icon: Icon(Icons.camera_alt)),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: nameC,
                        decoration: InputDecoration(
                          hintText: snapshot.data!.name,
                          label: Text(snapshot.data!.name!),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: passC,
                        decoration: InputDecoration(
                          hintText: snapshot.data!.password,
                          label: Text(snapshot.data!.password!),
                        ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: ()async{
                        final restult =await Services.updateUserInfo(GetStorage().read('currentUserId'), nameC.text, passC.text,imageName,data);
                        print(restult);
                        setState((){
                          getData();
                        });

                      }, child: Text("Update"))

                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
