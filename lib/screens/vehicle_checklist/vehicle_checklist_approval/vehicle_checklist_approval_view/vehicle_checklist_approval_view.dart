import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/vc/vc.dart';

class VehicleChecklistApprovalView extends StatefulWidget {
  final VehicleChecklist data;
  final int section;

  const VehicleChecklistApprovalView(
      {Key? key, required this.data, required this.section})
      : super(key: key);

  @override
  State<VehicleChecklistApprovalView> createState() =>
      _VehicleChecklistApprovalViewState();
}

class _VehicleChecklistApprovalViewState
    extends State<VehicleChecklistApprovalView> {
  bool before = false;

  @override
  void initState() {
    _isBefore(widget.section);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Main details
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.data.noKenderaan,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: primaryTextColor,
                          fontSize: 16)),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 10),
                    child: _buildTextRow('Tarikh', widget.data.tarikh),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow('No. Laluan', widget.data.noLaluan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: before
                        ? _buildTextRow('Masa Keluar', widget.data.masaKeluar)
                        : _buildTextRow('Masa Masuk', widget.data.masaBalik),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
            child: Text('Perincian maklumat di bawah:',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: secondaryTextColor,
                    fontSize: 14)),
          ),
          //Perincian Card 1
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: _buildTextRow(
                        'Bacaan Odometer',
                        before
                            ? widget.data.sebelum.vcItem.odometer.bacaanOdo
                                .toString()
                            : widget.data.selepas.vcItem.odometer.bacaanOdo
                                .toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Jumlah Pengunaan KM Harian',
                        before
                            ? widget.data.sebelum.vcItem.odometer.totalKm
                                .toString()
                            : widget.data.selepas.vcItem.odometer.totalKm
                                .toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Odometer Berfungsi',
                        before
                            ? widget.data.sebelum.vcItem.odometer.odoFungsi
                            : widget.data.selepas.vcItem.odometer.odoFungsi),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'No AKBK',
                        before
                            ? widget.data.sebelum.vcItem.odometer.noAkbk
                            : widget.data.selepas.vcItem.odometer.noAkbk),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 2
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('1. Dokument Perjalanan',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: secondaryTextColor,
                              fontSize: 14))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Puspakom Disc',
                        before
                            ? widget.data.sebelum.vcItem.document.puspakomDisc
                            : widget.data.selepas.vcItem.document.puspakomDisc),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Cukai Jalan',
                        before
                            ? widget.data.sebelum.vcItem.document.cukaiJalan
                            : widget.data.selepas.vcItem.document.cukaiJalan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Lesen Pembawa A/Permit',
                        before
                            ? widget.data.sebelum.vcItem.document.lesen
                            : widget.data.selepas.vcItem.document.lesen),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 3
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('2. Pemeriksaan Tayar',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: secondaryTextColor,
                              fontSize: 14))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Bahagian bunga tayar diperiksa',
                        before
                            ? widget.data.sebelum.vcItem.tyre.bungaTayar
                            : widget.data.selepas.vcItem.tyre.bungaTayar),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Nut tayar diperiksa',
                        before
                            ? widget.data.sebelum.vcItem.tyre.nutTayar
                            : widget.data.selepas.vcItem.tyre.nutTayar),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Tekanan angin diperiksa',
                        before
                            ? widget.data.sebelum.vcItem.tyre.tekananTayar
                            : widget.data.selepas.vcItem.tyre.tekananTayar),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 4
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('3. Sistem Mampatan',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: secondaryTextColor,
                              fontSize: 14))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Sistem Hidraulik & Minyak',
                        before
                            ? widget
                                .data.sebelum.vcItem.mampatan.sistemHidraulik
                            : widget
                                .data.selepas.vcItem.mampatan.sistemHidraulik),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'PTD/PAM',
                        before
                            ? widget.data.sebelum.vcItem.mampatan.ptdPam
                            : widget.data.selepas.vcItem.mampatan.ptdPam),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Semua penutup diperiksa',
                        before
                            ? widget.data.sebelum.vcItem.mampatan.allPenutup
                            : widget.data.selepas.vcItem.mampatan.allPenutup),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Buang air dalam tabung angin',
                        before
                            ? widget.data.sebelum.vcItem.mampatan.buangAir
                            : widget.data.selepas.vcItem.mampatan.buangAir),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Sistem LEACHATE diperiksa',
                        before
                            ? widget.data.sebelum.vcItem.mampatan.leachate
                            : widget.data.sebelum.vcItem.mampatan.leachate),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 5
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('4. Sistem Lampu',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: secondaryTextColor,
                              fontSize: 14))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Lampu utama & belakang',
                        before
                            ? widget.data.sebelum.vcItem.light.lampuUtama
                            : widget.data.selepas.vcItem.light.lampuUtama),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Lampu berhenti',
                        before
                            ? widget.data.sebelum.vcItem.light.lampuHenti
                            : widget.data.selepas.vcItem.light.lampuHenti),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Lampu isyarat',
                        before
                            ? widget.data.sebelum.vcItem.light.lampuIsyarat
                            : widget.data.selepas.vcItem.light.lampuIsyarat),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Lampu kecemasan (Hazard Light)',
                        before
                            ? widget.data.sebelum.vcItem.light.lampuKecemasan
                            : widget.data.selepas.vcItem.light.lampuKecemasan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Lampu isyarat (Beacon Light)',
                        before
                            ? widget.data.sebelum.vcItem.light.lampuBeacon
                            : widget.data.selepas.vcItem.light.lampuBeacon),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Lampu nombor plet',
                        before
                            ? widget.data.sebelum.vcItem.light.lampuPlet
                            : widget.data.selepas.vcItem.light.lampuPlet),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 6
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('5. Sistem Enjin dan Driveline',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: secondaryTextColor,
                              fontSize: 14))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Dipstik minyak enjin',
                        before
                            ? widget
                                .data.sebelum.vcItem.engine.dipstikMinyakEnjin
                            : widget
                                .data.selepas.vcItem.engine.dipstikMinyakEnjin),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Paras minyak enjin',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasMinyak
                            : widget.data.selepas.vcItem.engine.parasMinyak),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Penutup minyak enjin',
                        before
                            ? widget.data.sebelum.vcItem.engine.penutupMinyak
                            : widget.data.selepas.vcItem.engine.penutupMinyak),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Paras Air radiator',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasAirRadiator
                            : widget
                                .data.selepas.vcItem.engine.parasAirRadiator),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Paras Expansion Tank',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasExpansion
                            : widget.data.selepas.vcItem.engine.parasExpansion),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Dipstik minyak Auto Transmission',
                        before
                            ? widget.data.sebelum.vcItem.engine
                                .dipstikMintakTransmission
                            : widget.data.selepas.vcItem.engine
                                .dipstikMintakTransmission),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Paras minyak Auto Transmission',
                        before
                            ? widget.data.sebelum.vcItem.engine
                                .parasMinyakTransmission
                            : widget.data.selepas.vcItem.engine
                                .parasMinyakTransmission),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Paras minyak Power Steering',
                        before
                            ? widget
                                .data.sebelum.vcItem.engine.parasMinyakSteering
                            : widget.data.selepas.vcItem.engine
                                .parasMinyakSteering),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Paras minyak brek',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasMinyakBrek
                            : widget
                                .data.selepas.vcItem.engine.parasMinyakBrek),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Sistem cengkaman sistem brek',
                        before
                            ? widget.data.sebelum.vcItem.engine
                                .sistemCengkamanSistemBrek
                            : widget.data.selepas.vcItem.engine
                                .sistemCengkamanSistemBrek),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Paras minyak sistem clutch',
                        before
                            ? widget
                                .data.sebelum.vcItem.engine.parasMinyakClutch
                            : widget
                                .data.selepas.vcItem.engine.parasMinyakClutch),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Sistem clutch',
                        before
                            ? widget.data.sebelum.vcItem.engine.sistemClutch
                            : widget.data.selepas.vcItem.engine.sistemClutch),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Paras air wiper tank',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasAirWiper
                            : widget.data.selepas.vcItem.engine.parasAirWiper),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Keadaan wiper (L & R)',
                        before
                            ? widget.data.sebelum.vcItem.engine.keadaanWiper
                            : widget.data.selepas.vcItem.engine.keadaanWiper),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Paras air bateri No. 1 & 2',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasAirBateri
                            : widget.data.selepas.vcItem.engine.parasAirBateri),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Keadaan asap ekzos',
                        before
                            ? widget.data.sebelum.vcItem.engine.asapEkzos
                            : widget.data.selepas.vcItem.engine.asapEkzos),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 7
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('6. Bahagian Luaran',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: secondaryTextColor,
                              fontSize: 14))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Cermin pandang belakang & sisi',
                        before
                            ? widget.data.sebelum.vcItem.outside.cermin
                            : widget.data.selepas.vcItem.outside.cermin),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Hon diperiksa',
                        before
                            ? widget.data.sebelum.vcItem.outside.hon
                            : widget.data.selepas.vcItem.outside.hon),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 8
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('7. Peralatan Keselamatan',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: secondaryTextColor,
                              fontSize: 14))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Penanda amaran kecemasan',
                        before
                            ? widget.data.sebelum.vcItem.safetyThings
                                .penandaKecemasan
                            : widget.data.selepas.vcItem.safetyThings
                                .penandaKecemasan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Alat pemadam api',
                        before
                            ? widget.data.sebelum.vcItem.safetyThings.pemadamApi
                            : widget
                                .data.selepas.vcItem.safetyThings.pemadamApi),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Kotak kecemasan (First Aid Box)',
                        before
                            ? widget
                                .data.sebelum.vcItem.safetyThings.kotakKecemasan
                            : widget.data.selepas.vcItem.safetyThings
                                .kotakKecemasan),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 9
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('8. Kebersihan Kenderaan',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: secondaryTextColor,
                              fontSize: 14))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Kebersihan dalam kokpit (kabin)',
                        before
                            ? widget.data.sebelum.vcItem.cleanliness.dalamKokpit
                            : widget
                                .data.selepas.vcItem.cleanliness.dalamKokpit),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Kebersihan sekitar luaran badan trak',
                        before
                            ? widget
                                .data.sebelum.vcItem.cleanliness.luarBadanTrak
                            : widget
                                .data.selepas.vcItem.cleanliness.luarBadanTrak),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 9
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('9. Kebersihan Bin Lifter',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: secondaryTextColor,
                              fontSize: 14))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Bin lifter dicuci oleh pemandu',
                        before
                            ? widget.data.sebelum.vcItem.binLifterCleanliness
                                .binDicuci
                            : widget.data.selepas.vcItem.binLifterCleanliness
                                .binDicuci),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 11
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('10. Kemalangan',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: secondaryTextColor,
                              fontSize: 14))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Terlibat dengan kemalangan',
                        before
                            ? widget
                                .data.sebelum.vcItem.accident.terlibatKemalangan
                            : widget.data.selepas.vcItem.accident
                                .terlibatKemalangan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Nombor kenderaan pihak ketiga',
                        before
                            ? widget.data.sebelum.vcItem.accident
                                .noKenderaanPartiKetiga
                            : widget.data.selepas.vcItem.accident
                                .noKenderaanPartiKetiga),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 12
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text('11. Fizikal Kenderaan',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: secondaryTextColor,
                              fontSize: 14))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Sampah dalam kompaktor',
                        before
                            ? widget.data.sebelum.vcItem.vehiclePhysical.sampah
                            : widget
                                .data.selepas.vcItem.vehiclePhysical.sampah),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTextRow(
                        'Keadaan fizikal/kecacatan pada trak',
                        before
                            ? widget
                                .data.sebelum.vcItem.vehiclePhysical.kecacatan
                            : widget
                                .data.selepas.vcItem.vehiclePhysical.kecacatan),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildTextRow(String object, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(object,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: primaryTextColor,
                fontSize: 14)),
        Text(data,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: secondaryTextColor,
                fontSize: 14)),
      ],
    );
  }

  bool _isBefore(int section) {
    if (section == 0) {
      return before = true;
    }
    return false;
  }
}
