import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/employee.dart';
class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection refference
  final CollectionReference netcadCollection = FirebaseFirestore.instance.collection('employees');

  Future updateUserData(String name, String surname,String position) async{
    return await netcadCollection.doc(uid).set({
      'name' : name,
      'surname' : surname,
      'position' : position,
    });
  }

  //employee list
  List<Employee> _employeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
        return Employee(
          name: doc.data() ?? '',
          surname: doc.data() ?? '',
          position: doc.data() ?? ''
          );
    }).toList();
  }


  // get employee stream
  Stream<Employee> get employees{
      return netcadCollection.snapshots()
      .map(_employeeListFromSnapshot);


  }
}