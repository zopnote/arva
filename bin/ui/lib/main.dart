
import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:desktop_scrollbar/desktop_scrollbar.dart';
import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/animated_symbol.dart';
import 'package:ui/logo_animated.dart';
import 'package:ui/outview/outlook.dart';
import 'package:ui/outview/sight.dart';
import 'package:ui/project.dart';
import 'package:ui/side_bar/entry.dart';
import 'package:ui/side_bar/side_bar.dart';
import 'package:ui/title_bar/title_bar.dart';


void main() {
  runApp(const Example());
}
class Example extends StatefulWidget {
  const Example();
  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> with SingleTickerProviderStateMixin {
  late final TabController controller;
  @override
  void initState() {
    controller = TabController(length: 5, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool hover = false;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: const Color(0xFF0F0F13),
            body: Row(
              children: [
                SizedBox(height: 900,
                  width: MediaQuery.sizeOf(context).width/2,
                  child: Sight(outlooks: [
                    Outlook(
                      title: (context, isHover, isSelected, close) {
                        hover = isHover;
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Center(
                              child: Stack(
                                children: [
                                  Text(
                                    'widgets.dart',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 12,
                                        fontFamily: 'segoe_ui',
                                        overflow: TextOverflow.ellipsis,
                                        color: isSelected ? Colors.white : Colors.white70
                                    ),
                                  ),
                                ],
                              )
                          ),
                        );
                      },
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              width: 350,
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  'w Editor',
                                  style: GoogleFonts.kanit(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                    height: 900,
                    width: MediaQuery.sizeOf(context).width/2,
                    child: Sight(
                      outlooks: [
                        Outlook(
                          title: (context, isHover, isSelected, close) {
                            hover = isHover;
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                  child: Stack(
                                    children: [
                                      Text(
                                        'main.dart',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100,
                                            fontSize: 12,
                                            fontFamily: 'segoe_ui',
                                            overflow: TextOverflow.ellipsis,
                                            color: isSelected ? Colors.white : Colors.white70
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            );
                          },
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 30),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: SizedBox(
                                  width: 350,
                                  height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Text(
                                      'Dioxide Editor',
                                      style: GoogleFonts.kanit(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Outlook(
                          title: (context, isHover, isSelected, close) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                  child: Text(
                                    'Tab 2',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 12,
                                        fontFamily: 'segoe_ui',
                                        color: isSelected ? Colors.white : Colors.white70
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )
                              ),
                            );
                          },
                          content: Container(),
                        ),
                        Outlook(
                          title: (context, isHover, isSelected, close) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                  child: Text(
                                    'Tab 3',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 12,
                                        fontFamily: 'segoe_ui',
                                        color: isSelected ? Colors.white : Colors.white70
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )
                              ),
                            );
                          },
                          content: Container(),
                        ),
                        Outlook(
                          title: (context, isHover, isSelected, close) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                  child: Text(
                                    'Tab 4',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 12,
                                        fontFamily: 'segoe_ui',
                                        color: isSelected ? Colors.white : Colors.white70
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )
                              ),
                            );
                          },
                          content: Container(),
                        ),
                        Outlook(
                          title: (context, isHover, isSelected, close) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                  child: Text(
                                    'Tab 5',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 12,
                                        fontFamily: 'segoe_ui',
                                        color: isSelected ? Colors.white : Colors.white70
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )
                              ),
                            );
                          },
                          content: Container(),
                        ),
                      ],
                    )
                ),
              ],
            )
        )
    );
  }
}


class Application extends StatefulWidget {
  const Application();

  @override
  State<Application> createState() => _ApplicationState();
}

