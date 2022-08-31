import 'package:blogger360/Services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final usernameC = TextEditingController();
  final passC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                Get.toNamed('/Signup');
              }, child: Text("Create Account")),
            ],),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              final result = await Services.loginUser(usernameC.text, passC.text);
              print("result $result");
              if(result == 'success'){
                GetStorage().write('loginflag', true);
                Get.offAllNamed('/BloggerHome');
              }
            }, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
