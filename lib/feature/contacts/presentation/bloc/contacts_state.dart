part of 'contacts_bloc.dart';
sealed class ContactsState extends Equatable {}

class ContactsSuccessState extends ContactsState {
  ContactsSuccessState({required this.model});
  final ContactsModel? model;

  @override
  List<Object?> get props => [model];
}

class ContactsLoadingState extends ContactsState {
  @override
  List<Object?> get props => [];  
}

class ContactsErrorState extends ContactsState {
  ContactsErrorState({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
