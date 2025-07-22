import 'package:dio/dio.dart';
import 'package:school_application/main.dart';

class UserService {
  static getOne(int id, String token) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        consUrl('users/${id}'),
        options: Options(headers: {'Authorization': 'Bearer ${token}'}),
      );
      if (response.statusCode == 200) {
        for(int i = 0 ; i<100;i++){
          print(response.data.toString());
        }
      } else {

      }
    } catch (e) {
      print(e);
    }
  }
}
