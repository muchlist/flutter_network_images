import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_newtwork_image/decoder_loader.dart';
import 'package:flutter_newtwork_image/downloader.dart';
import 'package:flutter_newtwork_image/network_loader.dart';
import 'package:flutter_newtwork_image/error_widget.dart';
import 'package:flutter_svg/svg.dart';

class SvgFromWeb extends StatefulWidget {
  const SvgFromWeb();

  @override
  _SvgFromWebState createState() => _SvgFromWebState();
}

class _SvgFromWebState extends State<SvgFromWeb> {
  late final Downloader downloader;
  late final Future<List<int>> svgImage;

  @override
  void initState() {
    super.initState();
    downloader = const Downloader(url: "/demoimages/firefox.svg");
    svgImage = downloader.start();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: svgImage,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorxWidget();
        }

        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return SvgPicture.memory(
              Uint8List.fromList(snapshot.data!),
              placeholderBuilder: (_) => const DecoderLoader(),
            );
          } else {
            return const ErrorxWidget();
          }
        }

        return const NetworkLoader();
      },
    );
  }
}
