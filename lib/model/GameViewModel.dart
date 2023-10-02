class GameViewModel {
  final String id;
  final String name;
  final String description;
  final String developerId;
  final List<dynamic> platformsId;
  final int totalHours;
  final int rewards;
  bool imPlaying;
  final String artUrl;
  final String price;

  GameViewModel({
    required this.id,
    required this.name,
    required this.description,
    required this.developerId,
    required this.platformsId,
    required this.totalHours,
    required this.rewards,
    required this.imPlaying,
    required this.artUrl,
    required this.price,
  });

  static GameViewModel fromJson(Map<String, dynamic> json) {
    return GameViewModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      developerId: json['developerId'],
      platformsId: json['platformsId'],
      totalHours: json['totalHours'],
      rewards: json['rewards'],
      imPlaying: json['imPlaying'],
      artUrl: json['artUrl'],
      price: json['price'],
    );
  }
}
