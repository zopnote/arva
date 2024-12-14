import 'package:flutter/material.dart';

typedef AnimatedSymbolCallback = AnimatedSymbol Function(bool animate);

class AnimatedSymbol extends StatefulWidget {
  final IconData educt;
  final IconData product;
  final Duration duration;
  final Curve curve;
  final Color color;
  final double size;
  final bool animate;

  const AnimatedSymbol({
    super.key,
    required this.educt,
    required this.product,
    required this.duration,
    this.curve = Curves.linear,
    this.color = Colors.black,
    this.size = 13,
    required this.animate
  });
  @override
  State<AnimatedSymbol> createState() => _AnimatedSymbolState();
}

class _AnimatedSymbolState extends State<AnimatedSymbol> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedScale(
          scale: widget.animate ? 0 : 1,
          duration: widget.duration,
          curve: widget.curve,
          child: Icon(
            widget.educt,
            color: widget.color,
            size: widget.size,
          ),
        ),
        AnimatedScale(
          scale: widget.animate ? 1 : 0,
          duration: widget.duration,
          curve: widget.curve,
          child: Icon(
            widget.product,
            color: widget.color,
            size: widget.size,
          ),
        )
      ],
    );
  }
}
