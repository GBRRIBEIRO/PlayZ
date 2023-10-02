import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:playz/model/Developer.dart';
import 'package:playz/model/GamingPlatform.dart';

class PlatformController {
  late final CollectionReference<Map<String, dynamic>> platCollection;
  PlatformController() {
    platCollection = FirebaseFirestore.instance.collection('platforms');
  }

  void add(GamingPlatform platform) {
    var platJson = {'id': platform.id, 'name': platform.name};
    platCollection.add(platJson);
  }

  Future<List<GamingPlatform>> getAllAsync() async {
    QuerySnapshot snapshot = await platCollection.get();
    var platforms = snapshot.docs
        .map((doc) =>
            GamingPlatform.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return platforms;
  }
}
