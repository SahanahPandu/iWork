import 'package:flutter/material.dart';
import 'package:action_slider/action_slider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/palette.dart';
import '../../../../utils/device.dart';
import '../../../alert/alert_dialog.dart';

class CompactorPanelMyTaskListDetails extends StatefulWidget {
  const CompactorPanelMyTaskListDetails({Key? key}) : super(key: key);

  @override
  State<CompactorPanelMyTaskListDetails> createState() => _CompactorPanelMyTaskListDetailsState();
}

class _CompactorPanelMyTaskListDetailsState extends State<CompactorPanelMyTaskListDetails> {
  final _controller = ActionSliderController();
  final Devices _device = Devices();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            //Nama Laluan & Status
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "JHBP01-C02",
                style: TextStyle(
                    fontSize: 19,
                    color: grey800,
                    fontWeight: FontWeight.w900),
              ),
              Container(
                width: 130,
                decoration: BoxDecoration(
                  color: orange100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Center(
                    child: Text(
                      "Belum Dimulakan",
                      style: TextStyle(
                          color: orange700,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        //Sub Laluan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Sub Laluan",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Text(
                "JHBP01-C02-1",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        //No Kenderaan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.local_shipping,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "No. Kenderaan",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Text(
                "BLW7096",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        //Jumlah Taman/Jalan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.house,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Jumlah Taman/Jalan",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Text(
                "13/123",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        //Mula Kerja/ Tamat Kerja
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.timer,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Mula Kerja/Tamat Kerja",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Text(
                "7.30pagi/--:--",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Center(
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 15.0, bottom: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ActionSlider.custom(
                    width: 350.0,
                    controller: _controller,
                    height: 45.0,
                    toggleWidth: 35.0,
                    sliderBehavior: SliderBehavior.stretch,
                    foregroundChild: Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        child: const Icon(Icons.double_arrow_rounded,
                            color: Colors.white)),
                    foregroundBuilder: (context, state, child) => child!,
                    backgroundChild: Center(
                      child: Shimmer.fromColors(
                        baseColor: green,
                        highlightColor: Colors.white,
                        child: Text('Leretkan Ke Kanan Untuk Mula Tugas',
                            style: TextStyle(
                                fontSize:
                                    _device.isLandscape(context) ? 14.0 : 12.0,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    outerBackgroundBuilder: (context, state, child) =>
                        Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.green,
                          width: 1.0,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    backgroundBuilder: (context, state, child) => ClipRect(
                        child: OverflowBox(
                            maxWidth: state.standardSize.width,
                            maxHeight: state.toggleSize.height,
                            minWidth: state.standardSize.width,
                            minHeight: state.toggleSize.height,
                            child: child!)),
                    action: (controller) async {
                      controller.loading(); //starts loading animation
                      await Future.delayed(const Duration(milliseconds: 20));
                      controller.success(); //starts success animation
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return showAlertDialog(
                                context,
                                "Peringatan!",
                                "Pastikan anda mengisi borang semak kenderaan terlebih dahulu sebelum memulakan tugasan kerja.",
                                "Semak Kenderaan",
                                "Batal");
                          });
                      // await Future.delayed(const Duration(seconds: 1));
                      controller.reset(); //resets the slider
                    },
                  ),
                ],
              )),
        )
      ],
    );
  }
}
