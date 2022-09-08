import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../providers/laluan_api.dart';
import '../../../widgets/cards/verification_task/attendance/verify_attendance_list_details.dart';
import '../../work_schedule/work_schedule.dart';

class AttendanceVerification extends StatefulWidget {
  const AttendanceVerification({Key? key}) : super(key: key);

  @override
  State<AttendanceVerification> createState() => _AttendanceVerificationState();
}

class _AttendanceVerificationState extends State<AttendanceVerification> {
  late Future<List> _loadLaluanData;

  @override
  void initState() {
    super.initState();
    _loadLaluanData = LaluanApi.getLaluanData(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _loadLaluanData,
      builder: (context, snapshot) {
        final dataFuture = snapshot.data;

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );

          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text("Some errors occurred!"),
              );
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dataFuture!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: WorkSchedule(data: dataFuture[index])));
                    },
                    child: VerifyAttendanceListDetails(
                      data: dataFuture[index],
                      index: index,
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }
}
