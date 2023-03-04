class FuelStation {
  int? id, managerUserId;
  String? district, localAuthority, licenseId, address;
  double? populationDensity;

  FuelStation(
      {this.id, this.managerUserId, this.district, this.localAuthority, this.licenseId, address, this.populationDensity,});

  FuelStation.fromMap(Map<String, dynamic> map):
        id = map["id"],
        managerUserId = map["managerUserId"],
        district = map["district"],
        localAuthority = map["localAuthority"],
        licenseId = map["licenseId"],
        address = map["address"],
        populationDensity = map["populationDensity"] ?? 0;

  Map<String, dynamic> toMap(){
    return {
      'district': district,
      'localAuthority': localAuthority,
      'licenseId': licenseId,
      'address': address,
      'populationDensity': populationDensity,
    };

  }
}