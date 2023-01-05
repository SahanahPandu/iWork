class ErrorPart {
  ErrorPart({
    this.deviceInfo1,
  });

  List<String>? deviceInfo1;

  factory ErrorPart.fromJson(Map<String, dynamic> json) => ErrorPart(
        deviceInfo1: List<String>.from(json["device_info_1"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "device_info_1": List<dynamic>.from(deviceInfo1!.map((x) => x)),
      };
}
