class FuelInUser {
  int? id;
  String? fullName;
  String? email;
  String? role;


  FuelInUser({this.fullName, this.email, this.id, this.role,});

  FuelInUser.fromMap(Map<String, dynamic> map):
        id = map["id"],
        fullName = map["fullName"],
        email = map["email"],
        role = map["role"];

  Map<String, dynamic> toMap(){
    return {
      'fullName': fullName,
      'email': email,
      'role': role,
    };
  }
}