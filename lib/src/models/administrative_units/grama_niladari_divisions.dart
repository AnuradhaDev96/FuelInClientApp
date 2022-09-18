import 'package:cloud_firestore/cloud_firestore.dart';

class GramaNiladariDivisions {
  String name;
  String id;

  GramaNiladariDivisions({required this.id, required this.name});

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'id': id,
    };
  }

  GramaNiladariDivisions.fromMap(Map<String, dynamic> map, {required this.id}):
        name = map["name"];

  GramaNiladariDivisions.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, id: snapshot.id);

}