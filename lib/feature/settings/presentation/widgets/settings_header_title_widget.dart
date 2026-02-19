import 'package:flutter/material.dart';

class SettingsHeaderTitleWidget extends StatelessWidget {
  const SettingsHeaderTitleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.green,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
