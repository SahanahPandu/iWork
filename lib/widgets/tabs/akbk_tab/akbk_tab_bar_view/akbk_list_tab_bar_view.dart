import 'package:flutter/material.dart';

import '../../../../screens/akbk/akbk_record/akbk_record_list.dart';

class AkbkListTabbarView extends StatefulWidget {
  const AkbkListTabbarView({Key? key}) : super(key: key);

  @override
  State<AkbkListTabbarView> createState() => _AkbkListTabbarViewState();
}

class _AkbkListTabbarViewState extends State<AkbkListTabbarView> {
  @override
  Widget build(BuildContext context) {
    return const AkbkRecordList();
  }
}
