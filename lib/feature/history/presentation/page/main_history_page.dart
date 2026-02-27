import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';
import 'package:manas_suu_app/feature/history/data/models/history_response.dart';
import 'package:manas_suu_app/feature/history/presentation/bloc/history_bloc.dart';
import 'package:manas_suu_app/feature/history/presentation/page/widgets/history_header_card_widget.dart';
import 'package:manas_suu_app/feature/history/presentation/page/widgets/history_periods_widget.dart';

@RoutePage()
class MainHistoryPage extends StatelessWidget {
  const MainHistoryPage({super.key, required this.model});
  final HistoryData model;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is HistoryCheckSuccessState && state.filePath.isNotEmpty) {
          context.router.push(AppPdfviewerRoute(filePath: state.filePath));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.router.maybePop(),
          ),
          centerTitle: true,
          title: Text(
            context.tr(LocaleKeys.history),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HistoryHeaderCardWidget(model: model),
                const SizedBox(height: 16),
                HistoryPeriodsWidget(model: model),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
