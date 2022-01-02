class User{
  String? email;
  String? userName;
  String? password;

  User({this.email, this.userName, this.password});

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'],
        userName = json['username'];

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'username' : userName
  };

    Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
   	map['email'] = email;
		map['password'] = password;
		map['username'] = userName;

    return map;
  }

  User.map(dynamic obj) {
    this.email = obj['email'];
    this.password = obj['password'];
    this.userName = obj['username'];
  }
}