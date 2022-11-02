import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";

//import files
import '../../config/dimen.dart';
import '../../config/palette.dart';
import '../../models/pekerja.dart';
import '../../widgets/buttons/select_employee_button.dart';

class ListOfEmployeeDetails extends StatefulWidget {
  final String? type;
  final Pekerja? data;
  final Function(dynamic)? assignedEmployee;

  const ListOfEmployeeDetails({
    Key? key,
    this.type,
    this.data,
    this.assignedEmployee,
  }) : super(key: key);

  @override
  State<ListOfEmployeeDetails> createState() => _ListOfEmployeeDetailsState();
}

class _ListOfEmployeeDetailsState extends State<ListOfEmployeeDetails> {
  selectEmployee() {
    widget.assignedEmployee!(widget.data);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.hardEdge,
              alignment: AlignmentDirectional.center,
              fit: StackFit.loose,
              children: <Widget>[
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                      color: transparent,
                      border: Border.all(color: grey200),
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadiusCircular),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.network(widget.data!.displayPicture,
                          height: 56,
                          width: 56, loadingBuilder: (BuildContext context,
                              Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: green,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      }),
                    ))
              ],
            ),
            //gap between avatar and text
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: _textSize().width,
                    height: _textSize().height,
                    child: Text(
                      widget.data!.name,
                      style: textStyle,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        widget.data!.designCat,
                        style: TextStyle(
                            color: greyCustom,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.fiber_manual_record,
                        size: 5,
                        color: greyCustom,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.data!.skills,
                        style: TextStyle(
                            color: greyCustom,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),

                  if (widget.data!.idAttStatus == 2)
                    const SizedBox(
                      height: 16,
                    ),
                  //Status kehadiran
                  // this status only show for employee that absent
                  if (widget.data!.idAttStatus == 2)
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: orangeStatusBox,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: AutoSizeText(
                          widget.data!.attStatus,
                          style: TextStyle(
                            fontSize: 11,
                            color: orangeStatusText,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        //button pilih pekerja
        if (widget.data!.idAttStatus == 1 && widget.type == "Senarai Hadir")
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 104,
              height: 36,
              child: SelectEmployeeButton(onClick: selectEmployee),
            ),
          ),
      ],
    );
  }

  final TextStyle textStyle =
      TextStyle(color: blackCustom, fontSize: 15, fontWeight: FontWeight.w600);

  Size _textSize() {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: widget.data!.name, style: textStyle),
        maxLines: 2,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: 220);
    return textPainter.size;
  }
}
