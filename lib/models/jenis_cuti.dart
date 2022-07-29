class JenisCuti {
  final int id;
  final String jenisCuti;

  const JenisCuti({required this.id, required this.jenisCuti});

  static JenisCuti fromJson(json) =>
      JenisCuti(id: json['id'], jenisCuti: json['jenisCuti']);
}
