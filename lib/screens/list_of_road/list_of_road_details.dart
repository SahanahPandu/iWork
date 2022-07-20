// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../models/jalan.dart';

class ListOfRoadDetails extends StatefulWidget {
  Jalan data;

  ListOfRoadDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<ListOfRoadDetails> createState() => _ListOfRoadDetailsState();
}

class _ListOfRoadDetailsState extends State<ListOfRoadDetails> {
  @override
  Widget build(BuildContext context) {
    return const Text("test");
  }
}
