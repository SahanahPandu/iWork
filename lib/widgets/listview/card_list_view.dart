// ignore_for_file: must_be_immutable

import 'package:eswm/widgets/cards/list_card.dart';
import 'package:flutter/material.dart';

class CardListView extends StatefulWidget {
  final List itemList;
  Widget pages;
  double cardHeight;

  CardListView(
      {Key? key,
      required this.itemList,
      required this.pages,
      required this.cardHeight})
      : super(key: key);

  @override
  State<CardListView> createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: ListView.builder(
          itemCount: widget.itemList.length,
          itemBuilder: (context, index) {
            return ListCard(cardHeight: widget.cardHeight, pages: widget.pages);
          },
        ),
      ),
    );
  }
}
