class Penyelia {
  final String id;
  final String name;

  Penyelia({required this.id, required this.name});

  static Penyelia fromJson(json) => Penyelia(
        id: json['id'],
        name: json['name'],
      );
}
