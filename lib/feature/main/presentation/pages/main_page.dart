import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/components/app_bouncing_animation_wrapper.dart';
import 'package:manas_suu_app/app/components/app_slide_animations_wirapper.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/extensions/datetime_extension.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';
import 'package:manas_suu_app/feature/finik/presentation/finik_sdk.dart';
import 'package:manas_suu_app/feature/history/presentation/bloc/history_bloc.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';
import 'package:manas_suu_app/feature/main/presentation/bloc/main_cubit.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/account_actions_bottom_sheet.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_button_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_chart_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_header_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_info_contaiiner_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/payment_actions_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/payment_dialogs.dart';
import 'package:manas_suu_app/feature/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final controller = TextEditingController();
  late Animation<double> header;
  late Animation<double> button;
  late Animation<double> info;
  bool _didRequestNotifications = false;

  @override
  void initState() {
    super.initState();
    _getMyAccounts();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    header = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    button = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    );

    info = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getMyAccounts() => context.read<MainCubit>().getMyAccounts();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        if (!_didRequestNotifications && state.selectedAccount != null) {
          _didRequestNotifications = true;
          context.read<NotificationsBloc>().add(LoadNotificationsEvent());
        }
        log('data-unique: state.status: ${state.status} ');
        if (state.status == MainStateStatus.ACCOUNTDETAILSUCCESS &&
            state.accountDetail != null) {
          context.router.push(AccountDetailRoute(detail: state.accountDetail!));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            context.tr(LocaleKeys.mainPageTitle),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () => context.router.push(const NotificationsRoute()),
            ),
          ],
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: () async => _getMyAccounts(),
          color: AppColors.mainColor,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                BlocBuilder<MainCubit, MainState>(
                  builder: (context, state) {
                    if (state.status == MainStateStatus.INITIAL) {
                      return _NoAccountState(
                        header: header,
                        button: button,
                        info: info,
                      );
                    }
                    if (state.status == MainStateStatus.LOADING &&
                        state.myAccounts.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height / 1.3,
                        width: MediaQuery.sizeOf(context).width,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }

                    return _EnsureChartLoaded(
                      state: state,
                      child: _IsAddedAccountState(state),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NoAccountState extends StatelessWidget {
  const _NoAccountState({
    required this.header,
    required this.button,
    required this.info,
  });

  final Animation<double> header;
  final Animation<double> button;
  final Animation<double> info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // MainAccountsSectionWidget(accountNumber: '222'),
        // SizedBox(height: 15),
        // MainChartWidget(),
        // SizedBox(height: 15),
        const SizedBox(height: 20),
        AppBouncingAnimationWrapper(MainHeaderWalletWidget()),
        AppSlideAnimationWrapper(header, MainHeaderWidget()),
        const SizedBox(height: 28),
        AppSlideAnimationWrapper(button, MainButtonWidget()),
        const SizedBox(height: 24),
        AppSlideAnimationWrapper(info, MainInfoContainerWidget()),
      ],
    );
  }
}

class _EnsureChartLoaded extends StatefulWidget {
  const _EnsureChartLoaded({required this.state, required this.child});

  final MainState state;
  final Widget child;

  @override
  State<_EnsureChartLoaded> createState() => _EnsureChartLoadedState();
}

class _EnsureChartLoadedState extends State<_EnsureChartLoaded> {
  int? _requestedAccountId;

  @override
  void didUpdateWidget(covariant _EnsureChartLoaded oldWidget) {
    super.didUpdateWidget(oldWidget);
    _maybeLoadChart();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _maybeLoadChart();
  }

