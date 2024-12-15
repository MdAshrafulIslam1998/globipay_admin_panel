import 'package:globipay_admin_panel/core/constants/enum/table_name.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/modules/media_section/miscellaneous/table/table_header_const.dart';
import 'enum/role_name.dart';

/**
 * Created by Abdullah on 13/12/24.
 */

abstract class TableHeaderVisibility {
  static getTableVisibleColumn({required TableName tableName}) async {
    final tokenRepository = Injector.resolve<TokenRepository>();
    final currentRole = await tokenRepository.getRole();
    appPrint("Current Role: $currentRole");
    switch (tableName) {
      case TableName.USER_ACTIVE_TABLE:
        return _USER_ACTIVE_TABLE[currentRole];
      case TableName.USER_PENDING_TABLE:
        return _USER_PENDING_TABLE[currentRole];
      case TableName.USER_BLOCKED_TABLE:
        return _USER_BLOCKED_TABLE[currentRole];
      case TableName.USER_LEVEL_TABLE:
        return _USER_LEVEL_TABLE[currentRole];
      case TableName.MISC_TABLE:
        return _MISC_TABLE[currentRole];
      case TableName.USER_TRANSACTION_TABLE:
        return _USER_TRANSACTION_TABLE[currentRole];

      default:
        return [];
    }
  }

  static final Map<String, List<String>> _USER_ACTIVE_TABLE = {
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

  static final Map<String, List<String>> _USER_PENDING_TABLE = {
    RoleName.ADMIN.code: [
      'name',
      'email',
      'date',
      'status',
      'document',
    ], //admin
    RoleName.SUPER_ADMIN.code: [
      'name',
      'date',
      'status',
      'document',
    ], //subadmin
    RoleName.MODERATOR.code: [
      'name',
      'date',
      'status',
    ], //moderator
  };

  static final Map<String, List<String>> _USER_BLOCKED_TABLE = {
    RoleName.ADMIN.code: [
      'name',
      'email',
      'date',
      'status',
      'document',
    ], //admin
    RoleName.SUPER_ADMIN.code: [
      'name',
      'date',
      'status',
    ], //subadmin
    RoleName.MODERATOR.code: [
      'name',
      'date',
      'status',
    ], //moderator
  };

  static final Map<String, List<String>> _USER_LEVEL_TABLE = {
    RoleName.ADMIN.code: [
      'name',
      'email',
      'primary',
      'secondary',
      'levelName',
      'date',
      'status',
      'edit',
      'details'
    ], //admin
    RoleName.SUPER_ADMIN.code: [
      'name',
      'primary',
      'secondary',
      'levelName',
      'date',
      'status',
      'edit',
      'details'
    ], //subadmin
    RoleName.MODERATOR.code: [
      'name',
      'email',
      'primary',
      'secondary',
      'levelName',
      'date',
      'status',
    ], //moderator
  };

  static final Map<String, List<String>> _MISC_TABLE = {
     RoleName.ADMIN.code: const [
      MiscTableHeaderConst.ID,
      MiscTableHeaderConst.FEATURE_CODE,
      MiscTableHeaderConst.TYPE,
      MiscTableHeaderConst.CONTENT,
      MiscTableHeaderConst.DETAILS,
      MiscTableHeaderConst.DELETE,

    ], //admin
    RoleName.SUPER_ADMIN.code: [
      MiscTableHeaderConst.ID,
      MiscTableHeaderConst.FEATURE_CODE,
      MiscTableHeaderConst.TYPE,
      MiscTableHeaderConst.CONTENT,
      MiscTableHeaderConst.DETAILS,
      MiscTableHeaderConst.DELETE,
    ], //subadmin
    RoleName.MODERATOR.code: [
      MiscTableHeaderConst.ID,
      MiscTableHeaderConst.FEATURE_CODE,
      MiscTableHeaderConst.TYPE,
      MiscTableHeaderConst.CONTENT,
      MiscTableHeaderConst.DETAILS,
      MiscTableHeaderConst.DELETE,
    ], //moderator
  };


  static Map<String, List<String>> _USER_TRANSACTION_TABLE = {
    RoleName.ADMIN.code: [
      'name',
      'email',
      'date',
      'coin',
      'coin_type',
      'category_name'
    ], //admin
    RoleName.SUPER_ADMIN.code: [
      'name',
      'date',
      'coin',
      'coin_type',
      'category_name'
    ], //subadmin
    RoleName.MODERATOR.code: [
      'name',
      'date',
      'coin',
      'coin_type',
      'category_name'
    ], //moderator
  };
}
