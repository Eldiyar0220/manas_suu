import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
        title: const Text(
          'Контакты',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ContactItemWidget(
            title: 'СМП "ОШ-ТАЗАЛЫК"',
            subtitle: 'г. Ош, ул. Алиева, 153',
            color: Colors.red,
          ),
          ContactItemWidget(
            title: 'Абонентский отдел',
            subtitle: '03222 48223',
            color: Colors.green,
          ),
          ContactItemWidget(
            title: 'Диспетчерская',
            subtitle: '03222 53193',
            color: Colors.green,
          ),
          ContactItemWidget(
            title: 'Диспетчерская Whatsapp',
            subtitle: 'wa.me/996551111704',
            color: Colors.green,
          ),
          ContactItemWidget(
            title: 'Web-сайт',
            subtitle: 'oshtazalyk.kg',
            color: Colors.purple,
          ),
          ContactItemWidget(
            title: 'Электронный адрес',
            subtitle: 'info@oshtazalyk.kg',
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
