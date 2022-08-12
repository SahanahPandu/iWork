import 'package:eswm/screens/akbk/akbk_list_record.dart';
import 'package:flutter/material.dart';

class AkbkListTabbarView extends StatefulWidget {
  const AkbkListTabbarView({Key? key}) : super(key: key);

  @override
  State<AkbkListTabbarView> createState() => _AkbkListTabbarViewState();
}

class _AkbkListTabbarViewState extends State<AkbkListTabbarView> {
  @override
  Widget build(BuildContext context) {
    return const AkbkListRecord();
  }
}
