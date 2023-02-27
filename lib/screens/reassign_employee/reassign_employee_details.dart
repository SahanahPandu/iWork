import 'package:dotted_border/dotted_border.dart';
import 'package:eswm/models/schedule/schedule_data_detail_cp_sv/schedule_detail.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../employee_list/employee_list.dart';
import '../list_of_employees/list_of_employee_details.dart';

class ReassignEmployeeDetails extends StatefulWidget {
  final dynamic passData; //data schedule id and absence employee

  const ReassignEmployeeDetails({
    Key? key,
    required this.passData,
  }) : super(key: key);

  @override
  State<ReassignEmployeeDetails> createState() =>
      _ReassignEmployeeDetailsState();
}

class _ReassignEmployeeDetailsState extends State<ReassignEmployeeDetails> {
  //assigned employee
  dynamic dataEmployee2;
  Color textColor = greenCustom;
  String noReassignLink = "Teruskan Tanpa Ganti";
  String noReassignText =
      "Pekerja tidak diganti dengan mana-mana pekerja lain . Tugasan akan terus dilakukan tanpa pekerja gantian.";
  bool noReassignTextVisibility = false;
  bool noReassignLinkVisibility = true;

  loadData() {
    if (widget.passData['absentStaff'] != null) {
      WorkerSchedule dataAbsent = widget.passData['absentStaff'];

      if (dataAbsent.statusCode != "WSC" &&
          dataAbsent.reassignWihUserId != null) {
        UserId reassignUser = dataAbsent.reassignWihUserId!;
        setState(() {
          dataEmployee2 = reassignUser;
          noReassignLinkVisibility = false;
        });
      }
    }
  }

  getAssignedEmployeeDetails(dynamic data) {
    // print("panggil ni");
    if (data != null) {
      if (mounted) {
        setState(() {
          dataEmployee2 = data;
        });
      }
    }

    //update reassign list
    if (widget.passData['updateReassign'] != null) {
      Function(int, int, int?, int?) updateReassign =
          widget.passData['updateReassign'];

      WorkerSchedule absentStaff = widget.passData['absentStaff'];
      updateReassign(absentStaff.id!, 1, data.id, data.userDetail.supervisorId);
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // print('Reassign Employee Details Dispose');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        absentEmployeeSection(),
        const SizedBox(
          height: 12,
        ),
        if (dataEmployee2 != null)
          const Center(
            child: Icon(
              Icons.swap_vertical_circle_rounded,
              size: 25,
              color: Color(0xff34A853),
            ),
          ),
        assignedEmployeeSection(),
      ],
    );
  }

  Widget absentEmployeeSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListOfEmployeeDetails(
        dataPekerja: widget.passData['absentStaff']!,
        assignedEmployee: getAssignedEmployeeDetails,
      ),
    );
  }

  Widget assignedEmployeeSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      // height: (dataEmployee2 == null) ? 200 : null,
      color: (dataEmployee2 != null || noReassignTextVisibility)
          ? const Color(0x4DEBFFF0)
          : Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: (dataEmployee2 == null) ? 100 : null,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              color: const Color(0xff34A853),
              strokeWidth: 0.8,
              dashPattern: const [3, 3],
              child: (noReassignTextVisibility)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 16,
                        ),
                        child: Text(
                          noReassignText,
                          style: TextStyle(
                            color: blackCustom,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    )
                  : (dataEmployee2 != null)
                      ? InkWell(
                          onTap: () {
                            if (noReassignLinkVisibility) {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: EmployeeList(
                                        scMainId: widget.passData['sMainId'],
                                        absentEmployee:
                                            widget.passData['absentStaff'],
                                        assignedEmployee:
                                            getAssignedEmployeeDetails,
                                      )));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            child: ListOfEmployeeDetails(
                              dataPekerja: dataEmployee2,
                            ),
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            width: 135,
                            height: 36,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(white),
                                overlayColor: MaterialStateProperty.all(white),
                                shadowColor: MaterialStateProperty.all(white),
                                elevation: MaterialStateProperty.all(5),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: EmployeeList(
                                          scMainId: widget.passData['sMainId'],
                                          absentEmployee:
                                              widget.passData['absentStaff'],
                                          assignedEmployee:
                                              getAssignedEmployeeDetails,
                                        )));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Ganti Pekerja",
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Center(
                                    child: Icon(
                                      CustomIcon.arrowRight,
                                      color: textColor,
                                      size: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
            ),
          ),
          if (noReassignLinkVisibility) noReassignLinkSection(),
        ],
      ),
    );
  }

  Widget noReassignLinkSection() {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        InkWell(
          onTap: () {
            if (noReassignLink != "Batal") {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return showAlertDialog(
                        context,
                        confirmation,
                        "Adakah anda pasti untuk teruskan tugas tanpa ganti pekerja ini sekarang?",
                        cancel,
                        yesConfirm);
                  }).then((actionText) async {
                if (actionText == yesConfirm) {
                  //update reassign list
                  if (widget.passData['updateReassign'] != null) {
                    Function(int, int, int?, int?) updateReassign =
                        widget.passData['updateReassign'];

                    WorkerSchedule absentStaff = widget.passData['absentStaff'];
                    updateReassign(absentStaff.id!, 0, null, null);
                  }

                  setState(() {
                    noReassignTextVisibility = true;
                    noReassignLink = "Batal";
                    dataEmployee2 = null;
                  });
                }
              });
            } else {
              setState(() {
                noReassignTextVisibility = false;
                noReassignLink = "Teruskan Tanpa Ganti";
              });
            }
          },
          child: Text(
            noReassignLink,
            style: TextStyle(
              color: blackCustom,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
