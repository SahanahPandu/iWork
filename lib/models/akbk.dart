class Akbk {
  final int id;
  final String status;
  final int statusId;
  final int reportId;
  final String appliedBy;
  final String laluan;
  final String vehicleNo;
  final String akbkNo;
  final String breakdownType;
  final String date;
  final String time;
  final String odoReading;
  final String unitMeasure;
  final String odoCondition;
  final String remarkOdo;
  final String kod;
  final String remarkBreakdown;
  final String action;
  final String tyreSize;
  final String tyreLocation;
  final String issueType;
  final String otherIssues;
  final String state;
  final String district;
  final String serviceArea;
  final String repairStation;
  final String vehicleModel;
  final String vehicleType;
  final String driverName;
  final String location;
  final String dateTime;
  final String remark;

  const Akbk(
      {required this.id,
      required this.status,
      required this.statusId,
      required this.reportId,
      required this.appliedBy,
      required this.laluan,
      required this.vehicleNo,
      required this.akbkNo,
      required this.breakdownType,
      required this.date,
      required this.time,
      required this.odoReading,
      required this.unitMeasure,
      required this.odoCondition,
      required this.remarkOdo,
      required this.kod,
      required this.remarkBreakdown,
      required this.action,
      required this.tyreSize,
      required this.tyreLocation,
      required this.issueType,
      required this.otherIssues,
      required this.state,
      required this.district,
      required this.serviceArea,
      required this.repairStation,
      required this.vehicleType,
      required this.vehicleModel,
      required this.driverName,
      required this.location,
      required this.dateTime,
      required this.remark});

  static Akbk fromJson(json) => Akbk(
        id: json['id'],
        status: json['status'],
        statusId: json['statusId'],
        reportId: json['reportId'],
        appliedBy: json['appliedBy'],
        laluan: json['laluan'],
        vehicleNo: json['vehicleNo'],
        akbkNo: json['akbkNo'],
        breakdownType: json['breakdownType'],
        date: json['date'],
        time: json['time'],
        odoReading: json['odoReading'],
        unitMeasure: json['unitMeasure'],
        odoCondition: json['odoCondition'],
        remarkOdo: json['remarkOdo'],
        kod: json['kod'],
        remarkBreakdown: json['remarkBreakdown'],
        action: json['action'],
        tyreSize: json['tyreSize'],
        tyreLocation: json['tyreLocation'],
        issueType: json['issueType'],
        otherIssues: json['otherIssues'],
        state: json['state'],
        district: json['district'],
        serviceArea: json['serviceArea'],
        repairStation: json['repairStation'],
        vehicleType: json['vehicleType'],
        vehicleModel: json['vehicleModel'],
        driverName: json['driverName'],
        location: json['location'],
        dateTime: json['dateTime'],
        remark: json['remark'],
      );
}
