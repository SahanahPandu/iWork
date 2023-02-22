import 'package:flutter/material.dart';

import '../../../widgets/cards/verification_task/request_worker/verify_request_worker_list_details.dart';

class RequestWorkerVerification extends StatefulWidget {
  final List? requestData;

  const RequestWorkerVerification({Key? key, this.requestData})
      : super(key: key);

  @override
  State<RequestWorkerVerification> createState() =>
      _RequestWorkerVerificationState();
}

class _RequestWorkerVerificationState extends State<RequestWorkerVerification> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.requestData!.length,
      itemBuilder: (context, index) {
        var lastItem = widget.requestData!.length - 1;
        if (index < 3) {
          return InkWell(
            onTap: () {},
            child: VerifyRequestWorkerListDetails(
                data: widget.requestData![index],
                index: index,
                lastItem: lastItem),
          );
        }
        return Container();
      },
    );
  }
}
