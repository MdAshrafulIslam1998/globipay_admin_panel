class RoleManager {
  static const String admin = '1';
  static const String subadmin = '3';
  static const String moderator = '4';

  // Define column visibility for each role
  static final Map<String, List<String>> roleColumnVisibility = {
    '1': ['name', 'email','phone', 'primary', 'secondary', 'levelName', 'date', 'status', 'details', 'delete', 'message'], //admin
    '3': ['name',  'primary', 'secondary', 'levelName', 'date', 'status', 'details', 'message'], //subadmin
    '4': ['name',  'primary', 'secondary', 'levelName', 'date', 'status',  'message'], //moderator
  };

  static List<String> getVisibleColumns(String role, String tablename) {
    return roleColumnVisibility[role] ?? [];
  }
}
