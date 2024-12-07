import 'package:dio/dio.dart';
import 'user_new_response_model.dart';

class UserApiService {
  final Dio dio = Dio();
  
  final String jwtToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI3NzQ2YzE5LTdhNjEtMTFlZi04MjExLTgwZmE1Yjg4OGM5YSIsImlhdCI6MTczMzU5NTEzNywiZXhwIjoxNzMzNzAzMTM3fQ.S-VvAvA4XBE2cW5VDWjGF4f-JfNXfWgeluivkO3JB-I";

  Future<UserResponse?> fetchUsers(int page, int limit) async {
    final String url = 'https://www.projectzerotwofour.cloudns.ch/api/user/verifiedusersweb';
    
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
            'Content-type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      } else {
        print("Failed to load users with status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred while fetching users: ${e.toString()}");
      return null;
    }
  }
}