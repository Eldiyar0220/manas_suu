import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/contacts/domain/repository/contacts_repository.dart';

@singleton
class ContactsInteractor {
  ContactsInteractor(this._repository);
  final ContactsRepository _repository;

  @override
  Future<void> exampleFunc() async {
    try {
      await _repository.exampleFuncRepo();
    } catch (e) {
      rethrow;
    }
  }
}
