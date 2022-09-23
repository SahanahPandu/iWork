import "package:flutter/material.dart";

//import files
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../models/pekerja.dart';
import '../../widgets/container/status_container.dart';

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
    return Row(
      children: [
        //avatar
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
          width: 16,
        ),
        Expanded(
          //expanded to fit the text for name
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
              Row(
                children: [
                  //kategori jawatan
                  Text(
                    widget.data!.designCat,
                    style: TextStyle(
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Icon(
                    Icons.fiber_manual_record,
                    size: 5,
                    color: greyCustom,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    widget.data!.skills,
                    style: TextStyle(
                      fontSize: 13,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              // Expanded(
              //   flex: 1,
              //   child: StatusContainer(
              //         type: "Kehadiran",
              //         status: widget.data!.attStatus,
              //         statusId: widget.data!.idAttStatus,
              //         fontWeight: statusFontWeight,
              //       ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