  void _maybeLoadChart() {
    final state = widget.state;
    final id = state.selectedAccount?.id;
    if (id == null ||
        state.accountChartData != null ||
        _requestedAccountId == id) {
      return;
    }
    _requestedAccountId = id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<MainCubit>().getAccountChart(id, months: state.chartMonths);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _IsAddedAccountState extends StatelessWidget {
  const _IsAddedAccountState(this.state);

  final MainState state;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black54;
    final dividerColor = isDark ? Colors.white12 : Colors.grey.shade200;
    final addCardBg = isDark
        ? const Color(0xFF1C1C1E)
        : const Color(0xFFF0F0F0);

    return BlocListener<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is HistorySuccessState) {
          context.router.push(MainHistoryRoute(model: state.model));
        }
        if (state is HistoryCheckSuccessState && state.filePath.isNotEmpty) {
          context.router.push(AppPdfviewerRoute(filePath: state.filePath));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Секция "Счета" с количеством
          CustomText(
            context.tr(LocaleKeys.accountsSection),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),
          // Горизонтальный скролл карточек: активный счёт + добавить
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                  state.myAccounts.length,
                  (index) => _ActiveAccountCard(
                    account: state.myAccounts[index],
                    isSelectedCard:
                        state.myAccounts[index].id == state.selectedAccount?.id,
                  ),
                ),
                const SizedBox(width: 12),
                _AddAccountCard(
                  backgroundColor: addCardBg,
                  isAddedAccount: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Блок оплаты и деталей
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black38
                      : Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // К оплате
                InkWell(
                  onTap: () => context.read<MainCubit>().getAccountDetail(
                    state.selectedAccount?.id,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (state.selectedAccount?.balance ?? 0) > 0
                              ? Colors.red.withValues(alpha: 0.12)
                              : AppColors.mainColor.withValues(alpha: 0.12),
                        ),
                        child: Icon(
                          Icons.arrow_downward,
                          color: (state.selectedAccount?.balance ?? 0) > 0
                              ? Colors.red
                              : AppColors.mainColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),

                      CustomText(
                        context.tr(LocaleKeys.toPay),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                      const Spacer(),
                      CustomText(
                        '${(state.selectedAccount?.balance ?? 0)} сом',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: (state.selectedAccount?.balance ?? 0) > 0
                              ? Colors.red
                              : AppColors.mainColor,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.chevron_right, color: subTextColor, size: 18),
                    ],
                  ),
                ),
                Divider(height: 24, color: dividerColor),
                // ЛС
                _DetailRow(
                  icon: Icons.credit_card,
                  label: '${context.tr(LocaleKeys.accountLabel)}:',
                  value: state.selectedAccount?.personalAccount ?? '',

                  accountType: state.selectedAccount?.accountType,

                  textColor: textColor,
                  subTextColor: subTextColor,
                ),
                const SizedBox(height: 10),
                _DetailRow(
                  icon: Icons.person_outline,
                  label: '${context.tr(LocaleKeys.fullNameLabel)}:',
                  value: state.selectedAccount?.fullName ?? '',
                  textColor: textColor,
                  subTextColor: subTextColor,
                ),
                const SizedBox(height: 10),
                _DetailRow(
                  icon: Icons.location_on_outlined,
                  label: '${context.tr(LocaleKeys.addressLabel)}:',
                  value: state.selectedAccount?.address ?? '',
                  textColor: textColor,
                  subTextColor: subTextColor,
                ),
                Divider(height: 20, color: dividerColor),

                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.textPrimary,
                    ),
                    const SizedBox(width: 6),
                    CustomText(
                      context.tr(LocaleKeys.updateDate),
                      style: TextStyle(fontSize: 12, color: subTextColor),
                    ),
                    const Spacer(),
                    CustomText(
                      DateTime.now().formattedLastUpdate,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.check_circle,
                      size: 14,
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: state.accountChartData != null
                ? MainChartWidget(
                    accountChartData: state.accountChartData!,
                    initialMonths: state.chartMonths,
                    onPeriodChanged: (months) {
                      final id = context
                          .read<MainCubit>()
                          .state
                          .selectedAccount
                          ?.id;
                      if (id != null) {
                        context.read<MainCubit>().getAccountChart(
                          id,
                          months: months,
                        );
                      }
                    },
                  )
                : const SizedBox.shrink(),
          ),

