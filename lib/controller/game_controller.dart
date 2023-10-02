import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playz/model/Game.dart';
import 'package:playz/model/GameViewModel.dart';
import 'package:playz/model/GamingPlatform.dart';
import 'package:playz/view/game_view.dart';

import '../model/Developer.dart';

class GameController {
  late final CollectionReference<Map<String, dynamic>> gamesCollection;

  GameController() {
    gamesCollection = FirebaseFirestore.instance.collection('games');
  }

  Future<List<GameViewModel>> getAll() async {
    QuerySnapshot snapshot = await gamesCollection.get();
    return snapshot.docs.map((doc) {
      return GameViewModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  void changePlayingStatus(Game game) {
    if (game.imPlaying == true) {
    } else {}
  }

  void addGame(GameViewModel gameViewModel) async {
    Game game = await Game.fromViewModel(gameViewModel);
    var newGame = Game.toJson(game);
    gamesCollection.add(newGame);
  }

  Stream<List<GameViewModel>> getAllStream() =>
      gamesCollection.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => GameViewModel.fromJson(doc.data()))
          .toList());
}
