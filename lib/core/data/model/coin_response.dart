import 'coin_data.dart';

class CoinResponse {
  final List<CoinData> data;
  final int totalCount;

  CoinResponse({
    required this.data,
    required this.totalCount,
  });
}