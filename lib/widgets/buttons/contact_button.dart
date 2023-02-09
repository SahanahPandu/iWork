import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:url_launcher/url_launcher.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../models/task/supervisor/supervisor_task.dart';
import '../container/bubble_shape_container.dart';

class ContactButton extends StatefulWidget {
  final Isu? data;

  const ContactButton({Key? key, required this.data}) : super(key: key);

  @override
  State<ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<ContactButton>
    with TickerProviderStateMixin {
  ValueNotifier<bool> dismiss = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      dismiss.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ValueListenableBuilder(
          valueListenable: dismiss,
          builder: (BuildContext context, value, Widget? child) {
            if (value == true) {
              return Container();
            } else {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 200,
                      height: 40,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 25),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "Tekan untuk hubungi pemandu",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 50),
                      child: CustomPaint(
                          painter:
                              BubbleContainer(Colors.black.withOpacity(0.8))),
                    )
                  ]);
            }
          },
        ),
        const SizedBox(height: 15),
        ValueListenableBuilder(
            valueListenable: button,
            builder: (BuildContext context, bool value, Widget? child) {
              if (value == true) {
                return Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: RippleAnimation(
                    delay: const Duration(milliseconds: 100),
                    repeat: false,
                    color: greenCustom,
                    minRadius: 20,
                    ripplesCount: 6,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: callColor),
                      child: IconButton(
                        color: white,
                        iconSize: 18,
                        onPressed: () {
                          _callNumber("0142612967");
                        },
                        icon: const Icon(
                          Icons.wifi_calling_3_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            })
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
