import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/palette.dart';
import '../../utils/icon/custom_icon.dart';
import '../employee_list/employee_list.dart';
import '../list_of_employees/list_of_employee_details.dart';

class ReassignEmployeeDetails extends StatefulWidget {
  final dynamic dataEmployee1; //absence employee

  const ReassignEmployeeDetails({
    Key? key,
    required this.dataEmployee1,
  }) : super(key: key);

  @override
  State<ReassignEmployeeDetails> createState() =>
      _ReassignEmployeeDetailsState();
}

class _ReassignEmployeeDetailsState extends State<ReassignEmployeeDetails> {
  //assigned employee
  dynamic dataEmployee2;
  Color textColor = greenCustom;

  getAssignedEmployeeDetails(dynamic data) {
    //final buttonVisibility = StateInheritedWidget.of(context);
    if (data != null) {
      // widget.visibility!();
      if (mounted) {
        // showBottomButton();
        setState(() {
          dataEmployee2 = data;
        });
      }
    }
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
        dataPekerja: widget.dataEmployee1!,
        assignedEmployee: getAssignedEmployeeDetails,
      ),
    );
  }

  Widget assignedEmployeeSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      height: (dataEmployee2 == null) ? 100 : null,
      color: dataEmployee2 != null ? const Color(0x4DEBFFF0) : Colors.white,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        color: const Color(0xff34A853),
        strokeWidth: 0.8,
        dashPattern: const [3, 3],
        child: (dataEmployee2 != null)
            ? InkWell(
                onTap: () {
                  Timer(const Duration(milliseconds: 200), () {
                    setState(() {
                      textColor = greenCustom;
                    });
                  });
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: EmployeeList(
                            absentEmployee: widget.dataEmployee1,
                            assignedEmployee: getAssignedEmployeeDetails,
                          )));
                },
                onTapDown: (_) {
                  setState(() {
                    textColor = const Color(0xFF75BE72);
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    textColor = greenCustom;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    textColor = greenCustom;
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  child: ListOfEmployeeDetails(
                    dataPekerja: dataEmployee2,
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 135,
                      height: 36,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(white),
                          overlayColor: MaterialStateProperty.all(white),
                          elevation: MaterialStateProperty.all(5),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Timer(const Duration(milliseconds: 200), () {
                            setState(() {
                              textColor = greenCustom;
                            });
                          });
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: EmployeeList(
                                    absentEmployee: widget.dataEmployee1,
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
                    const SizedBox(
                      height: 24,
                    ),
                    Text("Teruskan Tanpa Ganti",
                        style: TextStyle(
                          color: blackCustom,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        )),
                  ],
                ),
              ),
        // Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         Text("Ganti Pekerja",
        //             style: TextStyle(
        //               color: textColor,
        //               fontSize: 13,
        //               fontWeight: FontWeight.w400,
        //               decoration: TextDecoration.underline,
        //             )),
        //       ],
        //     ),
        //   ),
      ),
    );
  }

// Widget? showBottomButton() {
//   showBottomSheet(
//     context: context,
//     builder: (builder) {
//       return SizedBox(
//         height: MediaQuery.of(context).size.height * 0.1,
//         width: MediaQuery.of(context).size.width,
//         child: const BottomAppBar(
//           elevation: 40,
//           color: Colors.white,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 26, vertical: 17),
//             child: SahkanGantiPekerjaButton(),
//           ),
//         ),
//       );
//     },
//   );
//   return null;
// }
}
