import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final String? attachment;
  final File? fileName;
  final BoxFit type;

  const ImageViewer(
      {Key? key, this.attachment, this.fileName, required this.type})
      : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12.withOpacity(0.5),
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: "imgTag",
            child: InteractiveViewer(
              panEnabled: false,
              alignPanAxis: true,
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: Center(
                child: widget.attachment != null
                    ? Container(
                        //   height: 500,
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: NetworkImage(widget.attachment!),
                          fit: widget.type,
                        )),
                      )
                    : widget.fileName != null
                        ? Image.file(
                            widget.fileName!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: widget.type,
                          )
                        : const Center(child: Text("Tiada Gambar!")),
              ),
            ),
          ),
        ));
  }
}
