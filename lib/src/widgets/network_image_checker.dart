import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NetworkImageCheckerWidget extends StatelessWidget {
  final String image;
  const NetworkImageCheckerWidget({Key? key, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageAccordingToExtension();
  }

  Widget imageAccordingToExtension() {
    if (image == "") return const SizedBox();
    ImageType imageType = checkImageExtension();
    switch (imageType) {
      case ImageType.svg:
        return SvgPicture.network(image);
      case ImageType.nonSvg:
        return Image.network(image);
      default:
        return SvgPicture.network(image);
    }
  }

  ImageType checkImageExtension() {
    var parts = image.split(".");
    String extension = parts.last;
    if (extension.toLowerCase().contains("svg")) {
      return ImageType.svg;
    } else {
      return ImageType.nonSvg;
    }
  }
}

enum ImageType { svg, nonSvg }
