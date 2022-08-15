class WorkshopVehicle {
  final int id;
  final String status;
  final int statusId;
  final String vehicleNo;
  final String akbkNo;
  final String breakdownType;
  final String date;

  const WorkshopVehicle(
      {required this.id,
      required this.status,
      required this.statusId,
      required this.vehicleNo,
      required this.akbkNo,
      required this.breakdownType,
      required this.date});

  static WorkshopVehicle fromJson(json) => WorkshopVehicle(
        id: json['id'],
        status: json['status'],
        statusId: json['statusId'],
        vehicleNo: json['vehicleNo'],
        akbkNo: json['akbkNo'],
        breakdownType: json['breakdownType'],
        date: json['date'],
      );
}
