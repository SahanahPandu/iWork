import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/laluan.dart';
import '../../../config/font.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../utils/device/sizes.dart';
import '../../../widgets/container/status_container.dart';

class SupervisorScheduleDetails extends StatefulWidget {
  final Laluan data;
  final bool? button;

  const SupervisorScheduleDetails(
      {Key? key, required this.data, this.button = false})
      : super(key: key);

  @override
  State<SupervisorScheduleDetails> createState() =>
      _SupervisorScheduleDetailsState();
}

class _SupervisorScheduleDetailsState extends State<SupervisorScheduleDetails> {
  Color expandBgColor = const Color(0xea4a39be);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          //Nama Laluan & Status
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.data.namaLaluan,
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            StatusContainer(
              type: "Laluan",
              status: widget.data.status,
              statusId: widget.data.idStatus,
              fontWeight: statusFontWeight,
              roundedCorner: true,
            ),
          ],
        ),

        //No. Kenderaan
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.truckFill,
                    size: 16,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "No. Kenderaan",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.noKenderaan,
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Jumlah Sub Laluan
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.roadFill,
                    size: 16,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Jumlah Sub Laluan",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.jumSubLaluan}",
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Jumlah Taman dan Jalan
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.tamanFill,
                    size: 16,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Jumlah Taman/Jalan",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Jenis Kutipan
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.recycle,
                    size: 16,
                    color: white,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Jenis Kutipan",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.jenisKutipan,
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),

        //Masuk Kerja/Keluar Kerja
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(CustomIcon.scheduleFill, size: 16, color: white),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Masuk/Keluar Kerja",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.mulaKerja} / ${widget.data.tamatKerja}",
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Semakan Kenderaan
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.manualFill,
                    size: 16,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Semakan Kenderaan",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "Sebelum/Selepas",
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Senarai Staf
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            alignment: Alignment.centerLeft,
            width: 140,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.passthrough,
                children: [
                  Positioned(
                    left: 70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CircleAvatar(
                        backgroundColor: expandBgColor,
                        radius: 22,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.data.senaraiStaf.staf3Img),
                          radius: 20,
                        ), //CircleAvatar
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CircleAvatar(
                        backgroundColor: expandBgColor,
                        radius: 22,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.data.senaraiStaf.staf2Img),
                          radius: 20,
                        ), //CircleAvatar
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CircleAvatar(
                      backgroundColor: expandBgColor,
                      radius: 22,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.data.senaraiStaf.staf1Img),
                        radius: 20,
                      ), //CircleAvatar
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        widget.button == true
            ? Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  width: Sizes().screenWidth(context) * 0.75,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        overlayColor:
                            MaterialStateColor.resolveWith((states) => red),
                        foregroundColor:
                            MaterialStateColor.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return white;
                          }
                          return red;
                        }),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: red)),
                        ),
                        minimumSize: MaterialStateProperty.all(
                            Size(Sizes().screenWidth(context), 42)),
                        backgroundColor: MaterialStateProperty.all(white)),
                    child: const Text("Hubungi Pemandu",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                    onPressed: () {
                      _callNumber(widget.data.leaderContact);
                    },
                  ),
                ),
              )
            : const SizedBox(height: 4),
      ],
    );
  }

  _callNumber(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
