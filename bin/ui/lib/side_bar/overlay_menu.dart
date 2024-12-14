import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlayMenu(
      width: 245,
      button: (Widget overlayEntry) {
        return Container(
          width: 45,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Color(0xFF1A1A1F),
          ),
          child: Row(
            children: [
              SizedBox(width: 7,),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
              ),
              SizedBox(width: 7,),
              Icon(
                Icons.expand_more_rounded,
                color: Colors.white,
                size: 17,
              ),
              overlayEntry,
            ],
          ),
        );
      },
      portal: OverlayMenuPortal(
              (width) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 18,
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(30))
                          ),
                        ),
                        SizedBox(
                          width: width * 0.1,
                        ),
                        Text(
                          'Zopnote',
                          style: GoogleFonts.varelaRound(
                              color: Colors.white,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 5,),
              ],
            );
          }, height: 200,
        rightDisplacement: 106,
        topDisplacement: 15
      ),
      borderRadius: 4,
      color: Color(0xFF1A1A1F),
    );
  }
}


typedef OverlayMenuButton = Widget Function(Widget overlayEntry);

typedef OverlayMenuPortalWidget = Widget Function(double width);

final class OverlayMenuPortal {
  final double? topDisplacement;
  final double? bottomDisplacement;
  final double? rightDisplacement;
  final double? leftDisplacement;
  final double height;
  final OverlayMenuPortalWidget? content;
  OverlayMenuPortal(
      this.content,
      {
        this.topDisplacement,
        this.bottomDisplacement,
        this.leftDisplacement,
        this.rightDisplacement,
        this.height = 200
      });
}

final class OverlayMenu extends StatefulWidget {
  final double width;
  final double borderRadius;
  final Color color;
  final OverlayMenuButton button;
  final OverlayMenuPortal portal;

  const OverlayMenu({
    super.key,
    this.width = 160,
    required this.button,
    this.color = const Color(0xFF1A1A1F),
    required this.portal,
    this.borderRadius = 4,
  });

  @override
  State<OverlayMenu> createState() => _OverlayMenuState();
}

final class _OverlayMenuState extends State<OverlayMenu> {

  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    OverlayPortalController _overlayController = OverlayPortalController();
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          expanded = !expanded;
        });
        _overlayController.toggle();
      },
      child: expanded ? _expanded(_overlayController) : widget.button(_overlay(_overlayController)),
    );
  }

  Widget _expanded(OverlayPortalController controller) {
    return Container(
      width: widget.width,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(widget.borderRadius),
          topLeft: Radius.circular(widget.borderRadius)
        ),
        color: widget.color,
      ),
      child: Row(
        children: [
          _overlay(controller),
        ],
      ),
    );
  }

  Widget _overlay(OverlayPortalController controller) {
    return OverlayPortal(controller: controller, overlayChildBuilder: (context) {
      OverlayMenuPortalWidget? builder = widget.portal.content;
      Widget? content;
      if (builder != null) content = builder(widget.width);
      return Positioned(
        right: widget.portal.rightDisplacement,
        top: widget.portal.topDisplacement,
        left: widget.portal.leftDisplacement,
        bottom: widget.portal.bottomDisplacement,
        child: MouseRegion(
          onExit: (_) {
              setState(() {
                expanded = false;
              });
            controller.hide();
          },
          child: Container(
            width: widget.width,
            height: widget.portal.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(widget.borderRadius),
                bottomLeft: Radius.circular(widget.borderRadius)
              ),
              color: widget.color,
            ),
            child: content,
          ),
        ),
      );
    });
  }
}
