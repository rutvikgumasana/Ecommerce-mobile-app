import 'package:flutter/material.dart';

class PrimaryTextButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final void Function() onTap;
  final bool isDisable;

  const PrimaryTextButton({
    super.key,
    required this.title,
    this.height,
    this.width,
    required this.onTap,
    this.isDisable = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisable ? null : onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 45,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.red.withOpacity(0.8),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}