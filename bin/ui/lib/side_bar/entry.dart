import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/animated_symbol.dart';

@immutable
final class SideTabBarEntry {
  final String title;
  final AnimatedSymbolCallback? icon;
  const SideTabBarEntry(
      {
        required this.title,
        this.icon,
      });
  _SideTabBarEntryWidget widget(
      BuildContext context, {
        required double height,
        required double width,
        required bool active,
        TabController? controller,
        required int index,
      }) {
    return _SideTabBarEntryWidget(
      data: this,
      height: height,
      active: active,
      controller: controller,
      index: index,
      icon: icon,
    );
  }
}
final class _SideTabBarEntryWidget extends StatefulWidget {
  final SideTabBarEntry data;
  final double height;
  final bool active;
  final TabController? controller;
  final AnimatedSymbolCallback? icon;
  final int index;
  const _SideTabBarEntryWidget({
    required this.data,
    required this.height,
    required this.active,
    this.controller,
    required this.index,
    this.icon
  });
  @override
  State<_SideTabBarEntryWidget> createState() => _SideTabBarEntryWidgetState();
}
final class _SideTabBarEntryWidgetState extends State<_SideTabBarEntryWidget> with SingleTickerProviderStateMixin {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (widget.controller != null) {
          widget.controller!.index = widget.index;
        }
      },
      child: MouseRegion(
        onEnter: (_) => setState(() {
          isHover = true;
        }),
        onExit: (_) => setState(() {
          isHover = false;
        }),
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.active ? isHover ? Color(0xFF2C2C36) : Color(0xFF18181E) : isHover ? Color(0xFF202028) : Color(0xFF0F0F13),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2 + 0.003 * widget.height),
            child: Row(
              children: [
                SizedBox(width: 22),
                widget.icon != null ?
                Row(
                  children: [
                    widget.icon!(isHover || widget.active),
                    SizedBox(width: 12),
                  ],
                ) : SizedBox(),
                AnimatedSlide(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  offset: isHover || widget.active ? Offset(0.05, 0) : Offset(0, 0),
                  child: Text(
                    '${widget.data.title}',
                    style: GoogleFonts.lato(
                      color: widget.active ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
