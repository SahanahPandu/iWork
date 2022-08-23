import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//import files
import '../../../../config/palette.dart';
import '../../../config/font.dart';
import '../../../../models/laluan.dart';
import '../../../utils/custom_icon.dart';
import '../../../utils/device.dart';
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
  final Devices _device = Devices();

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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.data.namaLaluan,
                style: TextStyle(
                  fontSize: 16,
                  color: blackCustom,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            StatusContainer(
              type: "Laluan",
              status: widget.data.status,
              statusId: widget.data.idStatus,
              fontWeight: statusFontWeight,
            ),
          ],
        ),

        //No. Kenderaan
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.truckFill,
                    size: 16,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "No. Kenderaan",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.noKenderaan,
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Jumlah Sub Laluan
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.roadFill,
                    size: 16,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Jumlah Sub Laluan",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.jumSubLaluan}",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Jumlah Taman dan Jalan
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.tamanFill,
                    size: 16,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Jumlah Taman/Jalan",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Jenis Kutipan
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.grass,
                    size: 16,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Jenis Kutipan",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.jenisKutipan,
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),

        //Masuk Kerja/Keluar Kerja
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(CustomIcon.scheduleFill, size: 16, color: blue),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Masuk/Keluar Kerja",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.mulaKerja} / ${widget.data.tamatKerja}",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),

        //Senarai Staf
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.user,
                    size: 16,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Senarai Pekerja",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      widget.data.senaraiStaf.staf_1,
                      style: TextStyle(
                        fontSize: 15,
                        color: blackCustom,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      widget.data.senaraiStaf.staf_2,
                      style: TextStyle(
                        fontSize: 15,
                        color: blackCustom,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      widget.data.senaraiStaf.staf_3,
                      style: TextStyle(
                        fontSize: 15,
                        color: blackCustom,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        //Semakan Kenderaan
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.truckFill,
                    size: 16,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Semakan Kenderaan",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "Sebelum/Selepas",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        widget.button == true
            ? Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  width: _device.screenWidth(context) * 0.75,
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
                            Size(_device.screenWidth(context), 42)),
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
