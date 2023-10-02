class GamingPlatform {
  final String id;
  final String name;

  GamingPlatform(this.id, this.name);

  static GamingPlatform fromJson(Map<String, dynamic> json) {
    return GamingPlatform(json['id'], json['name']);
  }
}
