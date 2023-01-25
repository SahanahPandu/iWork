class ReportStatus {
  final int id;
  final String code;
  final String name;
  final String category;

  const ReportStatus({
    required this.id,
    required this.code,
    required this.name,
    required this.category,
  });

  factory ReportStatus.fromJson(json) => ReportStatus(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        category: json['category'],
      );
}
