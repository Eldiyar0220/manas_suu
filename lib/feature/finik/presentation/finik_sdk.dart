import 'dart:developer';

import 'package:finik_sdk/finik_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:manas_suu_app/core/injectable/injectable.dart';

final class FinikExtra {
  final double amount;
  final String personalAccount;

  FinikExtra({required this.amount, required this.personalAccount});
}

final _apiKey = GetIt.I<String>(instanceName: 'APIKEY');
final _accountId = GetIt.I<String>(instanceName: 'ACCOUNTID');
final _callbackUrl = GetIt.I<String>(instanceName: 'CALLBACKURL');

bool get _isBeta => GetIt.I<String>(instanceName: 'ENVIRONMENT') != AppEnv.prod;

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
          isBeta: _isBeta,
          locale: FinikSdkLocale.RU,
          textScenario: TextScenario.PAYMENT,
          paymentMethods: const [PaymentMethod.APP, PaymentMethod.QR, PaymentMethod.VISA],
          enableShimmer: true,
          enableShare: true,
          enableSupportButtons: true,
          tapableSupportButtons: true,
          onBackPressed: () => Navigator.of(context).pop(),
          onPayment: (data) {
            log('data-unique: data: $data ');
            Navigator.of(context).pop(data);
          },

          widget: CreateItemHandlerWidget(
            accountId: _accountId,

            callbackUrl: _callbackUrl,
            nameEn: 'Manas Tazalyk',
            amount: FixedAmount(extra.amount),

            requiredFields: [
              RequiredField(
                fieldId: 'personalAccount',
                label: 'personalAccount',
                value: extra.personalAccount,
                isHidden: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
