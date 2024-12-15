
import 'dart:io';
import 'package:yaml/yaml.dart' as yaml;
import 'package:path/path.dart' as path_package;

/// Returns the directory where the script is located.
///
/// On Windows, the script's path may include an additional leading slash.
/// This method removes the extra slash to ensure a valid directory path.
Directory get scriptDirectory {
  String path = File('${Platform.script.path}').parent.path;

  // Adjust the path for Windows by removing the leading slash
  if (Platform.isWindows) {
    return Directory(path.substring(1));
  }

  return Directory(path);
}

/// Returns the configuration directory located under the script directory.
///
/// By default, this is a subdirectory named "internal" within the script's directory.
Directory get configDirectory {
  String path = '${scriptDirectory.path}/internal';
  return Directory(path);
}


/// Searches for a file with the specified [name] in the given [directoryPath].
///
/// [directoryPath]: The path to the directory where the search should begin.
/// [name]: The name of the file to find (without extension, if [fileExtensions] is provided).
/// [recursive]: Whether to search recursively through subdirectories (default: false).
/// [fileExtensions]: A list of allowed file extensions (optional).
///
/// Returns a [File] if found, or `null` if no matching file is found.
Future<File?> getFile({
  required String directoryPath,
  required String name,
  bool recursive = false,
  List<String>? fileExtensions,
}) async {
  final directory = Directory(directoryPath);

  // Ensure the directory exists
  if (!await directory.exists()) {
    return null;
  }

  // Get all entities in the directory
  final List<FileSystemEntity> entities = await directory.list(recursive: recursive).toList();

  for (final entity in entities) {
    if (entity is File) {
      final String fileBasename = path_package.basename(entity.path);

      if (fileExtensions == null) {
        // If no extensions are provided, match the exact filename
        if (fileBasename == name) {
          return entity;
        }
      } else {
        // Extract the file name and extension
        final String fileExtension = path_package.extension(fileBasename).replaceFirst('.', '');
        final String fileNameWithoutExtension = path_package.basenameWithoutExtension(fileBasename);

        // Check if the file matches one of the provided extensions and the name
        if (fileExtensions.contains(fileExtension) && fileNameWithoutExtension == name) {
          return entity;
        }
      }
    }
  }

  // Return null if no matching file is found
  return null;
}


/// Splits a configuration path into a list of segments based on the '.' delimiter.
/// For example, "a.b.c" becomes ["a", "b", "c"].
List<String> _configPathToList(String path) => path.split('.');

/// Extracts the basename (first segment) of a configuration path.
/// For example, "a.b.c" returns "a".
String _getConfigurationBasename(String path) => _configPathToList(path).first;

/// Retrieves a nested configuration value from a YAML file.
///
/// [path]: A dot-delimited string representing the hierarchy of the value to retrieve.
/// For example, "example_file.test.test_int" navigates through the file "example_file" then to -> "test" -> "test_int".
///
/// [variables]: An optional map of variables to replace in the retrieved value.
///
/// Returns the value if found and properly typed, or `null` if the path is invalid or not found. (The file given at first must be an yaml)
Future<T?> getValue<T>({
  required String path,
  Map<String, String>? variables,
}) async {
  // Find the corresponding configuration file for the given path
  File? configurationFile = await getFile(
    directoryPath: '${configDirectory.path}/',
    name: _getConfigurationBasename(path),
    fileExtensions: [
      '.yml',
      '.yaml',
    ],
  );

  // If no configuration file is found, return null
  if (configurationFile == null) return null;

  // Read and parse the YAML content from the file
  String yamlString = await configurationFile.readAsString();
  int withoutTheFirst = 1; // Start processing the path after the first segment
  List<String> splitPath = _configPathToList(path).sublist(withoutTheFirst);

  yaml.YamlMap contentMap = yaml.loadYaml(yamlString);

  T? value;

  // Traverse the YAML structure according to the provided path
  for (int index = 0; index < splitPath.length; index++) {
    if (!(contentMap[splitPath[index]] is yaml.YamlMap)) {
      value = contentMap[splitPath[index]];
      break;
    }
    contentMap = contentMap[splitPath[index]];
  }

  // If variables are provided, replace placeholders in the value
  if (variables != null) value = _replaceVariablesInValue<T>(variables, value);

  return value;
}

/// Replaces variables in a given value with their corresponding values from a map.
///
/// [variables]: A map where keys are variable names (without placeholders) and
/// values are the replacements.
/// [value]: The value in which variables should be replaced. Can be a String,
/// a list, or other data types.
///
/// Returns the value with variables replaced.
T? _replaceVariablesInValue<T>(Map<String, dynamic> variables, T? value) {
  // Replace variables in a String
  String replaceInString(String input, Map<String, dynamic> variables) {
    for (final entry in variables.entries) {
      input = input.replaceAll('\${${entry.key}}', entry.value.toString());
    }
    return input;
  }

  // Replace variables in a List
  List replaceInList(List input, Map<String, dynamic> variables) {
    return input.map((element) {
      if (element is String) {
        return replaceInString(element, variables);
      }
      return _replaceVariablesInValue(variables, element);
    }).toList();
  }

  // Determine value type and process accordingly
  if (value is String) {
    return replaceInString(value, variables) as T?;
  } else if (value is yaml.YamlList) {
    return replaceInList(value.toList(), variables) as T?;
  } else if (value is List) {
    return replaceInList(value, variables) as T?;
  }

  // Return the value unchanged if it's not a String or List
  return value;
}