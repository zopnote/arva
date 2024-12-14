import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Project extends StatefulWidget {
  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  OverlayEntry? _overlayEntry;
  Offset _position = Offset.zero;
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHover = true;
      }),
      onExit: (_) => setState(() {
        isHover = false;
      }),
      child: Listener(
        onPointerDown: (PointerDownEvent event) {
          if (event.kind == PointerDeviceKind.mouse) {
            _position = event.position;
            _showOverlay(context);
          }
        },
        child: Container(
          height: 60,
          width: 200,
          decoration: BoxDecoration(
              color: isHover ? Colors.black38 : null,
              borderRadius: BorderRadius.all(Radius.circular(6))
          ),
          child: AnimatedSlide(
            duration: Duration(milliseconds: 200),
            offset: isHover ? Offset(0.08, 0) : Offset(0.04, 0),
            child: Row(
              children: [
                Stack(
                  children: [
                    AnimatedScale(
                      scale: isHover ? 0.4 : 0,
                      duration: Duration(milliseconds: 100),
                      child: Container(
                        width: 43,
                        height: 43,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.6),
                              blurRadius: 30,
                              spreadRadius: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedScale(
                      scale: isHover ? 1.1 : 1,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        height: 43,
                        width: 43,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                CupertinoColors.activeBlue,
                                Colors.purple
                              ],
                              begin: Alignment(-1, -1),
                              end: Alignment(1, 1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20,),
                Stack(
                  children: [
                    AnimatedSlide(
                      duration: Duration(milliseconds: 200),
                      offset: isHover ? Offset(0, -0.5) : Offset(0, 0),
                      child: Text(
                        'Deep ulcer',
                        style: GoogleFonts.varelaRound(
                            fontSize: 14,
                            fontWeight: isHover ? FontWeight.bold : FontWeight.w500,
                            color: Colors.white
                        ),
                      ),
                    ),
                    AnimatedSlide(
                      duration: Duration(milliseconds: 200),
                      offset: isHover ? Offset(0, 0.5) : Offset(0, 0),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: isHover ? 1 : 0.00001,
                        child: Text(
                          'Engine v1.4',
                          style: GoogleFonts.varelaRound(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showOverlay(BuildContext context) {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: _position.dy,
        left: _position.dx,
        child: _buildOverlayContent(),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildOverlayContent() {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: _removeOverlay, // Entfernt das Overlay bei Klick
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Text('Overlay-Dialog!'),
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}