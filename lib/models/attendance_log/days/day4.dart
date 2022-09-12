class Day4 {
  final String date;
  final String timeIn;
  final String timeOut;

  const Day4({required this.date, required this.timeIn, required this.timeOut});

  static Day4 fromJson(json) => Day4(
        date: json['date'] ?? "",
        timeIn: json['timeIn'] ?? "",
        timeOut: json['timeOut'] ?? "",
      );
}
