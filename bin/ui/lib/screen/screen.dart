
import 'package:flutter/material.dart';
import 'package:ui/screen/screen_data.dart';

typedef ScreenDropCallback = void Function(ScreenData screenData);

class Screen extends StatefulWidget {
  const Screen({
    super.key,
    required this.title,
    required this.child,
    this.symbol,
    this.onDragged,
  });
  final ScreenDropCallback? onDragged;
  final String title;
  final Widget child;
  final Widget? symbol;
  ScreenData get data => ScreenData(
      title,
      child: child,
  );
  factory Screen.from(
      ScreenData data, {
        ScreenDropCallback? onDragged
      }) => Screen(
    title: data.title,
    child: data.child,
    onDragged: onDragged,
  );

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => setState(() {}),
      child: Draggable<Screen>(
        data: widget,
        feedback: dragging(context),
        childWhenDragging: const SizedBox(),
        child: content(context),
      ),
    );
  }
  
  Widget content(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        hover = true;
      }),
      onExit: (_) => setState(() {
        hover = false;
      }),
      child: unselected(context),
    );
  }

  Widget selected(BuildContext context) {
    List<Widget> row = [];
    if (widget.symbol != null) row.add(widget.symbol!);
    row.add(
      Text(
        widget.title,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11,
            color: Colors.white
        ),
      ),
    );
    row.add(
        const Icon(
          Icons.close,
          color: Colors.white,
          size: 11,
        )
    );
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          topLeft: Radius.circular(5)
        ),
        color: Color(0xFF606060)
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: row,
        ),
      ),
    );
  }

  Widget unselected(BuildContext context) {
    List<Widget> row = [];
    if (widget.symbol != null) row.add(widget.symbol!);
    row.add(
      Text(
        widget.title,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11,
            color: Colors.white
        ),
      ),
    );
    row.add(
        const Icon(
          Icons.close,
          color: Colors.white,
          size: 11,
        )
    );
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
        });
      },
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: hover ? const Color(0x66FFFFFF)
                    : Colors.transparent
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: row,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dragging(BuildContext context) {
    List<Widget> row = [];
    if (widget.symbol != null) row.add(widget.symbol!);
    row.add(
      Text(
        widget.title,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11,
            color: Colors.white
        ),
      ),
    );
    row.add(
        const Icon(
          Icons.close,
          color: Colors.white,
          size: 11,
        )
    );
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              color: const Color(0x30FFFFFF)
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: row,
            ),
          ),
        ),
      ),
    );
  }
}