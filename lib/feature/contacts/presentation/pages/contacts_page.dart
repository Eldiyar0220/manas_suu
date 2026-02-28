import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/contacts/presentation/widgets/contacts_item_widget.dart';

@RoutePage()
class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          context.tr(LocaleKeys.bottomNavText3),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: context.theme.textWhiteBlackColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ContactItemWidget(
            title: context.tr(LocaleKeys.contactAddress),
            subtitle: context.tr(LocaleKeys.contactManasAddress),
            color: Colors.red,
            launchUrl: Uri(scheme: 'geo', path: '0,0', queryParameters: {'q': context.tr(LocaleKeys.contactManasAddress)}).toString(),
          ),
          ContactItemWidget(
            title: context.tr(LocaleKeys.contactAbonent),
            subtitle: context.tr(LocaleKeys.contactManasAbonentSubtitle),
            color: AppColors.mainColor,
            launchUrl: 'tel:+996372251629',
          ),
          ContactItemWidget(
            title: context.tr(LocaleKeys.contactDispatchers),
            subtitle: context.tr(LocaleKeys.contactManasDispatchersSubtitle),
            color: AppColors.mainColor,
            launchUrl: 'tel:+996551616195',
          ),
          ContactItemWidget(
            title: context.tr(LocaleKeys.contactTechnical),
            subtitle: context.tr(LocaleKeys.contactManasTechnicalSubtitle),
            color: AppColors.mainColor,
            launchUrl: 'tel:+996372252172',
          ),
          ContactItemWidget(
            title: context.tr(LocaleKeys.contactEmail),
            subtitle: context.tr(LocaleKeys.contactManasEmailSubtitle),
            color: Colors.orange,
            launchUrl: 'mailto:abon.otdeltazalyk@mail.ru',
          ),
          ContactItemWidget(
            title: context.tr(LocaleKeys.contactInstagram),
            subtitle: context.tr(LocaleKeys.contactManasInstagramSubtitle),
            color: Colors.purple,
            launchUrl: 'https://instagram.com/tazalyk_manas',
          ),
        ],
      ),
    );
  }
}
