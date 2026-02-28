import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_detail_response_model.dart';
import 'package:manas_suu_app/feature/main/presentation/bloc/main_cubit.dart';
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/widgets/account_detail_widgets/detail_action_buttons_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/widgets/account_detail_widgets/detail_controller_card_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/widgets/account_detail_widgets/detail_dop_services.dart';
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/widgets/account_detail_widgets/detail_final_result_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/widgets/account_detail_widgets/detail_header_card_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/widgets/account_detail_widgets/detail_last_payment_card_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/widgets/account_detail_widgets/detail_over_pay_widget.dart';

@RoutePage()
class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key, required this.detail});
  final AccountDetailData detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.router.maybePop(),
        ),
        centerTitle: true,
        title: CustomText(
          context.tr(LocaleKeys.detailPageTitle),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              // TODO сам чекни если че убери
              context.read<MainCubit>().deleteAccount(detail.id);
              context.router.maybePop();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DetailHeaderCardWidget(detail),
              const SizedBox(height: 16),
              DetailActionButtonsWidget(detail.id,detail.balance),
              const SizedBox(height: 16),
              DetailOverPayWidget(
                detail.balance,
                detail.openingBalance,
                detail.currentPeriodAccrued,
                detail.currentPeriodTax,
                detail.currentPeriodPaid,
              ),
              const SizedBox(height: 12),
              DetailDopServicesWidget(detail.services),
              if (detail.lastPaymentDate != null ||
                  detail.lastPaymentAmount != null) ...[
                const SizedBox(height: 12),
                DetailLastPaymentCardWidget(
                  detail.lastPaymentDate,
                  detail.lastPaymentAmount,
                ),
              ],
              const SizedBox(height: 12),
              DetailControllerCardWidget(
                detail.controllerFullName,
                detail.controllerPhone,
              ),
              const SizedBox(height: 12),
              DetailFinalResultWidget(detail.services),
            ],
          ),
        ),
      ),
    );
  }
}
