import 'package:flutter/material.dart';

//import files
import '../../../../models/report/report_details/report_details_info.dart';
import '../../../../providers/report/reports_api.dart';
import 'report_approval_main.dart';

class ReportApproval extends StatefulWidget {
  final int reportId;

  const ReportApproval({Key? key, required this.reportId}) : super(key: key);

  @override
  State<ReportApproval> createState() => _ReportApprovalState();
}

class _ReportApprovalState extends State<ReportApproval> {
  late ReportDetailsInfo reportDetail;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReportDetailsInfo?>(
        future: ReportsApi.getDetailLaporan(context, widget.reportId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
              } else {
                if (snapshot.hasData) {
                  reportDetail = snapshot.data!;
                  return ReportApprovalMain(reportData: reportDetail);
                }
              }
          } return Container();
        });
  }
}
