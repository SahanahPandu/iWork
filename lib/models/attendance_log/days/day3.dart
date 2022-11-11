class Day3 {
  final String date;
  final String timeIn;
  final String timeOut;

  const Day3({required this.date, required this.timeIn, required this.timeOut});

  static Day3 fromJson(json) => Day3(
        date: json['date'] ?? "",
        timeIn: json['timeIn'] ?? "",
        timeOut: json['timeOut'] ?? "",
      );
}
