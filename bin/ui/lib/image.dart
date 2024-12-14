import 'package:flutter/cupertino.dart';

enum MethyleneImage {
  titleDioxideOnly(
    x24: AssetImage('assets/images/title/dioxide/only/24.png'),
    x56: AssetImage('assets/images/title/dioxide/only/56.png'),
    x86: AssetImage('assets/images/title/dioxide/only/86.png'),
    x124: AssetImage('assets/images/title/dioxide/only/124.png'),
    x226: AssetImage('assets/images/title/dioxide/only/226.png'),
  ),
  logoDioxide(
    x24: AssetImage('assets/images/logo/dioxide/24.png'),
    x56: AssetImage('assets/images/logo/dioxide/56.png'),
    x86: AssetImage('assets/images/logo/dioxide/86.png'),
    x124: AssetImage('assets/images/logo/dioxide/124.png'),
    x226: AssetImage('assets/images/logo/dioxide/226.png'),
  ),
  logoMinimal(
    x24: AssetImage('assets/images/logo/minimal/24.png'),
    x56: AssetImage('assets/images/logo/minimal/56.png'),
    x86: AssetImage('assets/images/logo/minimal/86.png'),
    x124: AssetImage('assets/images/logo/minimal/124.png'),
    x226: AssetImage('assets/images/logo/minimal/226.png'),
  );

  const MethyleneImage({
    required this.x24,
    required this.x56,
    required this.x86,
    required this.x124,
    required this.x226
  });
  final AssetImage x24;
  final AssetImage x56;
  final AssetImage x86;
  final AssetImage x124;
  final AssetImage x226;
  AssetImage getImage(double range) {
    switch (range) {
      case < 24:
        return x24;
      case < 56:
        return x56;
      case < 86:
        return x86;
      case < 124:
        return x124;
    }
    return x226;
  }
}
class SimpleImage extends StatelessWidget {
  final MethyleneImage image;
  final double? height;
  const SimpleImage({super.key, required this.image, this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(builder: (context, constrains) {
        return Image(image: image.getImage(constrains.maxHeight));
      }),
    );
  }
}
class AdjustableImage extends StatelessWidget {
  final MethyleneImage image;
  final double? height;
  final double? width;
  const AdjustableImage({super.key, required this.image, this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(builder: (context, constrains) {
        return Image(image: image.getImage(constrains.maxHeight));
      }),
    );
  }
}