import 'package:flutter/material.dart';

//import files
import '../../../../config/font.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../container/status_container.dart';

class PraMyTaskListDetails extends StatefulWidget {
  final dynamic data;

  const PraMyTaskListDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<PraMyTaskListDetails> createState() => _PraMyTaskListDetailsState();
}

class _PraMyTaskListDetailsState extends State<PraMyTaskListDetails> {
  Color iconColor = const Color(0xff3269F8);
  Color labelColor = const Color(0xff969696);
  Color inputColor = const Color(0xff2B2B2B);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //Nama Laluan & Status
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.data.mainRoute,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff2B2B2B),
                      fontWeight: FontWeight.w500),
                ),
              ),
              StatusContainer(
                type: "Laluan",
                status: widget.data.statusCode.name,
                statusId: widget.data.statusCode,
                fontWeight: statusFontWeight,
              ),
            ],
          ),
          const SizedBox(
            height: 37,
          ),
          //No Kenderaan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CustomIcon.truckFill,
                      size: 16,
                      color: iconColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "No. Kenderaan",
                      style: TextStyle(
                        fontSize: 15,
                        color: labelColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.data.vehicleNo,
                  style: TextStyle(
                    fontSize: 15,
                    color: inputColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.end,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          //Sub Laluan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CustomIcon.roadFill,
                      size: 16,
                      color: iconColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Jumlah Sub Laluan",
                      style: TextStyle(
                        fontSize: 15,
                        color: labelColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.data.totalSubRoute}",
                  style: TextStyle(
                    fontSize: 15,
                    color: inputColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.end,
                )
              ],
            ),
          ),

          const SizedBox(
            height: 16,
          ),
          //Jumlah Taman/Jalan
          Padding(
            // padding: const EdgeInsets.fromLTRB(18, 6, 20, 20),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CustomIcon.tamanFill,
                      size: 16,
                      color: iconColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Jumlah Taman/Jalan",
                      style: TextStyle(
                        fontSize: 15,
                        color: labelColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.data.totalPark}/${widget.data.totalStreet}",
                  style: TextStyle(
                    fontSize: 15,
                    color: inputColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.end,
                )
              ],
            ),
          ),
          // const SizedBox(
          //   height: 16,
          // ),
        ],
      ),
    );
  }
}
