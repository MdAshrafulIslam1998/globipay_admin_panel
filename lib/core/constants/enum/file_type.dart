/**
 * Created by Abdullah on 15/12/24.
 */

enum FileType {
  HTML("html","Html"),
  TEXT("text", "Text"),;

  final String title;
  final String code;

  const FileType(this.title,this.code);
}