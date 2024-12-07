import 'package:dio/dio.dart';
import 'package:globipay_admin_panel/modules/users_section/blocked_users/blocked_user_response.dart';


class BlockedUserApiService {
  final Dio dio = Dio();
  final String jwtToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI3NzQ2YzE5LTdhNjEtMTFlZi04MjExLTgwZmE1Yjg4OGM5YSIsImlhdCI6MTczMzQ2NzExMiwiZXhwIjoxNzMzNTc1MTEyfQ.ZNydvKufh52EIDsH7oLPt33SD3Sukxz7M5yzTnJ7D_k";

  Future<BlockedUserResponse?> fetchBlockedUsers(int page, int limit) async {
    const String url =
        'https://www.projectzerotwofour.cloudns.ch/api/user/blockedusersweb';

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
        return BlockedUserResponse.fromJson(response.data);
      } else {
        print(
            "Failed to load blovked users with status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred while fetching blocked users: ${e.toString()}");
      return null;
    }
  }
}
