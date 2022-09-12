class Day5 {
  final String date;
  final String timeIn;
  final String timeOut;

  const Day5({required this.date, required this.timeIn, required this.timeOut});

  static Day5 fromJson(json) => Day5(
        date: json['date'] ?? "",
        timeIn: json['timeIn'] ?? "",
        timeOut: json['timeOut'] ?? "",
      );
}
