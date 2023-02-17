import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/report/report_schedule/report_of_schedule.dart';
import '../../../../providers/report/report_of_schedule_api.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../../widgets/cards/list_card.dart';

class ReportOfScheduleApprovalMain extends StatefulWidget {
  final int scMainId;

  const ReportOfScheduleApprovalMain({Key? key, required this.scMainId})
      : super(key: key);

  @override
  State<ReportOfScheduleApprovalMain> createState() =>
      _ReportOfScheduleApprovalMainState();
}

class _ReportOfScheduleApprovalMainState
    extends State<ReportOfScheduleApprovalMain> {
  ReportOfSchedule? reportDetail;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReportOfSchedule?>(
        future:
            ReportOfScheduleApi.getReportsOfSchedule(context, widget.scMainId),
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
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: reportDetail!.data.reports.length,
                    itemBuilder: (context, index) {
                      return ListCard(
                        data: reportDetail!.data.reports[index],
                        type: "Laporan",
                        listIndex: index,
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(CustomIcon.exclamation,
                              color: Colors.orange, size: 14),
                          const SizedBox(width: 10),
                          Text("Tiada rekod dijumpai",
                              style: TextStyle(color: grey500)),
                        ],
                      ),
                    ),
                  );
                }
              }
          }
          return Container();
        });
  }
}
