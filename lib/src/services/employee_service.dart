import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/firestore_collections.dart';

import '../models/employee/employee_model.dart';
class EmployeeService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> registerEmployee(EmployeeModel employeeModel) async {
    try{
      _firebaseFirestore.runTransaction(
              (Transaction transaction) async {
            await _firebaseFirestore.collection(FirestoreCollections.employeeCollection).doc().set(employeeModel.toMap());
          }
      );
      return true;
    } catch(e){
      return false;
    }
  }

  Future<bool> updateEmployee(EmployeeModel employeeModel) async {
    try{
      _firebaseFirestore.runTransaction(
              (Transaction transaction) async {
            transaction.update(employeeModel.reference!, employeeModel.toMap());
          }
      );
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> deleteEmployee(EmployeeModel employeeModel) async {
    try{
      _firebaseFirestore.runTransaction((Transaction transaction) async {
        transaction.delete(employeeModel.reference!);
      });
      return true;
    } catch(e){
      return false;
    }
  }

  Future<List<EmployeeModel>> getEmployeesList() async{
    final QuerySnapshot result =
        await _firebaseFirestore.collection(FirestoreCollections.employeeCollection).get();

    final List<DocumentSnapshot> documents = result.docs;

    if (documents.isNotEmpty) {
      List<EmployeeModel> employeeList = [];
      for (var element in documents) {
        employeeList.add(EmployeeModel.fromSnapshot(element));
      }
      return employeeList;
    } else {
      return <EmployeeModel>[];
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getEmployeesStream() {
    final Stream<QuerySnapshot<Map<String, dynamic>>> result =
    _firebaseFirestore.collection(FirestoreCollections.employeeCollection).snapshots();
    return result;
  }

}