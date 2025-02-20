import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/custom_user.dart';
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

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception("Snapshot data is null");
    }

    return UserData(
      snapshot.id,
      data['name'] ?? '',
      data['sugars'] ?? '0',
      data['strength'] ?? 0,
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return UserData(uid ?? '', '', '0', 100);
      }

      return _userDataFromSnapshot(snapshot);
    });
  }

}