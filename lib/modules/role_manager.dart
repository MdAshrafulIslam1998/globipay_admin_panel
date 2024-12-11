class RoleManager {
  static const String admin = '1';
  static const String subadmin = '3';
  static const String moderator = '4';

  // Define column visibility for each role
  static final Map<String, List<String>> roleColumnVisibility = {
    '1': ['name', 'email','phone', 'primary', 'secondary', 'levelName', 'date', 'status', 'details', 'delete', 'message'],
    '2': ['name',  'primary', 'secondary', 'levelName', 'date', 'status', 'details', 'message'],
    '3': ['name',  'primary', 'secondary', 'levelName', 'date', 'status',  'message'],
  };

  static List<String> getVisibleColumns(String role) {
    return roleColumnVisibility[role] ?? [];
  }
}
