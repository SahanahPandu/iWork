import 'package:flutter/material.dart';

//import files
import '../../../../screens/akbk/akbk_form/akbk_form_main.dart';

class AkbkFormTabbarView extends StatefulWidget {
  const AkbkFormTabbarView({Key? key}) : super(key: key);

  @override
  State<AkbkFormTabbarView> createState() => _AkbkFormTabbarViewState();
}

class _AkbkFormTabbarViewState extends State<AkbkFormTabbarView> {
  @override
  Widget build(BuildContext context) {
    return const AkbkForm();
  }
}
