import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionFont extends StatelessWidget {
  final double? size;
  final List<Shadow>? shadows;
  final FontWeight? fontWeight;
  final Color? color;
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? align;
  // final double height;

  const DescriptionFont({
    required this.text,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color,
    this.size,
    this.shadows,
    this.align,
    // this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.aBeeZee(
            fontSize: size, color: color, shadows: shadows));
  }
}

class TitleFont extends StatelessWidget {
  final double? size;
  final List<Shadow>? shadows;
  final FontWeight? fontWeight;
  final Color? color;
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? align;
  // final double height;

  const TitleFont({
    required this.text,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color,
    this.size,
    this.shadows,
    this.align,
    // this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.ubuntu(fontSize: size, color: color, shadows: shadows),
    );
  }
}
