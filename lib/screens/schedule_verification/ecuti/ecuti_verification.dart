import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../providers/cuti_api.dart';
import '../../../widgets/cards/verification_task/ecuti/verify_ecuti_list_details.dart';
import 'ecuti_approval/ecuti_approval_main.dart';

class EcutiVerification extends StatefulWidget {
  const EcutiVerification({Key? key}) : super(key: key);

  @override
  State<EcutiVerification> createState() => _EcutiVerificationState();
}

class _EcutiVerificationState extends State<EcutiVerification> {
  late Future<List> _loadCutiData;

  @override
  void initState() {
    super.initState();
    _loadCutiData = CutiApi.getCutiData(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _loadCutiData,
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
                              child:
                                  EcutiApprovalMain(data: dataFuture![index])));
                    },
                    child: VerifyEcutiListDetails(
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
