import 'package:flutter/material.dart';

//import files
import '../../providers/notifikasi_api.dart';
import '../../screens/notifications/notifications_details.dart';
import '../../widgets/app_bar/app_bar_widget.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Notifikasi",
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            FutureBuilder<List>(
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
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataFuture!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: dataFuture[index].readIdStatus == 2
                                ? Colors.white
                                : const Color(0xffEFF5FF),
                            child: Column(
                              children: [
                                NotificationDetails(
                                  data: dataFuture[index],
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
          ],
        ),
      ),
    );
  }
}
