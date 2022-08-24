import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../providers/pekerja_api.dart';
import '../../../../utils/custom_icon.dart';
import '../../../../utils/device.dart';
import '../../../../widgets/alert/alert_dialog.dart';
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
        appBar: AppBar(
          backgroundColor: appBarBgColor,
          elevation: 1,
          shadowColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CustomIcon.arrowBack,
                color: blackCustom, size: 22),
          ),
          title: Center(
            child: Text(
              "Pengesahan",
              style: TextStyle(
                fontSize: 15,
                color: grey800,
                fontWeight: FontWeight.w700,
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
                          color: grey500, fontWeight: FontWeight.w700))),
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
                  }
                });
              },
            ),
          ),
        ));
  }
}
