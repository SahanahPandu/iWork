import 'package:flutter/material.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/request_worker/list/request_worker.dart';
import '../../../../providers/request_worker/request_worker_api.dart';
import '../../../../utils/device/sizes.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../../widgets/alert/alert_dialog.dart';
import '../../../../widgets/alert/lottie_alert_dialog.dart';
import '../../../../widgets/alert/toast.dart';
import '../../../../widgets/custom_scroll/custom_scroll.dart';
import 'request_worker_detail_list.dart';

class RequestWorkerList extends StatefulWidget {
  const RequestWorkerList({Key? key}) : super(key: key);

  @override
  State<RequestWorkerList> createState() => _RequestWorkerListState();
}

class _RequestWorkerListState extends State<RequestWorkerList> {
  IconData icon = CustomIcon.checkBoxEmpty;
  Color iconColor = grey600;

  dynamic workerList = [];
  dynamic absentWorkerList = [];

  late Future<RequestWorker?> _loadStaffData;

  @override
  void initState() {
    super.initState();
    tickedRequestedWorker = [];
    _loadStaffData = RequestWorkerApi.getRequestWorkerData(context);
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
                  "Pengesahan Pinjam Pekerja",
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
                      child: FutureBuilder<RequestWorker?>(
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
                                final requestedStaffData = snapshot.data;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    requestedStaffData!
                                            .data.workerRequest.isNotEmpty
                                        ? ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: requestedStaffData
                                                .data.workerRequest.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                color: white,
                                                child: RequestWorkerDetailList(
                                                    data: requestedStaffData
                                                        .data
                                                        .workerRequest[index],
                                                    index: index,
                                                    lastIndex:
                                                        requestedStaffData
                                                                .data
                                                                .workerRequest
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
              child: Text('Hantar',
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
                    if (tickedRequestedWorker.isNotEmpty) {
                      List<Map<String, dynamic>> list = List.generate(
                          tickedRequestedWorker.length,
                          (index) =>
                              {"worker_request_id": '', "has_approval": ''});
                      for (int i = 0; i < list.length; i++) {
                        list[i] = {
                          "worker_request_id": tickedRequestedWorker[i],
                          "has_approval": 1
                        };
                      }
                      var result = await RequestWorkerApi.updateRequestWorker(
                          context, list);
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
                          "Sila pilih pekerja yang boleh dipinjam sebelum hantar.",
                          height: 15);
                    }
                  }
                });
              },
            ),
          ),
        ));
  }

  Text _textBuilder() {
    return Text(
        textAlign: TextAlign.center,
        "Pengesahan pinjam pekerja telah berjaya dihantar!",
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: greyCustom,
            height: 1.5));
  }
}
