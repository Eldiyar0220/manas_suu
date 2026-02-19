import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/feature/news/data/models/news_model.dart';
import 'package:manas_suu_app/feature/news/domain/interactor/news_interactor.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
NewsBloc(this._interactor) : super(NewsLoadingState()) {
  on<NewsEvent>((event, emit) async {
    switch (event) {
      case ToNewsEvent(:final model):
        {
          await onToNewsEvent(model: model, emit: emit);
          break;
        }
    }
  });
}

  final NewsInteractor _interactor;

  Future<void> onToNewsEvent({
    required NewsModel model,
    required Emitter<NewsState> emit,
  }) async {
    emit(NewsLoadingState());
    final result = await _interactor.exampleFunc();
  }
}
