// ignore_for_file: use_build_context_synchronously

import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../models/task/compactor/compactor_task.dart';
import '../../models/task/compactor/data/schedule/schedule.dart';
import '../../providers/start_stop_work_time/start_stop_work_time_api.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
import '../alert/alert_dialog.dart';
import '../alert/lottie_alert_dialog.dart';
import '../alert/toast.dart';
import '../tabs/vehicle_checklist_tab/vehicle_checklist_form_tab/vehicle_checklist_form_tab.dart';

class StartEndWorkSlideBar extends StatefulWidget {
  final Schedule data;
  final CompactorTask? compactorData;
  final int? idx;

  const StartEndWorkSlideBar(
      {Key? key, required this.data, this.compactorData, this.idx})
      : super(key: key);

  @override
  State<StartEndWorkSlideBar> createState() => _StartEndWorkSlideBarState();
}

class _StartEndWorkSlideBarState extends State<StartEndWorkSlideBar> {
  final _controller = ActionSliderController();
  Color textColor = greenCustom;
  Color iconColor = greenCustom;
  Color borderColor = greenCustom;
  Color boxColor = white;
  String slideText = startWork;
  bool enableSlide = false;
  bool endTime = false;
  bool completed = false;
  int condition = -1;

  @override
  void initState() {
    //print(onGoingTask);
    if (otherDate && selectedNewDate != '') {
      textColor = grey500;
      iconColor = grey300;
      borderColor = transparent;
      boxColor = grey100;
      condition = -1;
    } else {
      /// NULL
      if ((cpSchedule[widget.idx! - 1] == 1) && vcStatus == 0) {
        textColor = grey500;
        iconColor = grey300;
        borderColor = transparent;
        boxColor = grey100;
        condition = 0;
      }

      /// VC before done, enable start time for all schedule cards
      else if ((cpSchedule[widget.idx! - 1] == 1) &&
          (vcStatus == 1 || vcStatus == 2)) {
        if (onGoingTask) {
          textColor = grey500;
          iconColor = grey300;
          borderColor = transparent;
          boxColor = grey100;
          slideText = startWork;

          condition = 6;
        } else {
          textColor = greenCustom;
          iconColor = greenCustom;
          borderColor = greenCustom;
          boxColor = white;
          slideText = startWork;
          condition = 1;
        }
      }

      /// VC before done, start time done, enable stop time
      else if ((cpSchedule[widget.idx! - 1] == 2) && vcStatus == 2) {
        textColor = red;
        iconColor = red;
        borderColor = red;
        boxColor = white;
        slideText = endWork;
        condition = 2;
      }

      /// VC before done, start/stop time done
      else if ((cpSchedule[widget.idx! - 1] == 3) && (vcStatus == 3)) {
        textColor = grey500;
        iconColor = grey300;
        borderColor = transparent;
        boxColor = grey100;
        slideText = startWork;
        condition = 3;
      }

      /// VC before/after done, start/stop time done
      else if ((cpSchedule[widget.idx! - 1] == 3) && vcStatus == 4) {
        textColor = grey500;
        iconColor = grey300;
        borderColor = transparent;
        boxColor = grey100;
        slideText = startWork;
        condition = 4;
      }

      /// VC before done, only first start time done
      else if ((cpSchedule[widget.idx! - 1] == 3) && vcStatus == 2) {
        textColor = grey500;
        iconColor = grey300;
        borderColor = transparent;
        boxColor = grey100;
        slideText = startWork;
        condition = 5;
      }

      /*  if (laluanDataFuture[j].statusCode!.code == "SBM") {
        cpSchedule[j] = 1;
      } else if (laluanDataFuture[j].statusCode!.code ==
          "SBT") {
        cpSchedule[j] = 2;
      } else if (laluanDataFuture[j].statusCode!.code ==
          "STG") {
        cpSchedule[j] = 3;
      }*/
      // }
      /* if (widget.data.vehicleChecklistId == null) {
      textColor = grey500;
      iconColor = grey300;
      borderColor = transparent;
      boxColor = grey100;
      //vcStatus = 0;
    } else if (widget.data.vehicleChecklistId!.statusCode!.code == "VC1" &&
        scheduleVcStatus.value == 1) {
      textColor = greenCustom;
      iconColor = greenCustom;
      borderColor = greenCustom;
      boxColor = white;
      slideText = startWork;
    } else if (widget.data.vehicleChecklistId!.statusCode!.code == "VC1" &&
        scheduleVcStatus.value == 2) {
      textColor = red;
      iconColor = red;
      borderColor = red;
      boxColor = white;
      slideText = endWork;
    } else if (widget.data.vehicleChecklistId!.statusCode!.code == "VC1" &&
        scheduleVcStatus.value == 3) {
      textColor = grey500;
      iconColor = grey300;
      borderColor = transparent;
      boxColor = grey100;
      slideText = startWork;
    } else if (widget.data.vehicleChecklistId!.statusCode!.code == "VC2" &&
        scheduleVcStatus.value == 4) {
      textColor = grey500;
      iconColor = grey300;
      borderColor = transparent;
      boxColor = grey100;
      slideText = startWork;
    }*/
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: condition == -1
          ? 0
          : ((cpSchedule[widget.idx! - 1] == 2) && vcStatus == 2)
              ? 2
              : 0,
      child: ActionSlider.custom(
        width: Orientations().isLandscape(context)
            ? 350
            : Sizes().screenWidth(context),
        controller: _controller,
        height: Orientations().isLandscape(context) ? 45 : 42,
        toggleWidth: Orientations().isLandscape(context) ? 35 : 30,
        toggleMargin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        sliderBehavior: SliderBehavior.stretch,
        foregroundChild: Container(
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Icon(Icons.double_arrow_rounded, color: white, size: 20)),
        foregroundBuilder: (context, state, child) => child!,
        backgroundChild: RotatedBox(
          quarterTurns: condition == -1
              ? 0
              : ((cpSchedule[widget.idx! - 1] == 2) && vcStatus == 2)
                  ? 2
                  : 0,
          child: Center(
            child: condition == -1 ||
                    onGoingTask ||
                    ((cpSchedule[widget.idx! - 1] == 1) && vcStatus == 0) ||
                    ((cpSchedule[widget.idx! - 1] == 3) && vcStatus == 3) ||
                    ((cpSchedule[widget.idx! - 1] == 3) && vcStatus == 4) ||
                    ((cpSchedule[widget.idx! - 1] == 3) && vcStatus == 2)
                ? Text(startWork,
                    style: TextStyle(
                        color: textColor,
                        fontSize: Orientations().isLandscape(context) ? 14 : 12,
                        fontWeight: FontWeight.w500))
                : Shimmer.fromColors(
                    baseColor: textColor,
                    highlightColor: white,
                    child: Text(slideText,
                        style: TextStyle(
                            fontSize:
                                Orientations().isLandscape(context) ? 14 : 12,
                            fontWeight: FontWeight.w500)),
                  ),
          ),
        ),
        outerBackgroundBuilder: (context, state, child) => Container(
          decoration: BoxDecoration(
            color: boxColor,
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
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
          condition == -1 ? null : _switchWorkTime(context);
          controller.reset(); //resets the slider
        },
        onTap: (d) {
          condition == -1
              ? null
              : (cpSchedule[widget.idx! - 1] == 1) && vcStatus == 0
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return showAlertDialog(
                            context, reminder, doVcFirst, cancel, vc);
                      }).then((actionText) {
                      if (actionText == vc) {
                        if (widget.data.vehicleChecklistId == null) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: VehicleChecklistFormTab(
                                      compactorData: widget.compactorData)));
                        }
                      }
                    })
                  : null;
        },
      ),
    );
  }

  void _switchWorkTime(BuildContext context) {
    /// Not started VC & start/stop work
    ((cpSchedule[widget.idx! - 1] == 1) && vcStatus == 0)
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return showAlertDialog(context, reminder, doVcFirst, cancel, vc);
            }).then((actionText) {
            if (actionText == vc) {
              if (widget.data.vehicleChecklistId == null) {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: VehicleChecklistFormTab(
                            compactorData: widget.compactorData)));
              }
            }
          })
        :

        /// Start/Stop work Completed
        ((cpSchedule[widget.idx! - 1] == 3) && vcStatus == 3) ||
                ((cpSchedule[widget.idx! - 1] == 3) && vcStatus == 4) ||
                ((onGoingTask && cpSchedule[widget.idx! - 1] == 1) &&
                    vcStatus == 2)
            ? null
            :

            /// 1 = Start work not yet /// 2 = Start work done, Stop work not yet
            (((cpSchedule[widget.idx! - 1] == 1) && vcStatus == 1) ||
                    ((cpSchedule[widget.idx! - 1] == 1) && vcStatus == 2) ||
                    ((cpSchedule[widget.idx! - 1] == 2) && vcStatus == 2)
                ? showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showAlertDialog(
                          context,
                          confirmation,
                          (((cpSchedule[widget.idx! - 1] == 1) &&
                                      vcStatus == 1) ||
                                  ((cpSchedule[widget.idx! - 1] == 1) &&
                                      vcStatus == 2))
                              ? "Adakah anda ingin memulakan tugasan untuk Laluan ${widget.data.mainRoute}?"
                              : ((cpSchedule[widget.idx! - 1] == 2) &&
                                      vcStatus == 2)
                                  ? "Adakah anda ingin menamatkan tugasan untuk Laluan ${widget.data.mainRoute}? Pastikan tugasan telah selesai."
                                  : "",
                          cancel,
                          (((cpSchedule[widget.idx! - 1] == 1) &&
                                      vcStatus == 1) ||
                                  ((cpSchedule[widget.idx! - 1] == 1) &&
                                      vcStatus == 2))
                              ? startWorkText
                              : ((cpSchedule[widget.idx! - 1] == 2) &&
                                      vcStatus == 2)
                                  ? endWorkText
                                  : "");
                    }).then((actionText) async {
                    if (actionText == startWorkText &&
                        (((cpSchedule[widget.idx! - 1] == 1) &&
                                vcStatus == 1) ||
                            ((cpSchedule[widget.idx! - 1] == 1) &&
                                vcStatus == 2))) {
                      var result = await StartStopWorkApi.uploadStartWorkTime(
                          widget.data.id);
                      switch (result) {
                        case 'ok':
                          _setTaskState(endWork, red, red, red, white, 2);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return showLottieAlertDialog(
                                  context,
                                  _textBuilder(),
                                  "",
                                  null,
                                  null,
                                );
                              });
                          setState(() {
                            if (listLength > 1) {
                              onGoingTask = true;
                            }
                            //condition = 2;
                            refresh.value = !refresh.value;
                          });
                          break;
                        case 'error':
                        case 'ng':
                          showErrorToast(context,
                              "Anda tidak berjaya untuk mulakan kerja. Sila cuba lagi!");
                      }
                    } else if (actionText == endWorkText &&
                        ((cpSchedule[widget.idx! - 1] == 2) && vcStatus == 2)) {
                      var resultS = await StartStopWorkApi.uploadStopWorkTime(
                          widget.data.id);
                      switch (resultS) {
                        case 'ok':
                          _setTaskState(startWork, grey500, grey300,
                              transparent, grey100, 3);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return showLottieAlertDialog(
                                  context,
                                  _textStopBuilder(),
                                  "",
                                  null,
                                  null,
                                );
                              });
                          setState(() {
                            //condition = 3;
                            onGoingTask = false;
                            refresh.value = !refresh.value;
                          });
                          break;
                        case 'error':
                        case 'ng':
                          showErrorToast(context,
                              "Anda tidak berjaya untuk tamatkan kerja. Sila cuba lagi!");
                      }
                    }
                  })
                //: showErrorToast(context, doVcFirst));
                : null);
  }

  Text _textBuilder() {
    return Text("Anda berjaya mulakan kerja pada hari ini. Selamat Bekerja!",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: greyCustom,
            height: 1.5));
  }

  Text _textStopBuilder() {
    return Text(
        "Anda berjaya tamatkan kerja bagi laluan ${widget.data.mainRoute}, untuk hari ini.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: greyCustom,
            height: 1.5));
  }

  void _setTaskState(String textP, Color textColorP, Color iconColorP,
      Color borderColorP, Color boxColorP, int stateP) {
    return setState(() {
      slideText = textP;
      textColor = textColorP;
      iconColor = iconColorP;
      borderColor = borderColorP;
      boxColor = boxColorP;
      condition = stateP;
    });
  }
}
