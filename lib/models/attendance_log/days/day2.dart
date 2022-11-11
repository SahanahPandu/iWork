class Day2 {
  final String date;
  final String timeIn;
  final String timeOut;

  const Day2({required this.date, required this.timeIn, required this.timeOut});

  static Day2 fromJson(json) => Day2(
    date: json['date'] ?? "",
    timeIn: json['timeIn'] ?? "",
    timeOut: json['timeOut'] ?? "",
  );
}
