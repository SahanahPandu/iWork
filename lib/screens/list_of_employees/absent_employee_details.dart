import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";

//import files
import '../../config/palette.dart';
import '../../models/pekerja.dart';

class AbsentEmployeeDetails extends StatefulWidget {
  final Pekerja? data;

  const AbsentEmployeeDetails({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<AbsentEmployeeDetails> createState() => _AbsentEmployeeDetailsState();
}

class _AbsentEmployeeDetailsState extends State<AbsentEmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
                  color: Colors.white,
                  border: Border.all(color: grey200),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(4),
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
          width: 16,
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
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.data!.designCat,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.data!.skills,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
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
    );
  }

  final TextStyle textStyle = const TextStyle(
      color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600);

  Size _textSize() {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: widget.data!.name, style: textStyle),
        maxLines: 2,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: 220);
    return textPainter.size;
  }
}
