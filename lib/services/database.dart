import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection refference
  final CollectionReference netcadCollection = FirebaseFirestore.instance.collection('Employees');

  Future updateUserData(String name, String surname,String position) async{
    return await netcadCollection.doc(uid).set({
      'name' : name,
      'surname' : surname,
      'position' : position,
    });
  }
}