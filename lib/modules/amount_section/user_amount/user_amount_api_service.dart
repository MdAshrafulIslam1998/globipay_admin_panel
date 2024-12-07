import 'package:dio/dio.dart';
import 'user_amount_response.dart';

class UserAmountApiService {
  final Dio dio = Dio();

  final String jwtToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI3NzQ2YzE5LTdhNjEtMTFlZi04MjExLTgwZmE1Yjg4OGM5YSIsImlhdCI6MTczMzQ2NzExMiwiZXhwIjoxNzMzNTc1MTEyfQ.ZNydvKufh52EIDsH7oLPt33SD3Sukxz7M5yzTnJ7D_k";

  Future<UserAmountResponse?> fetchUserAmounts(int page, int limit) async {
    final String url =
        'https://www.projectzerotwofour.cloudns.ch/api/amountdetailsweb';

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
        return UserAmountResponse.fromJson(response.data);
      } else {
        print(
            "Failed to load user amounts with status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred while fetching user amounts: ${e.toString()}");
      return null;
    }
  }
}
