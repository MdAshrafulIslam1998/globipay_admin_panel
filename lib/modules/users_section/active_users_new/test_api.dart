import 'package:dio/dio.dart';

void main() async {
  final Dio dio = Dio();
  final String url = 'https://www.projectzerotwofour.cloudns.ch/api/user/verifiedusersweb';
  
  // Your JWT token
  final String jwtToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI3NzQ2YzE5LTdhNjEtMTFlZi04MjExLTgwZmE1Yjg4OGM5YSIsImlhdCI6MTczMTU5MjIyNywiZXhwIjoxNzMxNzAwMjI3fQ.OZRyCCW7rTVfVFCAulMfSf0lokUHfa686poFuLnQM0o';

  try {
    // Making the API call
    final response = await dio.get(
      url,
      queryParameters: {
        'page': 1,     // Set the page you want to retrieve
        'limit': 10,   // Set the limit of users per page
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $jwtToken', // Add your JWT token here
        },
      ),
    );

    // Checking if the request was successful
    if (response.statusCode == 200) {
      print("API Response Data: ${response.data}");
    } else {
      print("Failed to load users. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error occurred while fetching users: $e");
  }
}