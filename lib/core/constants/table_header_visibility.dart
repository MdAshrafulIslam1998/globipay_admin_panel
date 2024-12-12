import 'package:globipay_admin_panel/core/constants/enum/table_name.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';

import 'enum/role_name.dart';

/**
 * Created by Abdullah on 13/12/24.
 */

abstract class TableHeaderVisibility {
  static TokenRepository tokenRepository = Injector.resolve<TokenRepository>();

  static getTableVisibleColumn(TableName tableName) async {
    tokenRepository.getRole().then((role) {
      switch (tableName) {
        case TableName.USER_ACTIVE_TABLE:
          return _USER_ACTIVE_TABLE[role];
        case TableName.USER_PENDING_TABLE:
          return _USER_PENDING_TABLE[role];

        default:
          return [];
      }
    });

  }

  static Map<String, List<String>> _USER_ACTIVE_TABLE = {
    RoleName.ADMIN.code: [
      'name',
      'email',
      'phone',
      'primary',
      'secondary',
      'levelName',
      'date',
      'status',
      'details',
      'delete',
      'message'
    ], //admin
    RoleName.SUPER_ADMIN.code: [
      'name',
      'primary',
      'secondary',
      'levelName',
      'date',
      'status',
      'details',
      'message'
    ], //subadmin
    RoleName.MODERATOR.code: [
      'name',
      'primary',
      'secondary',
      'levelName',
      'date',
      'status',
      'message'
    ], //moderator
  };

  static Map<String, List<String>> _USER_PENDING_TABLE = {
    RoleName.ADMIN.code: [
      'name',
      'email',
      'phone',
      'primary',
      'secondary',
      'levelName',
      'date',
      'status',
      'details',
      'delete',
      'message'
    ], //admin
    RoleName.SUPER_ADMIN.code: [
      'name',
      'primary',
      'secondary',
      'levelName',
      'date',
      'status',
      'details',
      'message'
    ], //subadmin
    RoleName.MODERATOR.code: [
      'name',
      'primary',
      'secondary',
      'levelName',
      'date',
      'status',
      'message'
    ], //moderator
  };
}
