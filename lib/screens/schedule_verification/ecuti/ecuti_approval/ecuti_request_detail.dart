import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/ecuti/ecuti_details.dart';
import '../../../../utils/icon/custom_icon.dart';
import 'ecuti_approval_detail.dart';

class ECutiRequestDetail extends StatefulWidget {
  final EcutiDetails data;

  const ECutiRequestDetail({Key? key, required this.data}) : super(key: key);

  @override
  State<ECutiRequestDetail> createState() => _ECutiRequestDetailState();
}

class _ECutiRequestDetailState extends State<ECutiRequestDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: barShadowColor,
                offset: const Offset(0, 3),
                blurRadius: 8,
              )
            ]),
            child: AppBar(
              backgroundColor: white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
              ),
              title: Center(
                child: Text(
                  "Maklumat E-Notis",
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              actions: const [SizedBox(width: 50)],
            ),
          ),
        ),
        body: ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Butiran maklumat E-Notis:",
                            style: TextStyle(
                                color: blackCustom,
                                fontSize: 15,
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                  EcutiApprovalDetail(
                    data: widget.data,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
