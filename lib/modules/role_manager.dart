class RoleManager {
  static const String admin = 'Admin';
  static const String subadmin = 'Subadmin';
  static const String moderator = 'Moderator';

  // Define column visibility for each role
  static final Map<String, List<String>> roleColumnVisibility = {
    admin: ['name', 'email','phone', 'primary', 'secondary', 'levelName', 'date', 'status', 'details', 'delete', 'message'],
    subadmin: ['name',  'primary', 'secondary', 'levelName', 'date', 'status', 'details', 'message'],
    moderator: ['name',  'primary', 'secondary', 'levelName', 'date', 'status',  'message'],
  };

  static List<String> getVisibleColumns(String role) {
    return roleColumnVisibility[role] ?? [];
  }
}