          const SizedBox(height: 20),
          PaymentActionsWidget(
            onPay: ((state.selectedAccount?.balance ?? 0) > 0)
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinikScreen(
                          extra: FinikExtra(
                            amount: state.selectedAccount?.balance ?? 0,
                            personalAccount:
                                state.selectedAccount?.personalAccount ?? '',
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
                  }
                : null,
            onPrintInvoice: () {
              final accountId = context
                  .read<MainCubit>()
                  .state
                  .selectedAccount
                  ?.id;
              if (accountId == null) return;
              context.read<HistoryBloc>().add(
                GetHistoryCheckEvent(
                  accountId: accountId,
                  year: DateTime.now().year,
                  month: DateTime.now().month,
                ),
              );
            },
            onHistory: () {
              context.read<HistoryBloc>().add(
                LoadHistoryEvent(
                  personalAccount: state.selectedAccount?.id ?? 0,
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ActiveAccountCard extends StatelessWidget {
  const _ActiveAccountCard({
    required this.account,
    required this.isSelectedCard,
  });

  final AccountItemModel account;
  final bool isSelectedCard;

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeCubit>().state.isDarkMode;
    return InkWell(
      onTap: () {
        if (!isSelectedCard) {
          context.read<MainCubit>().selectAccount(
            account.personalAccount ?? '',
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: MediaQuery.sizeOf(context).width / 1.5,
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: isSelectedCard
              ? null
              : context.theme.cardBackgroundWhiteBlackColor,
          gradient: isSelectedCard
              ? const LinearGradient(
                  colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          border: Border.all(
            color: isDark ? Colors.grey.shade900 : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelectedCard
              ? [
                  BoxShadow(
                    color: AppColors.mainColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            Positioned(
              top: -2,
              right: -2,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => showAccountActionsBottomSheet(
                    context,
                    account: account,
                    onDetails: () {
                      context.read<MainCubit>().getAccountDetail(
                        context.read<MainCubit>().state.selectedAccount?.id,
                      );
                    },
                    onHistory: () {
                      final id =
                          context.read<MainCubit>().state.selectedAccount?.id ??
                          0;
                      context.read<HistoryBloc>().add(
                        LoadHistoryEvent(personalAccount: id),
                      );
                    },
                    onDelete: () {
                      final id = account.id;
                      if (id != null)
                        context.read<MainCubit>().deleteAccount(id);
                    },
                  ),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color:
                          (isSelectedCard
                                  ? Colors.white
                                  : (isDark ? Colors.white : Colors.black))
                              .withValues(alpha: isSelectedCard ? 0.2 : 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.more_horiz,
                      size: 16,
                      color: isSelectedCard
                          ? Colors.white
                          : (isDark ? Colors.white70 : Colors.black54),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  account.personalAccount ?? '—',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: isSelectedCard
                        ? Colors.white
                        : context.theme.textWhiteBlackColor,
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  account.fullName ?? '—',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isSelectedCard
                        ? Colors.white
                        : context.theme.textWhiteBlackColor,
                  ),
                ),
                const SizedBox(height: 6),
                CustomText(
                  account.address ?? '—',
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelectedCard
                        ? Colors.white
                        : context.theme.textWhiteBlackColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddAccountCard extends StatelessWidget {
  const _AddAccountCard({
    required this.backgroundColor,
    required this.isAddedAccount,
  });

  final Color backgroundColor;
  final bool isAddedAccount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.push(
        MainAddUserAccountRoute(isAddedAccount: isAddedAccount),
      ),
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.textPrimary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 40, color: AppColors.textPrimary),
            const SizedBox(height: 8),
            CustomText(
              context.tr(LocaleKeys.addButton),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.textColor,
    required this.subTextColor,
    this.accountType,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color textColor;
  final Color subTextColor;
  final AccountType? accountType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: subTextColor),
        const SizedBox(width: 8),
        CustomText(label, style: TextStyle(color: subTextColor, fontSize: 13)),
        const SizedBox(width: 4),
        Expanded(
          child: CustomText(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (accountType != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.mainColor.withValues(alpha: 0.1),
              border: Border.all(
                color: AppColors.mainColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.home_outlined,
                  size: 12,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(width: 3),
                CustomText(
                  accountType == AccountType.RESIDENTIAL ? 'Быт' : 'Ком',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _PillInfo extends StatelessWidget {
  const _PillInfo({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.isDark,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color valueColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final subColor = isDark ? Colors.white70 : Colors.black54;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 14, color: valueColor),
        const SizedBox(width: 4),
        CustomText.rich(
          TextSpan(
            text: '$label ',
            style: TextStyle(fontSize: 12, color: subColor),
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: 12,
                  color: valueColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
