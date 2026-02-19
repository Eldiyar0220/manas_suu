import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/contacts/data/models/contacts_model.dart';
import 'package:manas_suu_app/feature/contacts/domain/repository/contacts_repository.dart';

@Singleton(as: ContactsRepository)
class ContactsRepositoryImpl implements ContactsRepository {
  ContactsRepositoryImpl(this._dio);
  final Dio _dio;
  
  final String _getList = ' API ';

  @override
  Future<String> exampleFuncRepo() async {
    final response = await _dio.get(_getList);
    return ContactsModel.fromJson(response.data).name;
  }
}
