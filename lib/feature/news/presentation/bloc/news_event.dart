part of 'news_bloc.dart';
sealed class NewsEvent extends Equatable {}

class ToNewsEvent extends NewsEvent {
  ToNewsEvent({required this.model});
  final NewsModel model;

  @override
  List<Object?> get props => [model];
}
