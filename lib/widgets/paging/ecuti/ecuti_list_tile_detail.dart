import 'package:eswm/models/ecuti/ecuti_details.dart';
import 'package:flutter/material.dart';

import '../../cards/list_card.dart';

class ECutiListTileDetail extends StatelessWidget {
  const ECutiListTileDetail({Key? key, required this.ecuti, this.index})
      : super(key: key);
  final EcutiDetails ecuti;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return ListCard(
      data: ecuti,
      type: "Cuti",
      listIndex: index!,
    ); // Card
  }
}
