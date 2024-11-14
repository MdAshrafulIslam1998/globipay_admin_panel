import 'package:dio/dio.dart';
import 'user_new_response_model.dart';

class UserApiService {
  final Dio _dio = Dio();

  // Consider using a secure environment variable for the JWT token
  final String jwtToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI3NzQ2YzE5LTdhNjEtMTFlZi04MjExLTgwZmE1Yjg4OGM5YSIsImlhdCI6MTczMTU5MjIyNywiZXhwIjoxNzMxNzAwMjI3fQ.OZRyCCW7rTVfVFCAulMfSf0lokUHfa686poFuLnQM0o"; // Replace with your actual token

  Future<UserResponse?> fetchUsers(int page, int limit) async {
    const String baseUrl = 'https://www.projectzerotwofour.cloudns.ch/api/user';
    final String endpoint =
        '/verifiedusersweb'; // Assuming this is the correct endpoint

    try {
      final response = await _dio.get(
        baseUrl + endpoint,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
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
      if (e is DioError) {
        print("DioError type: ${e.type}, message: ${e.message}");
      }
      return null;
    }
  }
}
