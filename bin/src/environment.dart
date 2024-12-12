import 'dart:io';

String getScriptFolder() => File(Platform.script.path).parent.path;
