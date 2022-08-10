// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";

//import files

import 'package:eswm/models/pekerja.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../widgets/buttons/ganti_pekerja_button.dart';
import '../../widgets/container/status_container.dart';

class ListOfEmployeeDetails extends StatefulWidget {
  Pekerja data;

  ListOfEmployeeDetails({Key? key, required this.data}) : super(key: key);

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //Avatar
                const Material(
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
                const SizedBox(
                  width: 15,
                ),
                //Nama
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      widget.data.designCat,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //Status
            StatusContainer(
              type: "Kehadiran",
              status: widget.data.attStatus,
              statusId: widget.data.idAttStatus,
              fontWeight: statusFontWeight,
            ),
          ],
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
                const Icon(
                  Icons.psychology,
                  size: 20,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Kemahiran",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              widget.data.skills,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        //Masuk Kerja / Keluar Kerja
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  size: 20,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Masuk Kerja / Keluar Kerja",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            if (widget.data.timeIn != "" && widget.data.timeOut != "")
              const SizedBox(
                width: 25,
              ),
            (widget.data.timeIn != "" && widget.data.timeOut != "")
                ? Expanded(
                    flex: 2,
                    child: Text(
                      "${widget.data.timeIn} / ${widget.data.timeOut}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                        overflow: (widget.data.timeIn != "" &&
                                widget.data.timeOut != "")
                            ? TextOverflow.visible
                            : null,
                      ),
                    ),
                  )
                : Text(
                    (widget.data.timeIn == "" && widget.data.timeOut == "")
                        ? "--:-- / --:/--"
                        : (widget.data.timeIn == "")
                            ? "--:-- / ${widget.data.timeOut}"
                            : (widget.data.timeOut == "")
                                ? "${widget.data.timeIn} / --:--"
                                : "${widget.data.timeIn} / ${widget.data.timeOut}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      overflow: (widget.data.timeIn != "" &&
                              widget.data.timeOut != "")
                          ? TextOverflow.visible
                          : null,
                    ),
                  ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        if (widget.data.idAttStatus == 2)
          //Button Ganti Pekerja
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const GantiPekerjaButton(),
          ),
      ],
    );
  }
}
