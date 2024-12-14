import 'package:flutter/material.dart';

class WindowManagementButton extends StatefulWidget {
  final IconData iconData;
  final double iconSize;
  final VoidCallback onTap;
  final Color iconColor;
  final Color backgroundColor;
  final Color iconColorHover;
  final Color backgroundColorHover;
  final Alignment alignment;
  const WindowManagementButton({
    super.key,
    required this.iconData,
    required this.iconSize,
    required this.onTap,
    required this.iconColor,
    required this.backgroundColor,
    required this.iconColorHover,
    required this.backgroundColorHover,
    required this.alignment
  });
  @override
  State<WindowManagementButton> createState() => _WindowManagementButtonState();
}

class _WindowManagementButtonState extends State<WindowManagementButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return MouseRegion(
          onEnter: (_) => setState(() {
            hover = true;
          }),
          onExit: (_) => setState(() {
            hover = false;
          }),
          child: GestureDetector(
              onTap: () => widget.onTap(),
              child: Container(
                width: 50,
                height: constrains.maxHeight,
                decoration: BoxDecoration(
                  color: hover ? widget.backgroundColorHover : widget.backgroundColor,
                ),
                child: Align(
                  alignment: widget.alignment,
                  child: Icon(
                    widget.iconData,
                    color: hover ? widget.iconColor : widget.iconColorHover,
                    size: widget.iconSize,
                  ),
                ),
              )
          )
      );
    });
  }
}