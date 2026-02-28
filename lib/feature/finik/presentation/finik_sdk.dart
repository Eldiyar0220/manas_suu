import 'package:finik_sdk/finik_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

final class FinikExtra {
  final double amount;

  FinikExtra({required this.amount});
}

final _apiKey = GetIt.I<String>(instanceName: 'APIKEY');
final _accountId = GetIt.I<String>(instanceName: 'ACCOUNTID');
final _callbackUrl = GetIt.I<String>(instanceName: 'CALLBACKURL');

class FinikScreen extends StatelessWidget {
  const FinikScreen({super.key, required this.extra});
  final FinikExtra extra;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: FinikProvider(
          apiKey: _apiKey,
          isBeta: true,
          locale: FinikSdkLocale.RU,
          textScenario: TextScenario.PAYMENT,
          paymentMethods: const [PaymentMethod.APP, PaymentMethod.QR, PaymentMethod.VISA],
          enableShimmer: true,
          enableShare: true,
          enableSupportButtons: true,
          tapableSupportButtons: true,
          onBackPressed: () => Navigator.of(context).pop(),
          onPayment: (data) => Navigator.of(context).pop(data),
          widget: CreateItemHandlerWidget(
            accountId: _accountId,

            callbackUrl: _callbackUrl,
            nameEn: 'Manas Tazalyk',
            amount: FixedAmount(extra.amount),
          ),
        ),
      ),
    );
  }
}
