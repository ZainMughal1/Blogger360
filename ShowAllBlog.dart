import 'package:blogger360/Models/BloggerModel.dart';
import 'package:blogger360/Models/BloggerTextModel.dart';
import 'package:blogger360/Models/AllNewsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Services.dart';

class ShowAllBlog extends StatefulWidget {
  const ShowAllBlog({Key? key}) : super(key: key);

  @override
  State<ShowAllBlog> createState() => _ShowAllBlogState();
}

class _ShowAllBlogState extends State<ShowAllBlog> {

  Future<List<AllNewsModel>> getData()async{
    return await Services.getAllData();
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
        title: Text("All Blogs"),
        actions: [
          IconButton(onPressed: ()async{
            BloggerModel model  =await Services.getUserInfo(GetStorage().read('currentUserId'));
            print(model.name);
            print(model.id);
            print(model.image);
          }, icon: Icon(Icons.add)),
        ],
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
            reverse: false,
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                final AllNewsModel model = snapshot.data[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(offset: Offset(0, 8), color: Colors.grey,blurRadius: 50)
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
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
                      Divider(height: 5,thickness: 2),
                      SizedBox(height: 5,),
                      Text(model.title!,
                        // textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),),
                      SizedBox(height: 5,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: model.image == "noImage"? Text(""): Image.network("http://10.211.0.190/Blogger360/images/${model.image}"),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        // color: Colors.white,
                        height: 50,
                        child: Text(model.blogtext!,
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              Get.toNamed('/DetailNews', arguments: [model.id!, model.blogid!]);

                            },
                            child: Text("See More",style: TextStyle(color: Colors.blue),),
                          ),
                        ],)

                    ],
                  ),
                );
              }
          );
        },
      ),
    );
  }
}
