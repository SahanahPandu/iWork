import 'package:eswm/widgets/alert/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/attendance/worker_attendance/worker_attendance_verification.dart';
import '../../../../providers/attendance/worker_attendance_verification_api.dart';
import '../../../../utils/device/sizes.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../../widgets/alert/alert_dialog.dart';
import '../../../../widgets/alert/lottie_alert_dialog.dart';
import '../../../../widgets/custom_scroll/custom_scroll.dart';
import 'attendance_verification_detail_list.dart';

class AttendanceVerificationList extends StatefulWidget {
  const AttendanceVerificationList({Key? key}) : super(key: key);

  @override
  State<AttendanceVerificationList> createState() =>
      _AttendanceVerificationListState();
}

class _AttendanceVerificationListState
    extends State<AttendanceVerificationList> {
  IconData icon = CustomIcon.checkBoxEmpty;
  Color iconColor = grey600;

  late Future<WorkerAttendanceVerification?> _loadStaffData;
  dynamic workerList = [];
  dynamic absentWorkerList = [];

  @override
  void initState() {
    super.initState();
    tickedWorker = [];
    _loadStaffData =
        WorkerAttendanceVerificationApi.getWorkersAttendance(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: barShadowColor,
                offset: const Offset(0, 3),
                blurRadius: 8,
              )
            ]),
            child: AppBar(
              backgroundColor: white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
              ),
              title: Center(
                child: Text(
                  "Pengesahan Kehadiran",
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              actions: const [
                SizedBox(width: 50),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: grey200,
                          offset: const Offset(0, -6), //0, -4
                          blurRadius: 8,
                          spreadRadius: 0.4)
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("Senarai Pekerja",
                      style: TextStyle(
                          color: blackCustom,
                          fontSize: 16,
                          fontWeight: FontWeight.w600))),
              Expanded(
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FutureBuilder<WorkerAttendanceVerification?>(
                        future: _loadStaffData,
                        builder: (context, snapshot) {
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
                                final staffData = snapshot.data;

                                workerList = staffData!.data.workersAttend;

                                absentWorkerList =
                                    staffData.data.workersNotAttend;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 25, 10, 20),
                                      child: Text(
                                        "Telah Log Masuk Kerja",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    workerList.length > 0
                                        ? ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: workerList.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                color: white,
                                                child:
                                                    AttendanceVerificationDetailList(
                                                        data: workerList[index],
                                                        index: index,
                                                        lastIndex:
                                                            workerList.length -
                                                                1),
                                              );
                                            },
                                          )
                                        : Container(),
                                    const Divider(
                                      indent: 10,
                                      endIndent: 10,
                                      thickness: 0.5,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 20, 10, 8),
                                      child: Text(
                                        "Belum Log Masuk Kerja",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    absentWorkerList.length > 0
                                        ? ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: absentWorkerList.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                color: white,
                                                child:
                                                    AttendanceVerificationDetailList(
                                                        data: absentWorkerList[
                                                            index],
                                                        index: index,
                                                        lastIndex:
                                                            absentWorkerList
                                                                    .length -
                                                                1),
                                              );
                                            },
                                          )
                                        : Container(),
                                  ],
                                );
                              }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  blurRadius: 6,
                  spreadRadius: 0.5,
                  offset: const Offset(0, 2))
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SizedBox(
            height: 45,
            width: 150,
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  overlayColor:
                      MaterialStateColor.resolveWith((states) => green800),
                  minimumSize: MaterialStateProperty.all(
                      Size(Sizes().screenWidth(context), 41)),
                  backgroundColor: MaterialStateProperty.all(greenCustom)),
              child: Text('Sahkan Kehadiran',
                  style: TextStyle(
                      color: white, fontSize: 14, fontWeight: FontWeight.w700)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showAlertDialog(
                          context,
                          confirmation,
                          "Sahkan kehadiran pekerja yang hadir pada hari ini?",
                          cancel,
                          "Sahkan");
                    }).then((actionText) async {
                  if (actionText == "Sahkan") {
                    if (tickedWorker.isNotEmpty) {
                      List<Map<String, dynamic>> list = List.generate(
                          tickedWorker.length, (index) => {"user_id": ''});
                      for (int i = 0; i < list.length; i++) {
                        list[i] = {"user_id": tickedWorker[i]};
                      }
                      var result = await WorkerAttendanceVerificationApi
                          .updateWorkerAttendance(context, list);
                      if (result == 'ok') {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return showLottieAlertDialog(
                                context,
                                _textBuilder(),
                                "",
                                null,
                                null,
                              );
                            });
                        setState(() {
                          refresh.value = !refresh.value;
                        });
                      }
                    } else {
                      showErrorToast(context,
                          "Sila pilih pekerja yang hadir sebelum buat pengesahan kehadiran.",
                          height: 15);
                    }
                  }
                });
              },
            ),
          ),
        ));
  }

/*
  Padding _noStaffListFound(String str) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.search, color: grey400, size: 14),
          const SizedBox(width: 6),
          Text(
            str,
            style: TextStyle(fontSize: 12, color: grey500),
          ),
        ],
      ),
    );
  }
*/
  RichText _textBuilder() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Kehadiran staf anda \npada",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: greyCustom,
                height: 1.5),
            children: <TextSpan>[
              TextSpan(
                  text:
                      " ${DateFormat("dd MMMM yyyy", 'ms').format(DateTime.now())}",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, color: green)),
              TextSpan(
                  text: " telah berjaya disahkan",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: greyCustom))
            ]));
  }
}
