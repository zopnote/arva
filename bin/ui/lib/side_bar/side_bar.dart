import 'package:flutter/material.dart';

import 'package:ui/side_bar/entry.dart';

typedef SizedBoxCallback = SizedBox Function(BuildContext context, double height, double width, double cellHeight, double surfaceGap, double borderRadius);
final class UprightTabList extends StatefulWidget {
  final List<SideTabBarEntry> entries;
  final TabController controller;
  final double height;
  final double width;
  final double cellHeight;
  final double borderRadius;
  final double surfaceGap;
  final Color backgroundColor;
  final SizedBoxCallback? bottomWidget;
  const UprightTabList({
    super.key,
    required this.entries,
    required this.controller,
    required this.height,
    required this.width,
    this.bottomWidget,
    this.borderRadius = 6,
    this.backgroundColor = const Color(0xFF0F0F13),
    this.surfaceGap = 20,
    this.cellHeight = 45,
  });
  @override
  State<UprightTabList> createState() => _UprightTabListState();
}
final class _UprightTabListState extends State<UprightTabList> {
  @override
  void initState() {
    widget.controller.addListener(() => setState(() {}));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final SizedBox? bottomBox = widget.bottomWidget != null ?
    widget.bottomWidget!(
      context,
        widget.height,
        widget.width,
        widget.cellHeight,
        widget.surfaceGap,
        widget.borderRadius
    ) : null;
    final double bottomBoxHeight = bottomBox?.height != null ?
    bottomBox!.height! : 0;
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(widget.borderRadius),
          bottomRight: Radius.circular(widget.borderRadius)
        ),
        color: widget.backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: widget.surfaceGap),
          SizedBox(
            height: widget.height-widget.surfaceGap-bottomBoxHeight,
            child: ListView.builder(
              itemCount: widget.entries.length,
              itemBuilder: (context, entryIndex) {
                return widget.entries[entryIndex].widget(
                  context,
                    height: widget.cellHeight,
                    width: widget.width,
                  active: entryIndex == widget.controller.index,
                  index: entryIndex,
                  controller: widget.controller,
                );
              },
            ),
          ),
          Spacer(),
        ]..add(bottomBox != null ? bottomBox : SizedBox()),
      ),
    );
  }
}