bool a = true;
class _ApplicationState extends State<Application> with TickerProviderStateMixin {
  late TabController controller;
  bool play = false;
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        play = true;
      });
    });
    controller = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  static double cappedScale({
    required double width,
    required double factor,
    required double max
  }) {
    return width * factor > max ? max : width * factor;
  }
  static double rangedScale({
    required double width,
    required double increaseOffRange,
    required double increaseInRange,
    required double absoluteStart,
    required double relativeMax
  }) {
    final double offRange = width * increaseOffRange;
    if (offRange < absoluteStart) return 0;
    final double inRange = (offRange - absoluteStart) * increaseInRange;
    print(inRange);
    return inRange < relativeMax ? inRange : relativeMax;
  }
  @override
  Widget build(BuildContext context) {
    final double viewWidth = cappedScale(
        width: MediaQuery.sizeOf(context).width,
        factor: 0.7,
        max: 1300
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Color(0xFF494949),
      home: Scaffold(
        backgroundColor: Color(0xFF0A0A0D),
        appBar: TitleBar(
          color: Colors.black26,
          height: 37,
          right: [
            Example(),
            SizedBox(width: 6),
          ],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: rangedScale(
                          width: MediaQuery.sizeOf(context).width,
                          increaseOffRange: 0.19,
                          increaseInRange: 0.5,
                          absoluteStart: 230,
                          relativeMax: 20
                      ),
                    ),
                    LogoAnimated(play: play),
                  ],
                ),
                Spacer(),
                AnimatedSlide(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  offset: play ? Offset(0, 0) : Offset(-1, 0),
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOutBack,
                    opacity: play ? 1 : double.minPositive,
                    child: UprightTabList(
                      controller: controller,
                      width: 230 + rangedScale(
                          width: MediaQuery.sizeOf(context).width,
                          increaseOffRange: 0.19,
                          increaseInRange: 1,
                          absoluteStart: 230,
                          relativeMax: 40
                      ),
                      height: MediaQuery.sizeOf(context).height-127,
                      entries: [
                        SideTabBarEntry(
                            title: 'HOME',
                            icon: (animate) => AnimatedSymbol(
                              educt: CarbonIcons.home,
                              product: CarbonIcons.list,
                              duration: Duration(milliseconds: 200),
                              animate: animate,
                              color: Colors.white,
                              size: 14,
                            )
                        ),
                        SideTabBarEntry(
                            title: 'INSTALLATION',
                            icon: (animate) => AnimatedSymbol(
                              educt: CarbonIcons.devices,
                              product: CarbonIcons.tools,
                              duration: Duration(milliseconds: 200),
                              animate: animate,
                              color: Colors.white,
                              size: 14,
                            )
                        ),
                        SideTabBarEntry(
                            title: 'STORE',
                            icon: (animate) => AnimatedSymbol(
                              educt: CarbonIcons.cube,
                              product: CarbonIcons.shopping_bag,
                              duration: Duration(milliseconds: 200),
                              animate: animate,
                              color: Colors.white,
                              size: 14,
                            )
                        ),
                        SideTabBarEntry(
                            title: 'DOCUMENTATION',
                            icon: (animate) => AnimatedSymbol(
                              educt: CarbonIcons.bookmark,
                              product: CarbonIcons.bookmark_filled,
                              duration: Duration(milliseconds: 100),
                              animate: animate,
                              color: Colors.white,
                              size: 14,
                            )
                        ),
                      ],
                      bottomWidget: bottomBox,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              width: viewWidth,
              child: Column(
                children: [
                  SizedBox(height: 25,),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: play ? 1 : 0.0000001,
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              color: const Color(0xFF0F0F13)
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          height: 50,
                          width: 280,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              color: const Color(0xFF0F0F13)
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedSlide(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    offset: play ? Offset(0, 0) : Offset(0, 1),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height-37-75,
                      child: TabBarView(
                          controller: controller,
                          children: [
                            ListView(
                              children: [
                                SizedBox(height: 35,),
                              ],
                            ),
                            ListView(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: viewWidth*0.50,
                                      width: viewWidth*0.50,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ListView(
                              children: [
                                SizedBox(height: 35,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Container(
                                        height: viewWidth*0.35,
                                        width: viewWidth*0.42,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Container(
                                        height: viewWidth*0.35,
                                        width: viewWidth*0.42,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ListView(
                              children: [
                                SizedBox(height: 35,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Container(
                                        height: viewWidth*0.35,
                                        width: viewWidth*0.42,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Container(
                                        height: viewWidth*0.35,
                                        width: viewWidth*0.42,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
SizedBox bottomBox(context, barHeight, barWidth, cellHeight, surfaceGap, borderRadius) {
  return SizedBox(
    height: barHeight-surfaceGap-220,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 15,),
            AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TyperAnimatedText(
                    'RECENT PROJECTS',
                    speed: Duration(milliseconds: 160),
                    textStyle: GoogleFonts.varelaRound(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12
                    ),
                  )
                ]
            ),
          ],
        ),
        a ? projectList(height: barHeight-surfaceGap-220-80 > 260 ? 260 : barHeight-surfaceGap-220-80, width: barWidth-10) : SizedBox(),
        Spacer(),
        SideTabBarEntry(
            title: 'DOWNLOADS',
            icon: (animate) => AnimatedSymbol(
              educt: CarbonIcons.download,
              product: CarbonIcons.arrow_down,
              duration: Duration(milliseconds: 100),
              animate: animate,
              color: Colors.white,
              size: 16,
            )
        ).widget(
            context,
            height: cellHeight,
            width: barWidth,
            active: false,
            index: 0
        ),
        SizedBox(height: 8,)
      ],
    ),
  );
}
Widget projectList({required double height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
    child: DynMouseScroll(
      builder: (context, controller, physics) {
        return DesktopScrollbar(
          thumbVisibility: false,
          controller: controller,
          radius: Radius.circular(3),
          thickness: 3,
          child: ListView(
            physics: physics,
            controller: controller,
            children: [
              SizedBox(height: 5,),
              Row(
                children: [
                  SizedBox(width: 8,),
                  Project(),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  SizedBox(width: 8,),
                  Project(),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  SizedBox(width: 8,),
                  Project(),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  SizedBox(width: 8,),
                  Project(),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  SizedBox(width: 8,),
                  Project(),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}
