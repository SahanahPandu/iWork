// ignore_for_file: use_build_context_synchronously

import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../utils/calendar/time.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
import '../alert/alert_dialog.dart';
import '../alert/toast.dart';
import '../cards/my_task/compactor_panel/compactor_panel_my_task_list_details.dart';

typedef StringCallback = void Function(String val);

class StartEndWorkSlideBar extends StatefulWidget {
  const StartEndWorkSlideBar({Key? key}) : super(key: key);

  @override
  State<StartEndWorkSlideBar> createState() => _StartEndWorkSlideBarState();
}

class _StartEndWorkSlideBarState extends State<StartEndWorkSlideBar> {
  final _controller = ActionSliderController();

  //  statusTask == 1
  Color textColor = greenCustom;
  Color iconColor = greenCustom;
  Color borderColor = greenCustom;
  Color boxColor = white;
  String slideText = startWork;

  bool enableSlide = false;
  bool endTime = false;
  bool completed = false;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: statusTask == 2 ? 2 : 0,
      child: ActionSlider.custom(
        width: Orientations().isLandscape(context)
            ? 350
            : Sizes().screenWidth(context),
        controller: _controller,
        height: Orientations().isLandscape(context) ? 45 : 40,
        toggleWidth: Orientations().isLandscape(context) ? 35.0 : 31,
        sliderBehavior: SliderBehavior.stretch,
        foregroundChild: Container(
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            child: Icon(Icons.double_arrow_rounded,
                color: statusTask == 3 ? transparent : white)),
        foregroundBuilder: (context, state, child) => child!,
        backgroundChild: RotatedBox(
          quarterTurns: statusTask == 2 ? 2 : 0,
          child: Center(
            child: statusTask == 3
                ? Text(startWork)
                : Shimmer.fromColors(
                    baseColor: textColor,
                    highlightColor: white,
                    child: Text(slideText,
                        style: TextStyle(
                            fontSize:
                                Orientations().isLandscape(context) ? 14 : 11.5,
                            fontWeight: FontWeight.w500)),
                  ),
          ),
        ),
        outerBackgroundBuilder: (context, state, child) => Container(
          decoration: BoxDecoration(
            color: boxColor,
            border: Border.all(
              color: borderColor,
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
          _switchWorkTime(context);
          controller.reset(); //resets the slider
        },
      ),
    );
  }

  void _switchWorkTime(BuildContext context) {
    statusTask == 3
        ? null
        : (completedFirstVc
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showAlertDialog(
                      context,
                      confirmation,
                      statusTask == 2 ? confirmEndWork : confirmStartWork,
                      statusTask == 2 ? endWorkText : startWorkText,
                      cancel);
                }).then((actionText) {
                if (actionText == startWorkText) {
                  _setTaskState(endWork, red, red, red, white, 2);
                  slidedStartTime = Time.getCurrentTime();
                  CompactorPanelMyTaskListDetails.of(context)
                      ?.setStartTime(slidedStartTime);
                } else if (actionText == endWorkText) {
                  _setTaskState(
                      startWork, grey, transparent, transparent, grey300, 3);
                  slidedEndTime = Time.getCurrentTime();
                }
              })
            : showErrorToast(context, doVcFirst));
  }

  void _setTaskState(String textP, Color textColorP, Color iconColorP,
      Color borderColorP, Color boxColorP, int stateP) {
    return setState(() {
      slideText = textP;
      textColor = textColorP;
      iconColor = iconColorP;
      borderColor = borderColorP;
      boxColor = boxColorP;
      statusTask = stateP;
    });
  }
}
