/**
 * Created by Abdullah on 13/12/24.
 */

enum RoleName{
  ADMIN("1"),
  SUPER_ADMIN("3"),
  MODERATOR("4")
  ;
  final String code;
  const RoleName(this.code);
}