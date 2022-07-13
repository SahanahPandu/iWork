// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ListCard extends StatefulWidget {
  double cardHeight;
  Widget pages;

  ListCard({Key? key, required this.cardHeight, required this.pages})
      : super(key: key);

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SizedBox(
        height: widget.cardHeight,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: Colors.white,
          elevation: 14,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: widget.pages,
          ),
        ),
      ),
    );
  }
}
