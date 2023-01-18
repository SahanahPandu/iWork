import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/vc/detail/vc_main.dart';

class VehicleChecklistApprovalView extends StatefulWidget {
  final VehicleChecklistMain data;
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
                    child: _buildTextRow('Tarikh', "widget.data.tarikh"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow('No. Laluan', " widget.data.noLaluan"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'No. Kenderaan', "widget.data.noKenderaan"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: before
                        ? _buildTextRow('Masa Keluar', "widget.data.masaKeluar")
                        : _buildTextRow('Masa Masuk', "widget.data.masaBalik"),
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
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.odometer.bacaanOdo
                                .toString()
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.odometer.bacaanOdo
                                .toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'Odometer Berfungsi',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.odometer.odoFungsi
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.odometer.odoFungsi),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'Jumlah Pengunaan KM Harian',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.odometer.totalKm
                                .toString()
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.odometer.totalKm
                                .toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'No AKBK (Laporan Kerosakan)',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.odometer.noAkbk
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.odometer.noAkbk),
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
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.fuel.liter
                                .toString()
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.fuel.liter
                                .toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'Serah Resit Minyak Diesel',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.fuel.resit
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.fuel.resit),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'Guna Diesel Fleet Card',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.fuel.fleetCard
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.fuel.fleetCard),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        'No. Kad (5 digit terakhir)',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.fuel.noFleetCard
                                .toString()
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.fuel.noFleetCard
                                .toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        before
                            ? 'Paras Meter Minyak (Sebelum Keluar)'
                            : 'Paras Meter Minyak (Sebelum Masuk)',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.fuel.fuelLevel
                                .toString()
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.fuel.fuelLevel
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
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.document.puspakomDisc
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.document.puspakomDisc),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '1.2 Cukai Jalan',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.document.cukaiJalan
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.document.cukaiJalan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '1.3 Lesen Pembawa A/Permit',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.document.lesen
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.document.lesen),
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
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.tyre.bungaTayar
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.tyre.bungaTayar),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '2.2 Nut tayar',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.tyre.nutTayar
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.tyre.nutTayar),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '2.3 Tekanan angin',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.tyre.tekananTayar
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.tyre.tekananTayar),
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
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .mampatan
                                .sistemHidraulik
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .mampatan
                                .sistemHidraulik),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '3.2 PTO/PAM',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.mampatan.ptdPam
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.mampatan.ptdPam),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '3.3 Semua penutup diperiksa',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.mampatan.allPenutup
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.mampatan.allPenutup),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '3.4 Buang air dalam tabung angin',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.mampatan.buangAir
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.mampatan.buangAir),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '3.5 Sistem Leachate diperiksa',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.mampatan.leachate
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.mampatan.leachate),
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
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.light.lampuUtama
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.light.lampuUtama),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '4.2 Lampu berhenti',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.light.lampuHenti
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.light.lampuHenti),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '4.3 Lampu isyarat',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.light.lampuIsyarat
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.light.lampuIsyarat),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '4.4 Lampu kecemasan',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.light.lampuKecemasan
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.light.lampuKecemasan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '4.5 Lampu isyarat sedang befungsi',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.light.lampuBeacon
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.light.lampuBeacon),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '4.6 Lampu no. plat',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.light.lampuPlet
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.light.lampuPlet),
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
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .engine
                                .dipstikMinyakEnjin
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .engine
                                .dipstikMinyakEnjin),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.2 Paras minyak enjin',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.engine.parasMinyak
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.engine.parasMinyak),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.3 Penutup minyak enjin',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.engine.penutupMinyak
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.engine.penutupMinyak),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.4 Paras air radiator',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.engine.parasAirRadiator
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .engine
                                .parasAirRadiator),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.5 Paras Expansion Tank',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.engine.parasExpansion
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.engine.parasExpansion),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.6 Dipstik minyak Auto Transmission',
                        before
                            ? widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .engine
                                .dipstikMintakTransmission
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .engine
                                .dipstikMintakTransmission),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.7 Paras minyak Auto Transmission',
                        before
                            ? widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .engine
                                .parasMinyakTransmission
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .engine
                                .parasMinyakTransmission),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.8 Paras minyak power steering',
                        before
                            ? widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .engine
                                .parasMinyakSteering
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .engine
                                .parasMinyakSteering),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.9 Paras minyak brek',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.engine.parasMinyakBrek
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.engine.parasMinyakBrek),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.10 Sistem cengkaman sistem brek',
                        before
                            ? widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .engine
                                .sistemCengkamanSistemBrek
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .engine
                                .sistemCengkamanSistemBrek),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.11 Paras minyak sistem clutch',
                        before
                            ? widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .engine
                                .parasMinyakClutch
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .engine
                                .parasMinyakClutch),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.12 Sistem clutch berfungsi baik',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.engine.sistemClutch
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.engine.sistemClutch),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.13 Paras air wiper tank',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.engine.parasAirWiper
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.engine.parasAirWiper),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.14 Keadaan wiper (kiri & kanan)',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.engine.keadaanWiper
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.engine.keadaanWiper),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.15 Paras air bateri No. 1 & No. 2',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.engine.parasAirBateri
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.engine.parasAirBateri),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '5.16 Keadaan asap ekzos',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.engine.asapEkzos
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.engine.asapEkzos),
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
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.outside.cermin
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.outside.cermin),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '6.2 Hon',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.outside.hon
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.outside.hon),
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
                            ? widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .safetyThings
                                .penandaKecemasan
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .safetyThings
                                .penandaKecemasan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '7.2 Alat pemadam api',
                        before
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.safetyThings.pemadamApi
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .safetyThings
                                .pemadamApi),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '7.3 Kotak kecemasan (First Aid Kit)',
                        before
                            ? widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .safetyThings
                                .kotakKecemasan
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .safetyThings
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
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.cleanliness.dalamKokpit
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .cleanliness
                                .dalamKokpit),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '8.2 Sekitar luaran badan trak',
                        before
                            ? widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .cleanliness
                                .luarBadanTrak
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .cleanliness
                                .luarBadanTrak),
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
                            ? widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .binLifterCleanliness
                                .binDicuci
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .binLifterCleanliness
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
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .accident
                                .terlibatKemalangan
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .accident
                                .terlibatKemalangan),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '10.2 No. kenderaan pihak ketiga',
                        before
                            ? widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .accident
                                .noKenderaanPartiKetiga
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .accident
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
                            ? widget.data.data!.vehicleChecklists!
                                .checklistBefore!.vcItem.vehiclePhysical.sampah
                            : widget.data.data!.vehicleChecklists!
                                .checklistAfter!.vcItem.vehiclePhysical.sampah),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildTextRow(
                        '11.2 Keadaan fizikal/kecacatan pada trak',
                        before
                            ? widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistBefore!
                                .vcItem
                                .vehiclePhysical
                                .kecacatan
                            : widget
                                .data
                                .data!
                                .vehicleChecklists!
                                .checklistAfter!
                                .vcItem
                                .vehiclePhysical
                                .kecacatan),
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
