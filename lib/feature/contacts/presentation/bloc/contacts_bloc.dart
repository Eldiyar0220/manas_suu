import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/feature/contacts/data/models/contacts_model.dart';
import 'package:manas_suu_app/feature/contacts/domain/interactor/contacts_interactor.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc(this._interactor) : super(ContactsLoadingState()) {
    on<ContactsEvent>((event, emit) async {
      switch (event) {
        case ToContactsEvent(:final model):
          {
            await onToContactsEvent(model: model, emit: emit);
            break;
          }
      }
    });
  }

  final ContactsInteractor _interactor;

  Future<void> onToContactsEvent({required ContactsModel model, required Emitter<ContactsState> emit}) async {
    emit(ContactsLoadingState());
    final result = await _interactor.exampleFunc();
  }
}
