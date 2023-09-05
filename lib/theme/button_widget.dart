import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(0, 142, 150, 1),
            padding: const EdgeInsets.only(top: 15, bottom: 15)),
        onPressed: onClicked,
        child: buildContent(),
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null ? Icon(icon, size: 28) : Container(),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          )
        ],
      );
}
