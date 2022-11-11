class Day1 {
  final String date;
  final String timeIn;
  final String timeOut;

  const Day1({required this.date, required this.timeIn, required this.timeOut});

  static Day1 fromJson(json) => Day1(
        date: json['date'] ?? "",
        timeIn: json['timeIn'] ?? "",
        timeOut: json['timeOut'] ?? "",
      );
}
