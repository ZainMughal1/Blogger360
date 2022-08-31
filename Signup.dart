import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'Services.dart';


class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final usernameC = TextEditingController();

  final passC = TextEditingController();

  File? imageFile;

  var img;

  String data = "null";

  String imageName = "noImage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup page"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    maxRadius: 45,
                    backgroundColor: Colors.grey,
                    backgroundImage:imageFile!=null? FileImage(imageFile!) : null,
                  ),
                  Positioned(
                    top: -10,
                    right: -12,
                    child: IconButton(onPressed: ()async{
                      img = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      imageName = img.name;
                      setState(() {
                        imageFile = File(img!.path);
                        data = base64Encode(imageFile!.readAsBytesSync());
                      });
                    }, icon: Icon(Icons.camera_alt,size: 28,color: Colors.blue,)),
                  )
                ],
              ),
              TextFormField(
                controller: usernameC,
                decoration: const InputDecoration(
                  label: Text("User Name"),
                  hintText: "User Name",
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: passC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Password"),
                  hintText: "Password",
                ),
              ),
              const SizedBox(height: 3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    Get.toNamed('/Login');
                  }, child: Text("Login")),
                ],),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: ()async{
                var result =await Services.signupUser(usernameC.text, passC.text, imageName,data);
                print(result);
              }, child: const Text("Signup")),
            ],
          ),
        ),
      ),
    );
  }
}
