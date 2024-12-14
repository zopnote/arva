
import 'package:flutter/cupertino.dart';

typedef OutlookTitleWidget = Widget Function(
    BuildContext context,
    bool hover,
    bool selected,
    void Function() close,
    );
class Outlook {
  final OutlookTitleWidget title;
  final Widget content;
  Outlook({
    required this.title,
    required this.content
  });
}

class OutlookTab extends Outlook {
  int lastIndex;
  int lastLength;
  UniqueKey lastPanel;
  OutlookTab({
    required super.title,
    required super.content,
    required this.lastIndex,
    required this.lastLength,
    required this.lastPanel
  });
}