part of 'news_bloc.dart';
sealed class NewsState extends Equatable {}

class NewsSuccessState extends NewsState {
  NewsSuccessState({required this.model});
  final NewsModel? model;

  @override
  List<Object?> get props => [model];
}

class NewsLoadingState extends NewsState {
  @override
  List<Object?> get props => [];  
}

class NewsErrorState extends NewsState {
  NewsErrorState({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
