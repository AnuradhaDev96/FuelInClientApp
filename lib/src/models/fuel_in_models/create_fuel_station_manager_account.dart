class CreateFuelStationManagerAccount {
  String? licenseId, fullName, email;

  CreateFuelStationManagerAccount({this.licenseId, this.fullName, this.email,});

  CreateFuelStationManagerAccount.fromMap(Map<String, dynamic> map):
        licenseId = map["licenseId"],
        fullName = map["fullName"],
        email = map["email"];

  Map<String, dynamic> toMap(){
    return {
      'licenseId': licenseId,
      'fullName': fullName,
      'email': email,
    };
  }
}