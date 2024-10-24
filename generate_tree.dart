import 'dart:io';

void printDirectoryStructure(
  Directory directory, {
  int level = 0,
  StringBuffer? buffer,
  List<String>? ignore,
  bool isLast = false,
}) {
  final indent = '│   ' * (level - 1) + (level > 0 ? (isLast ? '└── ' : '├── ') : '');
  final entities = directory.listSync();

  for (int i = 0; i < entities.length; i++) {
    var entity = entities[i];
    final entityName = entity.path.split(Platform.pathSeparator).last;

    // Skip ignored folders
    if (ignore != null && ignore.contains(entityName)) {
      continue;
    }

    bool lastEntity = (i == entities.length - 1);

    if (entity is Directory) {
      buffer?.writeln('$indent$entityName');
      printDirectoryStructure(entity, level: level + 1, buffer: buffer, ignore: ignore, isLast: lastEntity);
    } else if (entity is File) {
      buffer?.writeln('$indent$entityName');
    }
  }
}

void main() {
  final currentDirectory = Directory.current;
  final outputFile = File('project_structure.txt');

  final buffer = StringBuffer();

  // List of folders to ignore
    // List of folders to ignore
  final List<String> ignoreFolders = ['build', '.git', 'node_modules','.github','.vscode','.dart_tool','android','ios','linux','macos','web'];

  // Write project structure header
  buffer.writeln('Project Structure');
  buffer.writeln();

  // Generate the folder structure
  printDirectoryStructure(currentDirectory, buffer: buffer, ignore: ignoreFolders);

  // Write buffer to file
  outputFile.writeAsStringSync(buffer.toString());

  print('Folder structure has been written to project_structure.txt');
}