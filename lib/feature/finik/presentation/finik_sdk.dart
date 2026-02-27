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
          locale: FinikSdkLocale.EN,
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
            nameEn: 'sss222',
            requiredFields: const [
              RequiredField(
                fieldId: 'YOU_FIELD_ID',
                label: 'YOUR_FIELD_LABEL',
                value: 'YOUR_FIELD_VALUE',
                isHidden: true,
              ),
            ],
            description: 'sdfsdf',
            requestId: '110ec58a-a0f6-4ac4-8353-c86cd813b8d1',
            callbackUrl: 'https://beta.api.paymentsgateway.averspay.kg/v1/graphql',
            amount: FixedAmount(extra.amount),
          ),
        ),
      ),
    );
  }
}
