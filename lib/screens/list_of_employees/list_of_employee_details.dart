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
        Row(
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(widget.data!.displayPicture,
                            height: 56,
                            width: 56, loadingBuilder: (BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: green,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        }),
                      ))
                ]),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(
                  height: 4,
                ),
                /*  StatusContainer(
                  type: "Kehadiran",
                  status: widget.data!.attStatus,
                  statusId: widget.data!.idAttStatus,
                  fontWeight: statusFontWeight,
                  roundedCorner: true,
                )*/
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 12,
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
