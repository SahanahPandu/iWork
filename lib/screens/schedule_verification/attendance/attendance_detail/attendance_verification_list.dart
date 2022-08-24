import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../providers/pekerja_api.dart';
import '../../../../utils/custom_icon.dart';
import '../../../../utils/device.dart';
import '../../../../widgets/alert/alert_dialog.dart';
import '../../../dialog/custom_dialog.dart';
import 'attendance_verification_detail_list.dart';

class AttendanceVerificationList extends StatefulWidget {
  const AttendanceVerificationList({Key? key}) : super(key: key);

  @override
  State<AttendanceVerificationList> createState() =>
      _AttendanceVerificationListState();
}

class _AttendanceVerificationListState
    extends State<AttendanceVerificationList> {
  final Devices _device = Devices();
  late Future<List> _loadPekerjaData;

  @override
  void initState() {
    super.initState();
    _loadPekerjaData = PekerjaApi.getPekerjaData(context);
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
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CustomIcon.filter,
                    color: blackCustom,
                    size: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("Senarai Pekerja",
                      style: TextStyle(
                          color: blackCustom,
                          fontSize: 15,
                          fontWeight: FontWeight.w400))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: FutureBuilder<List>(
                  future: _loadPekerjaData,
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
                              if (dataFuture.length > 1) {
                                return Container(
                                  color: white,
                                  child: AttendanceVerificationDetailList(
                                    data: dataFuture[index],
                                  ),
                                );
                              }
                              return Container();
                            },
                          );
                        }
                    }
                  },
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
                      Size(_device.screenWidth(context), 41)),
                  backgroundColor: MaterialStateProperty.all(green)),
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
                          "Sahkan kehadiran untuk pekerja yang hadir?",
                          cancel,
                          "Sahkan");
                    }).then((actionText) {
                  if (actionText == "Sahkan") {
                    Navigator.pop(context, 'refreshAttendance');
                    Navigator.push(
                        context,
                        PageTransition(
                            child: CustomDialog(text: _textBuilder()),
                            type: PageTransitionType.fade));
                  }
                });
              },
            ),
          ),
        ));
  }

  RichText _textBuilder() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Kehadiran pekerja subordinat anda \npada",
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
