import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:playz/globals.dart';
import 'package:playz/model/Developer.dart';

class DeveloperView extends StatefulWidget {
  const DeveloperView({super.key});

  @override
  State<DeveloperView> createState() => _DeveloperViewState();
}

class _DeveloperViewState extends State<DeveloperView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  List<String> existingNames = [];

  Future getExistingsNames() async {
    var devs = await developerController.getAllAsync();
    for (var dev in devs) {
      existingNames.add(dev.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer"),
      ),
      body: FutureBuilder(
          future: getExistingsNames(),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.length < 2) {
                            return 'Name must have 2 letters or more!';
                          }
                          if (existingNames.contains(value)) {
                            return 'Name already exists!';
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          developerController.addDeveloper(Developer(
                              uuid.v1().toString(), nameController.text));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Added developer ${nameController.text}",
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.black,
                          ));
                        }
                      },
                      child: const Text("Submit"))
                ],
              ),
            );
          }),
    );
  }
}
