class BloggerTextModel{
  String? id;
  String? userid;
  String? title;
  String? blogText;
  String? image;

  BloggerTextModel({this.id,this.userid,this.title,this.blogText,this.image});

  factory BloggerTextModel.fromMap(Map<String,dynamic> map){
    return BloggerTextModel(
      userid: map['userid'],
      id:  map['blogid'],
      title: map['title'],
      blogText: map['blogtext'],
      image: map['image'],
    );
  }
}