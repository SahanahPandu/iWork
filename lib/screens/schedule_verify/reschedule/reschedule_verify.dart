import 'package:flutter/material.dart';

import '../../../providers/pekerja_api.dart';
import '../../../widgets/cards/verify_task/reschedule/verify_reschedule_list_details.dart';

class RescheduleVerify extends StatefulWidget {
  const RescheduleVerify({Key? key}) : super(key: key);

  @override
  State<RescheduleVerify> createState() => _RescheduleVerifyState();
}

class _RescheduleVerifyState extends State<RescheduleVerify> {
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
                itemCount: 2,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Container();
                        }),
                      );
                    },
                    child: VerifyRescheduleListDetails(
                      data: dataFuture![index],
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
