// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import '../../config/config.dart';

class StatusContainer extends StatefulWidget {
  Color boxColor;
  String status;
  Color textColor;
  FontWeight fontWeight;

  StatusContainer(
      {Key? key,
      required this.boxColor,
      required this.status,
      required this.textColor,
      required this.fontWeight})
      : super(key: key);

  @override
  State<StatusContainer> createState() => _StatusContainerState();
}

class _StatusContainerState extends State<StatusContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: widget.boxColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        widget.status,
        style: TextStyle(
          fontSize: userRole == 200? null : 12,
          color: widget.textColor,
          fontWeight: widget.fontWeight,
        ),
      ),
    );
  }
}
