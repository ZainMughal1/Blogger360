class AllNewsModel{
  String? id;
  String? username;
  String? blogid;
  String? title;
  String? blogtext;
  String? image;
  String? profileimage;

  AllNewsModel({this.id,this.username,this.blogid,this.title,this.blogtext,this.image,this.profileimage});

  factory AllNewsModel.fromMap(Map<String,dynamic> map){
    return AllNewsModel(
      id: map['id'],
      username: map['username'],
      blogid: map['blogid'],
      title: map['title'],
      blogtext: map['blogtext'],
      image: map['image'],
      profileimage: map['profileimage'],
    );
  }

}