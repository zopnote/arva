
import 'dart:io';
import 'package:yaml/yaml.dart' as yaml;

Directory get scriptDirectory {
  String path = File('${Platform.script.path}').parent.path;
  if (Platform.isWindows) {
    return Directory(path.substring(1));
  }
  return Directory(path);
}

Directory get configDirectory {
  String path = '${scriptDirectory}/internal/';
  if (Platform.isWindows) {
    return Directory(path.substring(1));
  }
  return Directory(path);
}

dynamic getValue(String path, {Map<String, String>? variables}) async {
  List<FileSystemEntity> files = await configDirectory.list().toList();
  File? targetFile;
  for (FileSystemEntity entity in files) {
    if (entity is Directory) {
      continue;
    }
    String entityName = entity.path.split('/').last;
    String targetName = path.split('.').first;
    if (entityName != targetName) {
      continue;
    }
    targetFile = entity as File;
  }
  if (targetFile == null) {
    return;
  }
  String targetFileContent = await targetFile.readAsString();
  Map<String, dynamic> data = yaml.loadYaml(targetFileContent);

  int targetFileNameIndex = 1;
  List<String> splitPath = path.split('.').sublist(targetFileNameIndex);

}