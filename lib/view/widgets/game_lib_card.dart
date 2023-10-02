import 'package:flutter/material.dart';
import 'package:playz/globals.dart';
import 'package:playz/model/Game.dart';
import 'package:playz/model/GameViewModel.dart';

class GameCard extends StatefulWidget {
  final GameViewModel game;
  const GameCard({super.key, required this.game});

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  void initState() {
    //Controllers.gameController.addGame(widget.game);

    super.initState();
  }

  void playGame() {
    if (widget.game.imPlaying) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Stopped ${widget.game.name}",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black,
      ));
      setState(() {
        widget.game.imPlaying = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Playing ${widget.game.name}",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black,
      ));
      setState(() {
        widget.game.imPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
      height: 100,
      child: Card(
        elevation: 5,
        child: Stack(children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.game.artUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Text(
                          widget.game.name,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        "Hours played: ${widget.game.totalHours}",
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: widget.game.imPlaying
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.deepOrange,
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.green,
                        ),
                  child: IconButton(
                    onPressed: () => playGame(),
                    icon: widget.game.imPlaying
                        ? const Icon(
                            Icons.close,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
