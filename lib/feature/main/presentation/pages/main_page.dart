import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/components/app_bouncing_animation_wrapper.dart';
import 'package:manas_suu_app/app/components/app_slide_animations_wirapper.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/extensions/datetime_extension.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';
import 'package:manas_suu_app/feature/main/presentation/bloc/main_cubit.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_button_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_header_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_info_contaiiner_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/payment_actions_widget.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final controller = TextEditingController();
  late Animation<double> header;
  late Animation<double> button;
  late Animation<double> info;

  @override
  void initState() {
    super.initState();
    _getMyAccounts();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(context.tr(LocaleKeys.mainPageTitle), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
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
                    return _NoAccountState(header: header, button: button, info: info);
                  }
                  if (state.status == MainStateStatus.LOADING && state.myAccounts.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height / 1.3,
                      width: MediaQuery.sizeOf(context).width,
                      child: Center(child: CircularProgressIndicator.adaptive()),
                    );
                  }

                  return _IsAddedAccountState(state);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoAccountState extends StatelessWidget {
  const _NoAccountState({required this.header, required this.button, required this.info});

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

class _IsAddedAccountState extends StatelessWidget {
  const _IsAddedAccountState(this.state);

  final MainState state;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black54;
    final dividerColor = isDark ? Colors.white12 : Colors.grey.shade200;
    final addCardBg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF0F0F0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        // Секция "Счета" с количеством
        Text(
          context.tr(LocaleKeys.accountsSection),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
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
                  isSelectedCard: state.myAccounts[index].id == state.selectedAccount?.id,
                ),
              ),
              const SizedBox(width: 12),
              _AddAccountCard(backgroundColor: addCardBg),
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
                color: isDark ? Colors.black38 : Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // К оплате
              Row(
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
                      color: (state.selectedAccount?.balance ?? 0) > 0 ? Colors.red : AppColors.mainColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    context.tr(LocaleKeys.toPay),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: textColor),
                  ),
                  const Spacer(),
                  Text(
                    '${state.selectedAccount?.balance.toString() ?? 0} сом',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: (state.selectedAccount?.balance ?? 0) > 0 ? Colors.red : AppColors.mainColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.chevron_right, color: subTextColor, size: 18),
                ],
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
                  Expanded(
                    child: _PillInfo(
                      icon: Icons.people_outline,
                      label: context.tr(LocaleKeys.registered),
                      value: (state.selectedAccount?.registeredCount ?? 0).toString(),
                      valueColor: AppColors.textPrimary,
                      isDark: isDark,
                    ),
                  ),
                  Container(width: 1, height: 30, color: dividerColor),
                  Expanded(
                    child: _PillInfo(
                      icon: Icons.people,
                      label: context.tr(LocaleKeys.residing),
                      value: (state.selectedAccount?.residingCount ?? 0).toString(),
                      valueColor: Colors.blue,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
              Divider(height: 20, color: dividerColor),
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: AppColors.textPrimary),
                  const SizedBox(width: 6),
                  Text(context.tr(LocaleKeys.updateDate), style: TextStyle(fontSize: 12, color: subTextColor)),
                  const Spacer(),
                  Text(
                    DateTime.now().formattedLastUpdate,
                    style: const TextStyle(fontSize: 12, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.check_circle, size: 14, color: AppColors.textPrimary),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        const SizedBox(height: 20),
        PaymentActionsWidget(
          isRedButton: (state.selectedAccount?.balance ?? 0) > 0,
          onPay: () {},
          onPrintInvoice: () {},
          onHistory: () {},
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _ActiveAccountCard extends StatelessWidget {
  const _ActiveAccountCard({required this.account, required this.isSelectedCard});

  final AccountItemModel account;
  final bool isSelectedCard;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isSelectedCard) {
          context.read<MainCubit>().selectAccount(account.personalAccount);
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: MediaQuery.sizeOf(context).width / 1.5,
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: isSelectedCard ? null : context.theme.cardBackgroundWhiteBlackColor,
          gradient: isSelectedCard
              ? const LinearGradient(
                  colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          border: Border.all(
            color: context.read<ThemeCubit>().state.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
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
            if (isSelectedCard)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  child: const Icon(Icons.check, size: 14, color: Colors.white),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  account.personalAccount,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: isSelectedCard ? Colors.white : context.theme.textWhiteBlackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  account.fullName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isSelectedCard ? Colors.white : context.theme.textWhiteBlackColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  account.address,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelectedCard ? Colors.white : context.theme.textWhiteBlackColor,
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
  const _AddAccountCard({required this.backgroundColor});

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(const MainAddUserAccountRoute()),
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.2), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 40, color: AppColors.textPrimary),
            const SizedBox(height: 8),
            Text(
              context.tr(LocaleKeys.addButton),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
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
        Text(label, style: TextStyle(color: subTextColor, fontSize: 13)),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w500),
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
              border: Border.all(color: AppColors.mainColor.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.home_outlined, size: 12, color: AppColors.textPrimary),
                const SizedBox(width: 3),
                Text(
                  accountType == AccountType.RESIDENTIAL ? 'Быт' : 'Ком',
                  style: const TextStyle(fontSize: 11, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
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
        Text.rich(
          TextSpan(
            text: '$label ',
            style: TextStyle(fontSize: 12, color: subColor),
            children: [
              TextSpan(
                text: value,
                style: TextStyle(fontSize: 12, color: valueColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
