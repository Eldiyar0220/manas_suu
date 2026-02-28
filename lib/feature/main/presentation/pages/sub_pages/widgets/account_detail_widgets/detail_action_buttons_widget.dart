import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/history/presentation/bloc/history_bloc.dart';

class DetailActionButtonsWidget extends StatelessWidget {
  const DetailActionButtonsWidget(this.accountId, {super.key});

  final int accountId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.account_balance_wallet_outlined, size: 20),
            label: Text(context.tr(LocaleKeys.payButton)),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  context.read<HistoryBloc>().add(
                    GetHistoryCheckEvent(
                      accountId: accountId,
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
                label: Text(context.tr(LocaleKeys.printInvoice)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  context.read<HistoryBloc>().add(
                    LoadHistoryEvent(personalAccount: accountId),
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
                label: Text(context.tr(LocaleKeys.history)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
