/// Created by Abdullah on 28/12/24.
library;

enum ChatSessionType {
  OPEN("open"),
  CLOSED("closed"),
  ;
  final String code;
  const ChatSessionType(this.code);
}