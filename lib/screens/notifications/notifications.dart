import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

//import files
import '../../config/palette.dart';
import '../../providers/notifikasi_api.dart';
import '../../screens/notifications/notifications_details.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/app_bar/app_bar_widget.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  // late List<dynamic> notificationDataList;

  getNotificationData() async {
    List<dynamic> notificationData =
        await NotifikasiApi.getNotifikasiData(context);

    return notificationData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        leadingIcon: CustomIcon.arrowBack,
        title: "Notifikasi",
      ),
      backgroundColor: const Color(0xffF7FBFF),
      body: FutureBuilder<List<dynamic>>(
        future: NotifikasiApi.getNotifikasiData(context),
        builder: (context, snapshot) {
          var dataFuture = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Some error occured!"),
                );
              } else {
                return GroupedListView<dynamic, String>(
                  elements: dataFuture!,
                  groupBy: (element) => DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(element.dateReceived)),
                  order: GroupedListOrder.DESC,
                  groupSeparatorBuilder: (theDate) {
                    // convert date time
                    String dateToday =
                        DateFormat('dd MMMM').format(DateTime.now());
                    String convertDate =
                        DateFormat('dd MMMM').format(DateTime.parse(theDate));
                    String getTheDate = "";

                    if (convertDate == dateToday) {
                      //check if the date is today
                      getTheDate = "Hari Ini";
                    } else {
                      getTheDate = convertDate;
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 26, vertical: 10),
                      child: Text(
                        getTheDate,
                        style: TextStyle(
                          fontSize: 15,
                          color: blackCustom,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  },
                  itemBuilder: (context, element) {
                    return Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          NotificationDetails(
                            data: element,
                          ),
                          Divider(
                            color: Colors.grey.shade200,
                            thickness: 0.5,
                            height: 0,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
