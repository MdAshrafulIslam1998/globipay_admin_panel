class RoleManager {
  static const String admin = 'Admin';
  static const String manager = 'Manager';
  static const String viewer = 'Viewer';

  // Define column visibility for each role
  static final Map<String, List<String>> roleColumnVisibility = {
    admin: ['name', 'email', 'primary', 'secondary', 'levelName', 'date', 'status', 'details', 'delete', 'message'],
    manager: ['name', 'email', 'levelName', 'status', 'details', 'message'],
    viewer: ['name', 'email', 'status'],
  };

  static List<String> getVisibleColumns(String role) {
    return roleColumnVisibility[role] ?? [];
  }
}
