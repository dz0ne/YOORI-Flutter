import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({Key? key, required this.details}) : super(key: key);
  final String details;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        HtmlWidget(widget.details),
      ],
    );
  }
}
