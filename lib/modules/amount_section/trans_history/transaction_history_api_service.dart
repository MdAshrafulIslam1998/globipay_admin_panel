import 'package:dio/dio.dart';
import 'package:globipay_admin_panel/modules/amount_section/trans_history/trans_history_response.dart';


class TransactionHistoryApiService {
  final Dio dio = Dio();

  final String jwtToken = 
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI3NzQ2YzE5LTdhNjEtMTFlZi04MjExLTgwZmE1Yjg4OGM5YSIsImlhdCI6MTczMzQ2NzExMiwiZXhwIjoxNzMzNTc1MTEyfQ.ZNydvKufh52EIDsH7oLPt33SD3Sukxz7M5yzTnJ7D_k";

  Future<TransactionResponse?> fetchTransactions(int page, int limit) async {
    const String url = 'https://www.projectzerotwofour.cloudns.ch/api/alltransactions';

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
        return TransactionResponse.fromJson(response.data);
      } else {
        print("Failed to load transactions. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred while fetching transactions: ${e.toString()}");
      return null;
    }
  }
}
