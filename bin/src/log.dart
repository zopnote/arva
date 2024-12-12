import 'dart:io';
import 'dart:isolate';

import 'config.dart' as config;
import 'environment.dart';

File get log {
  final String filePath = '${getScriptFolder()}/internal/';
  if (Platform.isWindows) {
    return File(filePath.substring(1));
  }
  return File(filePath);
}


enum Importance {
  error,
  info,
  warning,
  critical
}


late SendPort sendPort;


void write(Importance importance, String message, {bool printOut = true}) {
  String dateTime = DateTime.now().toString().substring(0, 22);
  Map<Importance, String> importanceString = {};
  for (Importance valueImportance in Importance.values) {
    importanceString[valueImportance] = "$valueImportance".split('.').last.toUpperCase();
  }
  String letter = '\n(${importanceString[importance]})($dateTime): $message';
  if (printOut) print(letter);
  sendPort.send(letter);
}

Future<void> message(Map<String, String> variables, path, Importance importance) async {
  String? message = await config.getValue(path);
  if (message == null) return;

  for (String variable in variables.keys) {
    message.replaceAll(
        '{${variable}}',
        variables[variable]!
    );
  }
  write(importance, message);
}

Future<void> startIsolate() async {
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(_isolateEntry, receivePort.sendPort);
  sendPort = await receivePort.first;
  receivePort.close();
}


Future<void> _isolateEntry(SendPort sendPort) async {
  final ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  if (!await log.exists()) await log.create();
  receivePort.listen((message) {
    log.writeAsStringSync(message.toString(), mode: FileMode.append);
  });
}