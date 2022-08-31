class BloggerModel{
  String? id;
  String? name;
  String? password;
  String? image;

  BloggerModel({this.id, this.name,this.password,this.image});


  factory BloggerModel.fromMap(Map<String,dynamic> map){
    return BloggerModel(
      id: map['id'],
      name: map['username'],
      password: map['password'],
      image: map['profileimage'],
    );
  }
}