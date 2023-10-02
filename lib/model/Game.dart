import 'package:playz/globals.dart';
import 'package:playz/model/GameViewModel.dart';

import 'Developer.dart';
import 'GamingPlatform.dart';

class Game {
  final String id;
  final String name;
  final String description;
  final Developer developer;
  final List<GamingPlatform> platforms;
  final int totalHours;
  final int rewards;
  bool imPlaying;
  final String artUrl;
  final String price;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.developer,
    required this.platforms,
    required this.totalHours,
    required this.rewards,
    required this.imPlaying,
    required this.artUrl,
    required this.price,
  });

  static Map<String, dynamic> toJson(Game game) {
    List<String> plats = [];
    for (GamingPlatform plat in game.platforms) {
      plats.add(plat.id);
    }
    return {
      'id': game.id,
      'name': game.name,
      'description': game.description,
      'developerId': game.developer.id,
      'platformsId': plats,
      'totalHours': game.totalHours,
      'rewards': game.rewards,
      'imPlaying': game.imPlaying,
      'artUrl': game.artUrl,
      'price': game.price,
    };
  }

  static Future<Game> fromViewModel(GameViewModel gvw) async {
    Developer dev = await developerController.getById(gvw.developerId);
    List<GamingPlatform> plats = await platformController.getAllAsync();

    List<GamingPlatform> gamePlats = [];

    plats.map((plat) {
      if (gvw.platformsId.contains(plat.id)) {
        gamePlats.add(plat);
      }
    }).toList();

    return Game(
        id: gvw.id,
        name: gvw.name,
        description: gvw.description,
        developer: dev,
        platforms: gamePlats,
        totalHours: gvw.totalHours,
        rewards: gvw.rewards,
        imPlaying: gvw.imPlaying,
        artUrl: gvw.artUrl,
        price: gvw.price);
  }
}
