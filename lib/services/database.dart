import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String? uid;
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  DatabaseService(this.uid);

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>? ?? {};

      return Brew(
        data['name'] as String? ?? '',
        data['sugars'] as String? ?? '0',
        (data['strength'] as num?)?.toInt() ?? 0,
      );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

}