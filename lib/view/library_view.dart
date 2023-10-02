import 'package:flutter/material.dart';
import 'package:playz/controller/game_controller.dart';
import 'package:playz/globals.dart';
import 'package:playz/model/Game.dart';
import 'package:playz/model/GameViewModel.dart';
import 'package:playz/view/widgets/game_lib_card.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GameViewModel>>(
      stream: gameController.getAllStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final games = snapshot.data;
          return Center(
            child: ListView.builder(
                itemCount: games!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: GameCard(
                      game: games[index],
                    ),
                  );
                }),
          );
        } else {
          return const Center(child: Text("No Games"));
        }
      },
    );
  }
}
