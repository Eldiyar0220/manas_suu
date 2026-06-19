import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/finik/presentation/finik_sdk.dart';
import 'package:manas_suu_app/feature/history/presentation/bloc/history_bloc.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/payment_dialogs.dart';

class DetailActionButtonsWidget extends StatelessWidget {
  const DetailActionButtonsWidget({
    super.key,
    required this.accountId,
    required this.balance,
    required this.personalAccount,
  });

  final int? accountId;
  final double? balance;
  final String? personalAccount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ((balance ?? 0) > 0)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FinikScreen(
                      extra: FinikExtra(
                        amount: balance ?? 0,
                        personalAccount: personalAccount ?? '',
                      ),
                    ),
                  ),
                ).then((e) {
                  if (e != null && e is Map<String, dynamic>) {
                    if (e['status'] == 'SUCCEEDED') {
                      if (!context.mounted) return;
                      PaymentDialogs.showPaymentSuccess(context);
                    }
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.account_balance_wallet_outlined, size: 20),
              label: CustomText(context.tr(LocaleKeys.payButton)),
            ),
          ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: accountId == null
                    ? null
                    : () {
                        context.read<HistoryBloc>().add(
                          GetHistoryCheckEvent(
                            accountId: accountId!,
                            year: DateTime.now().year,
                            month: DateTime.now().month,
                          ),
                        );
                      },
                style: OutlinedButton.styleFrom(
                  foregroundColor: context.theme.textWhiteBlackColor,
                  side: BorderSide(color: AppColors.mainColor),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(
                  Icons.print_outlined,
                  size: 18,
                  color: context.theme.textWhiteBlackColor,
                ),
                label: CustomText(
                  context.tr(LocaleKeys.printInvoice),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: accountId == null
                    ? null
                    : () {
                        context.read<HistoryBloc>().add(
                          LoadHistoryEvent(personalAccount: accountId!),
                        );
                      },
                style: OutlinedButton.styleFrom(
                  foregroundColor: context.theme.textWhiteBlackColor,
                  side: BorderSide(color: AppColors.mainColor),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(
                  Icons.history,
                  size: 18,
                  color: context.theme.textWhiteBlackColor,
                ),
                label: CustomText(context.tr(LocaleKeys.history)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
