// ignore_for_file: file_names
import 'package:flutter/material.dart';

class VerifyItemCard extends StatefulWidget {
  const VerifyItemCard({Key? key}) : super(key: key);

  @override
  State<VerifyItemCard> createState() => _VerifyItemCardState();
}

class _VerifyItemCardState extends State<VerifyItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SizedBox(
        height: 180,
        child: Card(
          //Tugasan Card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: Colors.white,
          elevation: 14,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(), //PraMyTaskListDetails(),
          ),
        ),
      ),
    );
  }
}
