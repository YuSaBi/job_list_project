/*
class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

class LoginRequestModel {
  final String username;
  final String password;

  const LoginRequestModel({
    required this.username,
    required this.password,
  });

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map={
      'username':username.trim(),
      'password': password.trim(),
    };
    return map;
  }
}
*/