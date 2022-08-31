import 'dart:convert';
import 'package:blogger360/Models/AllNewsModel.dart';
import 'package:blogger360/Models/BloggerModel.dart';
import 'package:blogger360/Models/BloggerTextModel.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
class Services{
  static final String _login = 'login';
  static final String _signup = 'signup';
  static final String _uploadblog = 'uploadblog';
  static final String _showallblog = 'showallblog';
  static final String _showmyblog = 'showmyblog';
  static final String _deletemyblog = 'deletemyblog';
  static final String _getuserinfo = 'getuserinfo';
  static final url = Uri.parse('http://10.211.0.190/Blogger360/dbServices.php');


  static Future<String> updateUserInfo(String id, String name,String password,String image,String data)async{
    Map map = <String,dynamic>{};
    map['action'] = 'updateuserinfo';
    map['id'] = id;
    map['name'] = name;
    map['password'] = password;
    map['image'] = image;
    map['imagedata'] = data;
    var response = await http.post(url, body: map);
    print(response.statusCode);

    if(response.statusCode==200) {
      if (response.body == "success") {
        return "success";
      }
      else{
        return "fail";
      }
    }
    else{
      return "fail";
    }
  }


  static Future<String> loginUser(String username, String password)async{
    Map map = <String,dynamic>{};
    String? currentUserid;
    map['action'] = _login;
    map['username'] = username;
    map['userpassword'] = password;

    var response = await http.post(url, body: map);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200){
      if(response.body == "fail"){
        return "fail";
      }
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      print("parsed => $parsed");
      if(parsed == null){
        return "fail";
      }
      else{
        List<BloggerModel> m =  parsed.map<BloggerModel>((json) => BloggerModel.fromMap(json)).toList();
        print("M => $m");
        for(BloggerModel model in m){
          currentUserid = model.id!;
          print(currentUserid);
        }
        await GetStorage().write('currentUserId', currentUserid);
        print("getstorage key => ${GetStorage().read('currentUserId')}");
        return "success";
      }
    }
    else{
      return "fail";
    }

  }


  static Future<String> signupUser(String username, String password, String imagename,String imagedata)async{
    Map map = <String,dynamic>{};
    map['action'] = _signup;
    map['username'] = username;
    map['userpassword'] = password;
    map['profileimage'] = imagename;
    map['imagedata'] = imagedata;
    // print("signupuser map -> $map");
    var response = await http.post(url, body: map);

    print(response.statusCode);
    print(response.body);
    return response.body;

  }

  static Future<BloggerModel> getUserInfo(String id)async{
    Map map = <String,dynamic>{};
    map['action'] = _getuserinfo;
    map['id'] = id;
    var response = await http.post(url, body: map);
    print(response.statusCode);

    if(response.statusCode==200){
      if(response.body == "fail"){
        return BloggerModel();
      }
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      print("parsed => $parsed");
      if(parsed == null){
        return BloggerModel();
      }
      else{
        List<BloggerModel> m =  parsed.map<BloggerModel>((json) => BloggerModel.fromMap(json)).toList();

        return m[0];
      }
    }
    else{
      return BloggerModel();
    }
  }

  static uploadNews(String userid, String title, String blog, String image,String data)async{
    Map map = <String,dynamic>{};
    map['action'] = _uploadblog;
    map['userid'] = userid;
    map['title'] = title;
    map['blog'] = blog;
    map['image'] = image;
    map['imagedata'] = data;
    var response = await http.post(url, body: map);

    print("response status => ${response.statusCode}");
    print("Response body => ${response.body}");
    // return response.body;

  }

  static Future<List<BloggerTextModel>> shownews()async{
    Map map = <String,dynamic>{};

    map['action'] = _showallblog;
    var response = await http.post(url, body: map);
    print("response status => ${response.statusCode}");
    print("response body => ${response.body}");
    if(response.body == "No Data Found"){
      throw "Not Data Found";
    }
    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String,dynamic>>();
      List<BloggerTextModel> blogerModel = parsed.map<BloggerTextModel>((json) => BloggerTextModel.fromMap(json)).toList();
      // print("ssss ${blogerModel[1].title}");
      return blogerModel;
    }
    else{
      return [BloggerTextModel(title: "nul", image: "nul", blogText: "null", id: "nul",userid: "null")];
      // throw "fail";
    }
  }
  static Future<List<BloggerTextModel>> showmynews(String userid)async{
    Map map = <String,dynamic>{};
    map['userid'] = userid;
    map['action'] = _showmyblog;

    var response = await http.post(url, body: map);
    print("response status => ${response.statusCode}");
    print("response body => ${response.body}");
    if(response.body == "No Data Found"){
      throw "Not Data Found";
    }
    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String,dynamic>>();
      List<BloggerTextModel> blogerModel = parsed.map<BloggerTextModel>((json) => BloggerTextModel.fromMap(json)).toList();
      // print("ssss ${blogerModel[1].title}");
      return blogerModel;
    }
    else{
      return [BloggerTextModel(title: "nul", image: "nul", blogText: "null",id: "null", userid: "null")];
      // throw "fail";
    }
  }

  static Future<String> deletemyNews(String id)async{
    Map map = <String,dynamic>{};
    map['id'] = id;
    map['action'] = _deletemyblog;
    var response = await http.post(url, body: map);
    print("response status => ${response.statusCode}");
    print("response body => ${response.body}");
    return response.body;
  }

  static Future<List<AllNewsModel>> getAllData()async{
    Map map = <String,dynamic>{};
    map['action'] = 'getcommondata';
    var response = await http.post(url, body: map);
    print("response status => ${response.statusCode}");
    print("response body => ${response.body}");
    if(response.statusCode==200){
      final parsed = json.decode(response.body).cast<Map<String,dynamic>>();
      List<AllNewsModel> allnewsmodel = parsed.map<AllNewsModel>((json) => AllNewsModel.fromMap(json)).toList();
      // print("ssss ${blogerModel[1].title}");
      return allnewsmodel;
    }
    else{
      return [AllNewsModel()];
    }
  }

  static Future<List<AllNewsModel>> getOneNewsDetail(String userid,String blogid)async{
    Map map = <String,dynamic>{};
    map['userid'] = userid;
    map['blogid'] = blogid;
    map['action'] = "getonenewsdetail";
    var response = await http.post(url, body: map);
    print("response status => ${response.statusCode}");
    print("response body => ${response.body}");
    if(response.statusCode==200){
      final parsed = json.decode(response.body).cast<Map<String,dynamic>>();
      List<AllNewsModel> allnewsmodel = parsed.map<AllNewsModel>((json) => AllNewsModel.fromMap(json)).toList();
      // print("ssss ${blogerModel[1].title}");
      return allnewsmodel;
    }
    else{
      return [AllNewsModel()];
    }
  }

}