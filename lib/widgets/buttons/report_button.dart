// ignore_for_file: must_be_immutable

import 'package:eswm/models/laluan.dart';
import 'package:eswm/models/reports.dart';
import 'package:flutter/material.dart';

//import files
import '../../screens/reports/reports.dart';
import '../../models/reports.dart';

class ReportButton extends StatefulWidget {
  Laluan? dataLaluan;

  ReportButton({Key? key, required this.dataLaluan}) : super(key: key);

  @override
  State<ReportButton> createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.red,
            width: 1.4,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportsPage(
                screen: "3",
                data: const Reports(
                  id: 0,
                  idLaluan: 0,
                  namaLaluan: "",
                  idSubLaluan: 0,
                  namaSubLaluan: "",
                  idKenderaan: 0,
                  noKenderaan: "",
                  idTaman: 0,
                  namaTaman: "",
                  idJalan: 0,
                  namaJalan: "",
                  idJenisHalangan: 0,
                  jenisHalangan: "",
                  idStatus: 0,
                  status: "",
                  lampiran: "",
                  catatan: "",
                  idStatusPenyelia: 0,
                  statusPenyelia: "",
                  maklumbalasPenyelia: "",
                  idStatusBA: 0,
                  statusBA: "",
                  maklumbalasBA: "",
                ),
                dataLaluan: widget.dataLaluan!,
              ),
            ));
      },
      icon: const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 20,
      ),
      label: const Text(
        "Lapor Isu",
        style: TextStyle(
          fontSize: 17,
          color: Colors.red,
        ),
      ),
    );
  }
}
