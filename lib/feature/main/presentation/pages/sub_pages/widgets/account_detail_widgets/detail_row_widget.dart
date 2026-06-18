import 'package:flutter/widgets.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';

class DetailRowWidget extends StatelessWidget {
  const DetailRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.valueBold = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool valueBold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final textColor = valueColor ?? context.theme.textWhiteBlackColor!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          label,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
            fontWeight: valueBold ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
        CustomText(
          value,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
            fontWeight: valueBold ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
