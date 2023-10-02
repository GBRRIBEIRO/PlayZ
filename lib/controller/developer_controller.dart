import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:playz/model/Developer.dart';

class DeveloperController {
  late final CollectionReference<Map<String, dynamic>> devCollection;
  DeveloperController() {
    devCollection = FirebaseFirestore.instance.collection('developer');
  }

  void addDeveloper(Developer dev) {
    var devJson = {'id': dev.id, 'name': dev.name};
    devCollection.doc(dev.id).set(devJson);
  }

  Future<List<Developer>> getAllAsync() async {
    QuerySnapshot snapshot = await devCollection.get();
    var developers = snapshot.docs
        .map((doc) => Developer.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return developers;
  }

  Future<Developer> getById(String id) async {
    var doc = await devCollection
        .doc(id)
        .get()
        .then((value) => value.data() as Map<String, dynamic>);
    return Developer.fromJson(doc);
  }
}
