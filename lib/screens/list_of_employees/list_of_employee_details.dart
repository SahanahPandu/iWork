import "package:flutter/material.dart";

//import files
import '../../config/palette.dart';
import '../../models/pekerja.dart';

class ListOfEmployeeDetails extends StatefulWidget {
  final Pekerja? data;
  final Function(dynamic)? assignedEmployee;

  const ListOfEmployeeDetails({
    Key? key,
    this.data,
    this.assignedEmployee,
  }) : super(key: key);

  @override
  State<ListOfEmployeeDetails> createState() => _ListOfEmployeeDetailsState();
}

class _ListOfEmployeeDetailsState extends State<ListOfEmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Avatar, nama and status
        ClipRect(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 0,
                child: Material(
                  elevation: 3,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  child: SizedBox(
                    height: 45,
                    width: 45,
                    child: Icon(
                      Icons.account_box_rounded,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              //Nama
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data!.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.data!.designCat,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              //Status
              // StatusContainer(
              //   type: "Kehadiran",
              //   status: widget.data!.attStatus,
              //   statusId: widget.data!.idAttStatus,
              //   fontWeight: statusFontWeight,
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        //Kemahiran
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.psychology,
                  size: 18,
                  color: blue,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Kemahiran",
                  style: TextStyle(
                    fontSize: 14,
                    color: grey400,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              widget.data!.skills,
              style: TextStyle(
                fontSize: 14,
                color: black87,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        //Masuk Kerja / Keluar Kerja
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Row(
        //       children: [
        //         Icon(
        //           //Icons.timer_outlined,
        //           CustomIcon.timerOutline,
        //           size: 18,
        //           color: blue,
        //         ),
        //         const SizedBox(
        //           width: 15,
        //         ),
        //         Text(
        //           "Masuk/Keluar Kerja",
        //           style: TextStyle(
        //             fontSize: 15,
        //             // color: Colors.grey.shade800,
        //             // fontWeight: FontWeight.w700,
        //             color: grey400,
        //             fontWeight: FontWeight.w600,
        //           ),
        //         ),
        //       ],
        //     ),
        //     if (widget.data!.timeIn != "" && widget.data!.timeOut != "")
        //       const SizedBox(
        //         width: 25,
        //       ),
        //     (widget.data!.timeIn != "" && widget.data!.timeOut != "")
        //         ? Expanded(
        //             flex: 2,
        //             child: Text(
        //               "${widget.data!.timeIn} / ${widget.data!.timeOut}",
        //               style: TextStyle(
        //                 fontSize: 15,
        //                 // color: Colors.black45,
        //                 // fontWeight: FontWeight.w500,
        //                 color: black87,
        //                 fontWeight: FontWeight.w700,
        //                 overflow: (widget.data!.timeIn != "" &&
        //                         widget.data!.timeOut != "")
        //                     ? TextOverflow.visible
        //                     : null,
        //               ),
        //             ),
        //           )
        //         : Text(
        //             (widget.data!.timeIn == "" && widget.data!.timeOut == "")
        //                 ? "--:-- / --:/--"
        //                 : (widget.data!.timeIn == "")
        //                     ? "--:-- / ${widget.data!.timeOut}"
        //                     : (widget.data!.timeOut == "")
        //                         ? "${widget.data!.timeIn} / --:--"
        //                         : "${widget.data!.timeIn} / ${widget.data!.timeOut}",
        //             style: TextStyle(
        //               fontSize: 15,
        //               // color: Colors.black45,
        //               // fontWeight: FontWeight.w500,
        //               color: black87,
        //               fontWeight: FontWeight.w700,
        //               overflow: (widget.data!.timeIn != "" &&
        //                       widget.data!.timeOut != "")
        //                   ? TextOverflow.visible
        //                   : null,
        //             ),
        //           ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 15,
        // ),
      ],
    );
  }
}
