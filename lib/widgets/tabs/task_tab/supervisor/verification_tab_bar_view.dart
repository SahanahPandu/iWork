/// Temporarily not using this file
import 'package:flutter/material.dart';

//import files
import '../../../../screens/schedule_verification/schedule_verification_main.dart';

class VerifyTabbarView extends StatefulWidget {
  const VerifyTabbarView({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyTabbarView> createState() => _VerifyTabbarViewState();
}

class _VerifyTabbarViewState extends State<VerifyTabbarView> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: ScheduleVerificationMain(),
    );
  }
}
