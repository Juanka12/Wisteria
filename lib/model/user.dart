class User {
  final String uid;
  String name;
  String surname;
  final String email;
  String mobile;

  User({this.uid, this.email});

  User.withName({this.uid, this.name,this.surname, this.email, this.mobile});

  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        name = json['name'],
        surname = json['surname'],
        email = json['email'],
        mobile = json['mobile'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'surname': surname,
      'email': email,
      'mobile': mobile,
    };
  }
}