import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playz/controller/currency_input_formatter.dart';
import 'package:playz/globals.dart';
import 'package:playz/model/Developer.dart';
import 'package:playz/model/Game.dart';
import 'package:playz/model/GameViewModel.dart';
import 'package:playz/model/GamingPlatform.dart';

class GameView extends StatefulWidget {
  const GameView({super.key, this.editing = false});

  final bool editing;
  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController artController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  late List<Developer> devList = [];
  late List<GamingPlatform> platforms = [];
  List<String> selectedPlatformsIds = [];
  bool isCheckboxesValid = true;
  String selectedDeveloperId = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Adding a Game'),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: getAllRelationalData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Form(
                    key: _formKey,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          children: [
                            const Text('Name:'),
                            TextFormField(
                              textAlign: TextAlign.center,
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please insert the name!';
                                }
                              },
                            ),
                            const Text('Description:'),
                            TextFormField(
                              textAlign: TextAlign.center,
                              controller: descriptionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please insert the description!';
                                }
                              },
                            ),
                            const Text('Art Url:'),
                            TextFormField(
                              textAlign: TextAlign.center,
                              controller: artController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please insert the art url!';
                                }
                              },
                            ),
                            const Text('Price:'),
                            TextFormField(
                              textAlign: TextAlign.center,
                              controller: priceController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please insert the price!';
                                }
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyInputFormatter(),
                              ],
                            ),
                            const Text('Developer:'),
                            DropdownButtonFormField(
                                alignment: Alignment.center,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Needs a developer...";
                                  }
                                },
                                items: createMenuItems(devList),
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedDeveloperId = value;
                                  }
                                }),
                            const Text('Platforms:'),
                            ...addCheckBoxes(),
                            isCheckboxesValid
                                ? Container()
                                : Text(
                                    'Please select at least one platform!',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
                                  ),
                            TextButton(
                                onPressed: () {
                                  if (selectedPlatformsIds.isEmpty) {
                                    setState(() {
                                      isCheckboxesValid = false;
                                    });
                                  } else {
                                    setState(() {
                                      isCheckboxesValid = true;
                                    });
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    var selectedDev = devList.firstWhere(
                                        (element) =>
                                            element.id == selectedDeveloperId);
                                    var game = GameViewModel(
                                        id: uuid.v1(),
                                        name: nameController.text,
                                        description: descriptionController.text,
                                        developerId: selectedDev.id,
                                        platformsId: selectedPlatformsIds,
                                        totalHours: 0,
                                        rewards: 0,
                                        imPlaying: false,
                                        artUrl: artController.text,
                                        price: priceController.text);
                                    gameController.addGame(game);

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "Added game ${nameController.text}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Colors.black,
                                    ));
                                  }
                                },
                                child: const Text("Submit"))
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
        ));
  }

  List<DropdownMenuItem<String>> createMenuItems(List<Developer> devs) {
    List<DropdownMenuItem<String>> list = [];
    for (var dev in devs) {
      list.add(DropdownMenuItem(
        value: dev.id,
        child: Text(dev.name),
      ));
    }
    return list;
  }

  Future getAllRelationalData() async {
    platforms = await platformController.getAllAsync();
    return devList = await developerController.getAllAsync();
  }

  List<Widget> addCheckBoxes() {
    return platforms.map((plat) {
      return Container(
        child: Row(children: [
          Checkbox(
              value: selectedPlatformsIds.contains(plat.id),
              onChanged: (value) {
                if (selectedPlatformsIds.contains(plat.id)) {
                  setState(() {
                    selectedPlatformsIds.remove(plat.id);
                  });
                } else {
                  setState(() {
                    selectedPlatformsIds.add(plat.id);
                  });
                }
              }),
          Text(plat.name)
        ]),
      );
    }).toList();
  }
}
