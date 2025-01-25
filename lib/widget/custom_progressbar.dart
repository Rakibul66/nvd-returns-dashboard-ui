import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? backgroundColor;
  final Color? color;
  final Animation<Color?>? valueColor;
  final double strokeWidth;
  final String? semanticsLabel;
  final String? semanticsValue;
  final StrokeCap? strokeCap;

  const CustomProgressIndicator({
    super.key,
    this.value,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeCap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: value,
        backgroundColor: backgroundColor ?? Colors.grey.shade300,
        valueColor: valueColor ?? AlwaysStoppedAnimation(color ?? Colors.blue),
        strokeWidth: strokeWidth,
        semanticsLabel: semanticsLabel,
        semanticsValue: semanticsValue,
        strokeCap: strokeCap ?? StrokeCap.butt, // Use default if not provided
      ),
    );
  }
}
