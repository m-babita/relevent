class UserModel {
  String? name;
  String? email;
  String? role;
  String? uid;

// receiving data
  UserModel({this.name, this.uid, this.email, this.role});
  factory UserModel.fromMap(map) {
    return UserModel(
      name: map['name'],
      uid: map['uid'],
      email: map['email'],
      role: map['role'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'email': email,
      'role': role,
    };
  }
}
