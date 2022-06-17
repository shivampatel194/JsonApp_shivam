import 'package:flutter/material.dart';

class ContentText extends StatelessWidget {
  const ContentText({
    Key? key,
    required this.textSize,
    required this.color,
    required this.text,
    this.maxLine,
    this.alignment,
    this.fontWeight,
  }) : super(key: key);

  final double textSize;
  final Color color;
  final String text;
  final int? maxLine;
  final TextAlign? alignment;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    if(maxLine!=null) {
      return Text(this.text,
          maxLines: maxLine,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: this.color,
            fontSize: this.textSize,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
          textAlign: alignment ?? TextAlign.start);
    }else {
      return Text(this.text,
          style: TextStyle(
            color: this.color,
            fontSize: this.textSize,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
          textAlign: alignment ?? TextAlign.start);
    }
  }
}
