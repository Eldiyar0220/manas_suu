import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/contacts/presentation/widgets/contacts_item_widget.dart';

@RoutePage()
class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Контакты',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: context.theme.textWhiteBlackColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ContactItemWidget(title: 'СМП "ОШ-ТАЗАЛЫК"', subtitle: 'г. Ош, ул. Алиева, 153', color: Colors.red),
          ContactItemWidget(title: 'Абонентский отдел', subtitle: '03222 48223', color: AppColors.mainColor),
          ContactItemWidget(title: 'Диспетчерская', subtitle: '03222 53193', color: AppColors.mainColor),
          ContactItemWidget(
            title: 'Диспетчерская Whatsapp',
            subtitle: 'wa.me/996551111704',
            color: AppColors.mainColor,
          ),
          ContactItemWidget(title: 'Web-сайт', subtitle: 'oshtazalyk.kg', color: Colors.purple),
          ContactItemWidget(title: 'Электронный адрес', subtitle: 'info@oshtazalyk.kg', color: Colors.orange),
        ],
      ),
    );
  }
}
