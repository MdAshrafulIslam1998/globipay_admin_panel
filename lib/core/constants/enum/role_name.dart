/// Created by Abdullah on 13/12/24.
library;

enum RoleName{
  ADMIN("1", "Admin"),
  SUB_ADMIN("3", "Subadmin"),
  MODERATOR("4", "Moderator"),
  ;
  final String code;
  final String title;
  const RoleName(this.code,this.title);
}