import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';
import 'package:manas_suu_app/feature/notifications/data/models/notifications_model.dart';
import 'package:manas_suu_app/feature/notifications/presentation/bloc/notifications_bloc.dart';

@RoutePage()
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = context.theme.textWhiteBlackColor!;
    final subTextColor = context.theme.textSecondaryWhiteBlackColor!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: textColor),
          onPressed: () => context.router.maybePop(),
        ),
        title: Text(
          context.tr(LocaleKeys.notifications),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is NotificationsErrorState) {
            return Center(
              child: Text(state.message, style: TextStyle(color: subTextColor)),
            );
          }

          if (state is NotificationsSuccessState && state.items.isEmpty) {
            final iconBgColor = Theme.of(context).brightness == Brightness.dark
                ? Colors.blue.shade900.withValues(alpha: 0.4)
                : Colors.blue.shade50;

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.notifications_none,
                        size: 48,
                        color: Colors.blue.shade400,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      context.tr(LocaleKeys.noNotifications),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      context.tr(LocaleKeys.noNotificationsDesc),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: subTextColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final items = (state is NotificationsSuccessState)
              ? state.items
              : <NotificationsModel>[];

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemBuilder: (context, index) {
              final item = items[index];
              return _NotificationCard(item: item);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: items.length,
          );
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final NotificationsModel item;

  @override
  Widget build(BuildContext context) {
    final textColor = context.theme.textWhiteBlackColor!;
    final subTextColor = context.theme.textSecondaryWhiteBlackColor!;

    final isUnread = !item.isRead;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        context.read<NotificationsBloc>().add(
          MarkNotificationReadEvent(id: item.id),
        );
        context.router.push(NotificationDetailRoute(item: item));
      },
      child: Container(
        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 5),
        decoration: BoxDecoration(
          color: isUnread
              ? AppColors.mainColor.withValues(alpha: 0.08)
              : context.theme.cardBackgroundWhiteBlackColor!,
          borderRadius: BorderRadius.circular(20),
          border: isUnread
              ? Border.all(
                  color: AppColors.mainColor.withValues(alpha: 0.35),
                  width: 1,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isUnread
                    ? AppColors.mainColor.withValues(alpha: 0.2)
                    : Colors.grey.shade800,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.notifications_none,
                color: isUnread ? AppColors.mainColor : Colors.white,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: subTextColor),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.textPrimary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.creationDate,
                        style: TextStyle(fontSize: 12, color: subTextColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
