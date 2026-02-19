import 'package:flutter/material.dart';

class SettingsSelectItemWidget extends StatelessWidget {
  final String value;
  final String groupValue;
  final String title;
  final VoidCallback onTap;

  const SettingsSelectItemWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? Colors.green : Colors.white24),
          color: isSelected
              ? Colors.green.withValues(alpha: 0.15)
              : const Color(0xFF1E1E1E),
        ),
        child: Row(
          children: [
            Expanded(child: Text(title)),
            if (isSelected) const Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
