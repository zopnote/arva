
import 'config.dart';

Future<void> main(List<String> args) async {
  if (args.length < 1) {
    for (String line in await getValue('messages.info')) {
      print(line.replaceAll('\${VERSION}', '1.0'));
    }
    return;
  }
  for (String argument in arguments.keys) {
    if (argument == args[0]) arguments[argument]!(args);
  }
}

typedef ArgumentVoidCallback = void Function(List<String> args);

Map<String, ArgumentVoidCallback> arguments = {
  'cache': cache,
  'version': version
};


Future<void> cache(List<String> args) async {
  for (String line in await getValue('messages.info_cache')) {
  print(line.replaceAll('\${VERSION}', '1.0'));
  }
}

Future<void> version(List<String> args) async {
  for (String line in await getValue('messages.version')) {
    print(line.replaceAll('\${VERSION}', '1.0'));
  }
}
