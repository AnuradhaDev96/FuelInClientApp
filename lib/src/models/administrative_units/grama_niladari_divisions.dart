import 'package:cloud_firestore/cloud_firestore.dart';

class GramaNiladariDivisions {
  String name;
  String id;
  String sinhalaValue;

  GramaNiladariDivisions({required this.id, required this.name, required this.sinhalaValue});

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'id': id,
      'sinhalaValue': sinhalaValue,
    };
  }

  GramaNiladariDivisions.fromMap(Map<String, dynamic> map, {required this.id}):
        name = map["name"],
        sinhalaValue = map["sinhalaValue"];

  GramaNiladariDivisions.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, id: snapshot.id);

}