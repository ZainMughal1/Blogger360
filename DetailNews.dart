import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Models/AllNewsModel.dart';
import 'Services.dart';

class DetailNews extends StatefulWidget {
  const DetailNews({Key? key}) : super(key: key);

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  List lst = Get.arguments;

  Future<List<AllNewsModel>> getData()async{
    return await Services.getOneNewsDetail(lst[0], lst[1]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NEWS"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.none && snapshot.hasData == null){
            return Center(child: Text("No Data "),);
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: Text("Waiting.."),);
          }
          if(!snapshot.hasData){
            return Center(child: Text("No Data"),);
          }
          if(snapshot.hasError){
            return Center(child: Text("Error.."),);
          }
          return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                final AllNewsModel model = snapshot.data[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          backgroundImage: NetworkImage("http://10.211.0.190/Blogger360/profileimage/${model.profileimage}"),
                        ),
                        SizedBox(width: 20,),
                        Text(model.username!,style: GoogleFonts.slabo27px(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),)
                      ],
                    ),
                    Divider(height: 10,thickness: 2),
                    Text(model.title!,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),),
                    Text(model.blogtext!,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            wordSpacing: 3
                        ),
                      ),
                    ),
                  ],
                );
              }
          );
        },
      ),
    );
  }
}


