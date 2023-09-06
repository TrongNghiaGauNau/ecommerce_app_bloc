import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<List<String>> login() async{
    final url = Uri.https(
        'flutter-prep-f63d7-default-rtdb.firebaseio.com', 'login.json');
    String username = '';
    String password = '';

    //xử lý lỗi
    try {
      //chỉ cho phần code có thể phát sinh lỗi chứ ko cho hết
      final response = await http.get(url);
      //check trường hợp ko còn data trong backend thì ko chạy code sau đó nếu ko
      //sẽ truyền null về
      if (response.body == 'null') {
        return [];
      }
      final Map<String, dynamic> listData = json.decode(response.body);
      for (final item in listData.entries) {
          username =  item.value['username'];
          password =  item.value['password'];

      }
      return [username,password];
    } catch (error) {
      print('Something went wrong');
      return [];
    }
  }
}