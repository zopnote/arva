import 'package:flutter/cupertino.dart';
import 'package:ui/image.dart';

class LogoAnimated extends StatefulWidget {
  final bool play;

  const LogoAnimated({super.key, required this.play});
  @override
  State<StatefulWidget> createState() => _LogoAnimatedState();

}
class _LogoAnimatedState extends State<LogoAnimated> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 230,
      child: Stack(
        children: [
          Positioned(
            left: 61,
              top: 38,
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutBack,
                  opacity: widget.play ? 1 : 0.00001,
                  child: SimpleImage(image: MethyleneImage.titleDioxideOnly, height: 26))
          ),
          AnimatedSlide(
              offset: widget.play? Offset(0.58, 0.37) : Offset(1.2, -0.3),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutBack,
                opacity: widget.play ? 1 : 0.00001,
                child: SimpleImage(image: MethyleneImage.logoDioxide, height: 50),
              )
          ),
        ],
      ),
    );
  }

}