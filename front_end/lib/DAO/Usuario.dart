import 'package:dio/dio.dart';
import 'package:front_end/Utils/connection.dart';
import 'package:front_end/Utils/result.dart';

class UsuarioDAO {
  Future<Result<String, Exception>> login(FormData dadosLogin) async {
    try {
      Response response =
          await Connection.handler.post('/login', data: dadosLogin);

      return Success(response.data);
    } on DioException catch (e) {
      return Failure(e);
    }
  }
}
