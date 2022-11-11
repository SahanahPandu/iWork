import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

//import files
import '../../config/palette.dart';
import '../../utils/icon/custom_icon.dart';

class PDFScreen extends StatefulWidget {
  final String? path;
  final String? getfile;

  const PDFScreen({Key? key, this.path, this.getfile}) : super(key: key);

  @override
  PDFScreenState createState() => PDFScreenState();
}

class PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 1;
  int? currentPage = 0;
  int? totalPage;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: grey200,
                offset: const Offset(0, 3),
                blurRadius: 10,
              )
            ]),
            child: AppBar(
              backgroundColor: white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
              ),
              title: Center(
                child: Text(
                  "Lampiran e-Cuti <${widget.getfile}>",
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              actions: const [SizedBox(width: 50)],
            ),
          ),
        ),
        body: Stack(
          children: [
            PDFView(
              filePath: widget.path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onRender: (pages) {
                setState(() {
                  pages = pages;
                  isReady = true;
                });
              },
              onError: (error) {
                //print(error.toString());
              },
              onPageError: (page, error) {
                //print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onPageChanged: (page, total) {
                setState(() {
                  totalPage = total;
                  currentPage = page! + 1;
                });
              },
            ),
            errorMessage.isEmpty
                ? !isReady
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container()
                : Center(
                    child: Text(errorMessage),
                  )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: greenCustom,
          highlightElevation: 0,
          splashColor: darkGreen,
          elevation: 0,
          label: Text("$currentPage/$totalPage"),
          onPressed: () async {
            // await snapshot.data!.setPage(pages! ~/ 2);
          },
        )

        /*FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          print(pages);
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("${pages!}/${totalPage}"),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }

          return Container();
        },
      ),*/
        );
  }
}
