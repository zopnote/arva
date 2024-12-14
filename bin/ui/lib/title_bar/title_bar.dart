import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/title_bar/window_management_button.dart';

class TitleBar extends AppBar {
  final double? height;
  final Color? color;
  final List<Widget>? center;
  final List<Widget>? left;
  final List<Widget>? right;
  TitleBar({super.key,
    this.center,
    this.left,
    this.right,
    this.height,
    this.color
  });
  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  bool hoverMinimize = false;
  bool hoverClose = false;
  @override
  Widget build(BuildContext context) {
    List<Widget> windowManagementButtons = [
      WindowManagementButton(
          iconColor: Colors.white,
          onTap: () {
            appWindow.minimize();
          },
          iconData: CarbonIcons.minimize,
          iconSize: 15,
          backgroundColor: Color(0xFFFFFF),
          iconColorHover: Colors.white,
          backgroundColorHover: Color(0x24FFFFFF),
          alignment: Alignment(0, 0.05)
      ),
      WindowManagementButton(
          iconColor: Colors.white,
          onTap: () {
            appWindow.close();
          },
          iconData: CarbonIcons.close,
          iconSize: 20,
          backgroundColor: Color(0xFFFFFF),
          iconColorHover: Colors.white,
          backgroundColorHover: Color(0x91FF1919),
          alignment: Alignment(-0.1, 0.13)
      ),
    ];
    List<Widget> content = [];
    List<Widget> right = [];
    if (widget.right != null) right.addAll(widget.right!);
    right.addAll(windowManagementButtons);
    List<List<Widget>?> args = [
      widget.left,
      widget.center,
      right,
    ];
    for (List<Widget>? arg in args) {
      if (arg != null) {
        content.add(
            SizedBox(
                child: Row(
                    children: arg
                )
            )
        );
        continue;
      }
      content.add(SizedBox());
    }
    return Container(
      height: widget.height,
      color: widget.color,
      child: MoveWindow(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: content,
        ),
      ),
    );
  }
}
