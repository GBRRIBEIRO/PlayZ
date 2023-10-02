class Developer {
  final String id;
  final String name;

  Developer(this.id, this.name);

  static Developer fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var name = json['name'];
    return Developer(id, name);
  }
}
