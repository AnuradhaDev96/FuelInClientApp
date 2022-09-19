import 'package:cloud_firestore/cloud_firestore.dart';

class MembershipModel {
  ///unique id
  String nicNumber;

  String fullName;
  String? address;
  String? job;
  String? district;
  String? electoralSeat;
  String? waTelephoneNo;
  String? secondTelephoneNo;
  String? fbUserName;
  DateTime? dateInTheForm;
  DateTime? createdDate;

  ///කොට්ඨාශය
  String? kottashaya;

  ///සම්බන්ද වීමට කැමති ක්ෂේත්‍රය
  String? preferredFieldToJoin;

  ///ක්‍රියාත්මක වීමට කැමති ප්‍රදේශය
  String? preferredRegionToOperate;

  /// ගෘහ මූලික අංකය
  String? houseNumber;

  // Referenced data
  String divisionalSecretariatId;
  String gramaNiladariDivisionId;

  MembershipModel({
    required this.divisionalSecretariatId,
    required this.gramaNiladariDivisionId,
    required this.fullName,
    this.address,
    this.job,
    required this.nicNumber,
    this.district = "මාතර",
    this.electoralSeat,
    this.kottashaya,
    this.waTelephoneNo,
    this.secondTelephoneNo,
    this.preferredFieldToJoin,
    this.preferredRegionToOperate,
    this.dateInTheForm,
    this.createdDate,
    this.fbUserName,
    this.houseNumber,
  });

  Map<String, dynamic> toMap(){
    return {
      'fullName': fullName,
      'address': address,
      'job': job,
      'nicNumber': nicNumber,
      'district': district,
      'electoralSeat': electoralSeat,
      'waTelephoneNo': waTelephoneNo,
      'secondTelephoneNo': secondTelephoneNo,
      'fbUserName': fbUserName,
      'kottashaya': kottashaya,
      'preferredFieldToJoin': preferredFieldToJoin,
      'preferredRegionToOperate': preferredRegionToOperate,
      'houseNumber': houseNumber,
      'divisionalSecretariatId': divisionalSecretariatId,
      'gramaNiladariDivisionId': gramaNiladariDivisionId,
      'dateInTheForm': dateInTheForm,
      'createdDate': createdDate,
    };
  }

  MembershipModel.fromMap(Map<String, dynamic> map, {required this.nicNumber}):
        fullName = map["fullName"],
        address = map["address"],
        job = map["job"],
        district = map["district"],
        electoralSeat = map["electoralSeat"],
        waTelephoneNo = map["waTelephoneNo"],
        secondTelephoneNo = map["secondTelephoneNo"],
        fbUserName = map["fbUserName"],
        kottashaya = map["kottashaya"],
        preferredFieldToJoin = map["preferredFieldToJoin"],
        preferredRegionToOperate = map["preferredRegionToOperate"],
        houseNumber = map["houseNumber"],
        divisionalSecretariatId = map["divisionalSecretariatId"],
        gramaNiladariDivisionId = map["gramaNiladariDivisionId"],
        dateInTheForm = map["dateInTheForm"],
        createdDate = map["createdDate"];

  MembershipModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, nicNumber: snapshot.id);

}