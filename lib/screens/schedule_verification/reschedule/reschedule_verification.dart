import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../providers/pekerja_api.dart';
import '../../../widgets/cards/verification_task/reschedule/verify_reschedule_list_details.dart';

class RescheduleVerification extends StatefulWidget {
  const RescheduleVerification({Key? key}) : super(key: key);

  @override
  State<RescheduleVerification> createState() => _RescheduleVerificationState();
}

class _RescheduleVerificationState extends State<RescheduleVerification> {
  late Future<List> _loadPekerjaData;

  @override
  void initState() {
    super.initState();
    _loadPekerjaData = PekerjaApi.getPekerjaData(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _loadPekerjaData,
      builder: (context, snapshot) {
        final dataFuture = snapshot.data;

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );

          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text("Some errors occurred!"),
              );
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Container()));
                    },
                    child: VerifyRescheduleListDetails(
                      data: dataFuture![index],
                      index: index,
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }
}
