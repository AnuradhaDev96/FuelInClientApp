class CreateDriverAccount {
  String? plateNumber, fullName, email;

  CreateDriverAccount({this.plateNumber, this.fullName, this.email,});

  CreateDriverAccount.fromMap(Map<String, dynamic> map):
        plateNumber = map["plateNumber"],
        fullName = map["fullName"],
        email = map["email"];

  Map<String, dynamic> toMap(){
    return {
      'plateNumber': plateNumber,
      'fullName': fullName,
      'email': email,
    };
  }
}