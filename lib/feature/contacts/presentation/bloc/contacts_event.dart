part of 'contacts_bloc.dart';
sealed class ContactsEvent extends Equatable {}

class ToContactsEvent extends ContactsEvent {
  ToContactsEvent({required this.model});
  final ContactsModel model;

  @override
  List<Object?> get props => [model];
}
