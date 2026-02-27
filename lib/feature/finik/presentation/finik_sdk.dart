import 'package:finik_sdk/finik_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final class FinikExtra {
  final double amount;

  FinikExtra({required this.amount});
}

class FinikScreen extends StatelessWidget {
  const FinikScreen({super.key, required this.extra});
  final FinikExtra extra;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: FinikProvider(
          apiKey: 'rOhkc0AoXC6zl03MxsKeqa5OP6PeIF2E4YWX1Ndq',
          isBeta: true,
          locale: FinikSdkLocale.RU,
          textScenario: TextScenario.REPLENISHMENT,
          paymentMethods: const [PaymentMethod.APP, PaymentMethod.QR, PaymentMethod.VISA],
          enableShimmer: true,
          enableShare: true,
          enableSupportButtons: true,
          tapableSupportButtons: true,
          onBackPressed: () {},
          onPayment: (data) {},
          widget: CreateItemHandlerWidget(
            accountId: 'a79d2a0a-3ce2-46dc-9332-8c4da9b8f209',
            nameEn: 'Манас Тазалык',
            requestId: '110ec58a-a0f6-4ac4-8353-c86cd813b8d1',
            callbackUrl: 'https://beta.api.paymentsgateway.averspay.kg/v1/graphql',
            amount: FixedAmount(extra.amount),
            maxAvailableQuantity: 100,
            maxAvailableAmount: 1000,
            startDate: DateTime(2025, 7, 1, 0, 0),
            endDate: DateTime(2025, 12, 31, 23, 59),
            visibilityType: VisibilityType.PRIVATE,
            requiredFields: const [
              RequiredField(
                fieldId: 'YOU_FIELD_ID',
                label: 'YOUR_FIELD_LABEL',
                value: 'YOUR_FIELD_VALUE',
                isHidden: true,
              ),
            ],
            onCreated: (data) {
              print('ExampleApp: Created item data: $data');

              // Example output (data is of type Map<String, dynamic>):
              // {id: 1743008977_49a59dc9-f8fa-403c-83dd-95eeb5b2526a, userId: test_user_id, account: {id: test_account_id, name: ИП "TEST", type: CORPORATE}, qrCode: ...}
            },
          ),
        ),
      ),
    );
  }
}
