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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Main details
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: _buildTextRow('Tarikh', widget.data.tarikh),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow('No. Laluan', widget.data.noLaluan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child:
                        _buildTextRow('No. Kenderaan', widget.data.noKenderaan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: before
                        ? _buildTextRow('Masa Keluar', widget.data.masaKeluar)
                        : _buildTextRow('Masa Masuk', widget.data.masaBalik),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow('Status', widget.data.status),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Perincian Card 1
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 12),
                    child: _buildTextRow(
                        before
                            ? 'Bacaan Odometer (Keluar)'
                            : 'Bacaan Odometer (Masuk)',
                        before
                            ? widget.data.sebelum.vcItem.odometer.bacaanOdo
                                .toString()
                            : widget.data.selepas.vcItem.odometer.bacaanOdo
                                .toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'Odometer Berfungsi',
                        before
                            ? widget.data.sebelum.vcItem.odometer.odoFungsi
                            : widget.data.selepas.vcItem.odometer.odoFungsi),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'Jumlah Pengunaan KM Harian',
                        before
                            ? widget.data.sebelum.vcItem.odometer.totalKm
                                .toString()
                            : widget.data.selepas.vcItem.odometer.totalKm
                                .toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'No AKBK (Laporan Kerosakan)',
                        before
                            ? widget.data.sebelum.vcItem.odometer.noAkbk
                            : widget.data.selepas.vcItem.odometer.noAkbk),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          //Card Perincian 1.5
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 12),
                    child: _buildTextRow(
                        'Diesel Diisi',
                        before
                            ? widget.data.sebelum.vcItem.fuel.liter.toString()
                            : widget.data.selepas.vcItem.fuel.liter.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'Serah Resit Minyak Diesel',
                        before
                            ? widget.data.sebelum.vcItem.fuel.resit
                            : widget.data.selepas.vcItem.fuel.resit),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'Guna Diesel Fleet Card',
                        before
                            ? widget.data.selepas.vcItem.fuel.fleetCard
                            : widget.data.sebelum.vcItem.fuel.fleetCard),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'No. Kad (5 digit terakhir)',
                        before
                            ? widget.data.sebelum.vcItem.fuel.noFleetCard
                                .toString()
                            : widget.data.selepas.vcItem.fuel.noFleetCard
                                .toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        before
                            ? 'Paras Meter Minyak (Sebelum Keluar)'
                            : 'Paras Meter Minyak (Sebelum Masuk)',
                        before
                            ? widget.data.sebelum.vcItem.fuel.fuelLevel
                                .toString()
                            : widget.data.selepas.vcItem.fuel.fuelLevel
                                .toString()),
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
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
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                              fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '1.1 Puspakom Disc',
                        before
                            ? widget.data.sebelum.vcItem.document.puspakomDisc
                            : widget.data.selepas.vcItem.document.puspakomDisc),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '1.2 Cukai Jalan',
                        before
                            ? widget.data.sebelum.vcItem.document.cukaiJalan
                            : widget.data.selepas.vcItem.document.cukaiJalan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '1.3 Lesen Pembawa A/Permit',
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
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
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                              fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '2.1 Bahagian bunga tayar',
                        before
                            ? widget.data.sebelum.vcItem.tyre.bungaTayar
                            : widget.data.selepas.vcItem.tyre.bungaTayar),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '2.2 Nut tayar',
                        before
                            ? widget.data.sebelum.vcItem.tyre.nutTayar
                            : widget.data.selepas.vcItem.tyre.nutTayar),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '2.3 Tekanan angin',
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
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
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                              fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '3.1 Sistem Hidraulik & Minyak',
                        before
                            ? widget
                                .data.sebelum.vcItem.mampatan.sistemHidraulik
                            : widget
                                .data.selepas.vcItem.mampatan.sistemHidraulik),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '3.2 PTO/PAM',
                        before
                            ? widget.data.sebelum.vcItem.mampatan.ptdPam
                            : widget.data.selepas.vcItem.mampatan.ptdPam),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '3.3 Semua penutup diperiksa',
                        before
                            ? widget.data.sebelum.vcItem.mampatan.allPenutup
                            : widget.data.selepas.vcItem.mampatan.allPenutup),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '3.4 Buang air dalam tabung angin',
                        before
                            ? widget.data.sebelum.vcItem.mampatan.buangAir
                            : widget.data.selepas.vcItem.mampatan.buangAir),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '3.5 Sistem Leachate diperiksa',
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
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
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                              fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '4.1 Lampu utama & belakang',
                        before
                            ? widget.data.sebelum.vcItem.light.lampuUtama
                            : widget.data.selepas.vcItem.light.lampuUtama),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '4.2 Lampu berhenti',
                        before
                            ? widget.data.sebelum.vcItem.light.lampuHenti
                            : widget.data.selepas.vcItem.light.lampuHenti),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '4.3 Lampu isyarat',
                        before
                            ? widget.data.sebelum.vcItem.light.lampuIsyarat
                            : widget.data.selepas.vcItem.light.lampuIsyarat),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '4.4 Lampu kecemasan',
                        before
                            ? widget.data.sebelum.vcItem.light.lampuKecemasan
                            : widget.data.selepas.vcItem.light.lampuKecemasan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '4.5 Lampu isyarat sedang befungsi',
                        before
                            ? widget.data.sebelum.vcItem.light.lampuBeacon
                            : widget.data.selepas.vcItem.light.lampuBeacon),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '4.6 Lampu no. plat',
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
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
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                              fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.1 Dipstik minyak enjin',
                        before
                            ? widget
                                .data.sebelum.vcItem.engine.dipstikMinyakEnjin
                            : widget
                                .data.selepas.vcItem.engine.dipstikMinyakEnjin),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.2 Paras minyak enjin',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasMinyak
                            : widget.data.selepas.vcItem.engine.parasMinyak),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.3 Penutup minyak enjin',
                        before
                            ? widget.data.sebelum.vcItem.engine.penutupMinyak
                            : widget.data.selepas.vcItem.engine.penutupMinyak),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.4 Paras air radiator',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasAirRadiator
                            : widget
                                .data.selepas.vcItem.engine.parasAirRadiator),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.5 Paras Expansion Tank',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasExpansion
                            : widget.data.selepas.vcItem.engine.parasExpansion),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.6 Dipstik minyak Auto Transmission',
                        before
                            ? widget.data.sebelum.vcItem.engine
                                .dipstikMintakTransmission
                            : widget.data.selepas.vcItem.engine
                                .dipstikMintakTransmission),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.7 Paras minyak Auto Transmission',
                        before
                            ? widget.data.sebelum.vcItem.engine
                                .parasMinyakTransmission
                            : widget.data.selepas.vcItem.engine
                                .parasMinyakTransmission),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.8 Paras minyak power steering',
                        before
                            ? widget
                                .data.sebelum.vcItem.engine.parasMinyakSteering
                            : widget.data.selepas.vcItem.engine
                                .parasMinyakSteering),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.9 Paras minyak brek',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasMinyakBrek
                            : widget
                                .data.selepas.vcItem.engine.parasMinyakBrek),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.10 Sistem cengkaman sistem brek',
                        before
                            ? widget.data.sebelum.vcItem.engine
                                .sistemCengkamanSistemBrek
                            : widget.data.selepas.vcItem.engine
                                .sistemCengkamanSistemBrek),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.11 Paras minyak sistem clutch',
                        before
                            ? widget
                                .data.sebelum.vcItem.engine.parasMinyakClutch
                            : widget
                                .data.selepas.vcItem.engine.parasMinyakClutch),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.12 Sistem clutch berfungsi baik',
                        before
                            ? widget.data.sebelum.vcItem.engine.sistemClutch
                            : widget.data.selepas.vcItem.engine.sistemClutch),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.13 Paras air wiper tank',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasAirWiper
                            : widget.data.selepas.vcItem.engine.parasAirWiper),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.14 Keadaan wiper (kiri & kanan)',
                        before
                            ? widget.data.sebelum.vcItem.engine.keadaanWiper
                            : widget.data.selepas.vcItem.engine.keadaanWiper),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.15 Paras air bateri No. 1 & No. 2',
                        before
                            ? widget.data.sebelum.vcItem.engine.parasAirBateri
                            : widget.data.selepas.vcItem.engine.parasAirBateri),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.16 Keadaan asap ekzos',
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
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
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                              fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '6.1 Cermin pandang belakang & sisi',
                        before
                            ? widget.data.sebelum.vcItem.outside.cermin
                            : widget.data.selepas.vcItem.outside.cermin),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '6.2 Hon',
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
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
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                              fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '7.1 Penanda amaran kecemasan',
                        before
                            ? widget.data.sebelum.vcItem.safetyThings
                                .penandaKecemasan
                            : widget.data.selepas.vcItem.safetyThings
                                .penandaKecemasan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '7.2 Alat pemadam api',
                        before
                            ? widget.data.sebelum.vcItem.safetyThings.pemadamApi
                            : widget
                                .data.selepas.vcItem.safetyThings.pemadamApi),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '7.3 Kotak kecemasan (First Aid Kit)',
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
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
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                              fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '8.1 Dalam kokpit (kabin) Pemandu',
                        before
                            ? widget.data.sebelum.vcItem.cleanliness.dalamKokpit
                            : widget
                                .data.selepas.vcItem.cleanliness.dalamKokpit),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '8.2 Sekitar luaran badan trak',
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
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
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                              fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '9.1 Bin lifter dicuci oleh pemandu',
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
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
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                              fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '10.1 Anda terlibat dengan kemalangan?',
                        before
                            ? widget
                                .data.sebelum.vcItem.accident.terlibatKemalangan
                            : widget.data.selepas.vcItem.accident
                                .terlibatKemalangan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '10.2 No. kenderaan pihak ketiga',
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: cardShadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5)
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
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                              fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '11.1 Sampah dalam kompaktor',
                        before
                            ? widget.data.sebelum.vcItem.vehiclePhysical.sampah
                            : widget
                                .data.selepas.vcItem.vehiclePhysical.sampah),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '11.2 Keadaan fizikal/kecacatan pada trak',
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
                fontWeight: FontWeight.w400, color: greyCustom, fontSize: 15)),
        Text(data,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: blackCustom, fontSize: 15)),
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
