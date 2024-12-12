import 'dart:convert';
import 'dart:io';

import 'environment.dart';

Directory get configDirectory {
  final String directoryPath = getScriptFolder();
  return Directory(
      Platform.isWindows ? directoryPath.substring(1) : directoryPath
  );
}

/// Gets the value out of the configuration files.
///
/// The [path] contains the file and the path of the json object.
/// A valid path looks like [file.path.to.value].
Future<dynamic> getValue(String path) async {
  if (!await configDirectory.exists()) return null;

  final List<String> pathAsList = path.split('.');
  final String configFileName = pathAsList.first;
  final File configFile = File('${configDirectory.path}/$configFileName.json');

  if (!await configFile.exists()) return null;

  final List<String> valuePathAsList = pathAsList.sublist(1);

  final String configFileContent = await configFile.readAsString();
  Map<String, dynamic> configFileContentAsJson = jsonDecode(configFileContent);

  for (int keyIndex = 0; keyIndex < (valuePathAsList.length-1); keyIndex++) {

    if (configFileContentAsJson[valuePathAsList[keyIndex]] == null ||
        !(configFileContentAsJson[valuePathAsList[keyIndex]] is Map)) break;

    configFileContentAsJson = configFileContentAsJson[valuePathAsList[keyIndex]];
  }
  return configFileContentAsJson[valuePathAsList.last];
}
