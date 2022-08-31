import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Models/BloggerTextModel.dart';
import '../Services.dart';

class ShowMyBlog extends StatefulWidget {
  const ShowMyBlog({Key? key}) : super(key: key);

  @override
  State<ShowMyBlog> createState() => _ShowMyBlogState();
}

class _ShowMyBlogState extends State<ShowMyBlog> {

  Future<List<BloggerTextModel>> getData()async{
    return await Services.showmynews(GetStorage().read('currentUserId'));
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
        title: Text("My News"),
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
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                final BloggerTextModel model = snapshot.data[index];
                return InkWell(
                  onTap: (){
                    Get.toNamed('/DetailNews', arguments: [model.userid!, model.id!]);
                  },
                  child: ListTile(
                    title: Text(model.title!),
                    leading: model.image == "noImage"? Text(""):Image.network("http://10.211.0.190/Blogger360/images/${model.image}",width: 50,height: 50,),
                    trailing: IconButton(onPressed: ()async{
                      String result =await Services.deletemyNews(model.id!);
                      setState((){});
                      print(result);
                    }, icon: Icon(Icons.delete),),
                  ),
                );
              }
          );
        },
      ),
    );
  }
}
