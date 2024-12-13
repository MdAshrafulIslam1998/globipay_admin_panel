import 'package:dio/dio.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/modules/users_section/add_level/controller/level_model.dart';


class LevelResponse {
  String? responseCode;
  String? responseMessage;
  LevelData? data;

  LevelResponse({this.responseCode, this.responseMessage, this.data});

  LevelResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    data = json['data'] != null ? LevelData.fromJson(json['data']) : null;
  }
}

class LevelData {
  List<LevelModel>? levels;

  LevelData({this.levels});

  LevelData.fromJson(Map<String, dynamic> json) {
    if (json['levels'] != null) {
      levels = <LevelModel>[];
      json['levels'].forEach((v) {
        levels!.add(LevelModel.fromJson(v));
      });
    }
  }
}

class LevelService {
  final Dio _dio = Dio();
  final TokenRepository _tokenRepository;

  LevelService(this._tokenRepository);

  // Fetch existing levels with authentication
  Future<LevelResponse> fetchLevels() async {
    try {
      // Retrieve the auth token
      final token = await _tokenRepository.getToken();

      // Configure Dio with the auth token
      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.get('https://www.projectzerotwofour.cloudns.ch/api/levels');
      return LevelResponse.fromJson(response.data);
    } catch (e) {
      // Handle specific error scenarios
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          // Token might be expired, handle re-authentication
          throw Exception('Authentication failed. Please log in again.');
        }
      }
      throw Exception('Failed to fetch levels: ${e.toString()}');
    }
  }

  // Add new level with authentication
  Future<void> addLevel(LevelModel level) async {
    try {
      // Retrieve the auth token
      final token = await _tokenRepository.getToken();

      // Configure Dio with the auth token
      _dio.options.headers['Authorization'] = 'Bearer $token';

      // Optional: Add user ID to the level if needed
      final userId = await _tokenRepository.getUserID();
      level.createdBy = userId;

      await _dio.post(
        'https://www.projectzerotwofour.cloudns.ch/api/levels/addlevel', 
        data: level.toJson()
      );
    } catch (e) {
      // Handle specific error scenarios
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          // Token might be expired, handle re-authentication
          throw Exception('Authentication failed. Please log in again.');
        }
      }
      throw Exception('Failed to add level: ${e.toString()}');
    }
  }
}