import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/models/brew.dart';
import 'package:firebase_project/models/simple_user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 0,
          sugars: doc.get('sugars') ?? '0');
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        name: snapshot.get('name'),
        strength: snapshot.get('strength'),
        sugars: snapshot.get('sugars'),
        uid: uid);
  }
}
