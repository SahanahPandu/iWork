import 'package:flutter/material.dart';

import '../../../providers/laluan_api.dart';
import '../../../widgets/cards/verify_task/attendance/verify_attendance_list_details.dart';

class AttendanceVerify extends StatefulWidget {
  const AttendanceVerify({Key? key}) : super(key: key);

  @override
  State<AttendanceVerify> createState() => _AttendanceVerifyState();
}

class _AttendanceVerifyState extends State<AttendanceVerify> {
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
              return Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataFuture!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8, top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Container();
                            }),
                          );
                        },
                        child: VerifyAttendanceListDetails(
                          data: dataFuture[index],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
        }
      },
    );
  }
}
