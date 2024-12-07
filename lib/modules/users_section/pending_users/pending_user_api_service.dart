import 'package:dio/dio.dart';
import 'pending_user_response.dart';

class PendingUserApiService {
  final Dio dio = Dio();
  final String jwtToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI3NzQ2YzE5LTdhNjEtMTlZi04MjExLTgwZmE1Yjg4OGM5YSIsImlhdCI6MTczMzU5NTEzNywiZXhwIjoxNzMzNzAzMTM3fQ.S-VvAvA4XBE2cW5VDWjGF4f-JfNXfWgeluivkO3JB-I";

  Future<PendingUserResponse?> fetchPendingUsers(int page, int limit) async {
    const String url =
        'https://www.projectzerotwofour.cloudns.ch/api/user/pendingusersweb';

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
          },
        ),
      );

      if (response.statusCode == 200) {
        print("API call successful. Status Code: 200");
        return PendingUserResponse.fromJson(response.data);
      } else {
        print(
            "Failed to load pending users with status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred while fetching pending users: ${e.toString()}");
      return null;
    }
  }
}
