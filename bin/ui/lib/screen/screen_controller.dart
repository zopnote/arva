

import 'package:ui/screen/screen_data.dart';

typedef ScreenChangeCallback = void Function(ScreenData current);

class ScreenController {
  ScreenController({
    required ScreenData initial
  }) {
    _current = initial;
  }
  late ScreenData _current;
  final List<ScreenChangeCallback> _listener = [];
  ScreenData get screen => _current;
  set screen(ScreenData current) {
    _current = current;
    for (var element in _listener) {
      element(current);
    }
  }
  void addListener(ScreenChangeCallback function) => _listener.add(function);
}