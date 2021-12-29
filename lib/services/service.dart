import 'package:demoapppresentation/models/users.dart';
import 'package:http/http.dart' as http;

class Services {


  static Future<List<Users>> fetchUsersLatLong() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      final List<Users> users = usersFromJson(response.body);
      return users;
    } else {
      print('exception occurred or something went wrong');
      throw Exception('Failed to load album');
    }
  }

}
