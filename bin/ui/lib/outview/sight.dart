
import 'package:flutter/material.dart';
import 'package:ui/outview/outlook.dart';
import 'package:ui/outview/tab_button.dart';

/// [Sight] is a widget that displays a row of tabs and their content in a viewport.
///
/// Each tab represents an [Outlook] with a title and content.
/// The widget also manages the
/// selection ([changeOutlook]),
/// removal ([removeOutlook]),
/// and addition ([addOutlook]) of tabs.
class Sight extends StatefulWidget {

  /// Minimum width of the entire widget.
  ///
  /// If the available space is smaller than [minWidth],
  /// the widget will no longer shrink.
  final double minWidth;

  /// Minimum width for each tab button.
  ///
  /// If the available space is smaller than [minButtonWidth]
  /// the tab button width will no longer shrink.
  final double minButtonWidth;

  /// Maximum width for each tab button.
  ///
  /// If the available space is greater than [maxButtonWidth],
  /// the tab button width will no longer expand.
  final double maxButtonWidth;

  /// Height of the row and their tab buttons.
  final double tabPanelHeight;

  /// Background color of the entire widget (excluding the tabs).
  final Color background;

  /// Background color of the row containing the tab buttons.
  final Color rowBackground;

  /// Color for unselected tabs.
  final Color colorUnselected;

  /// Color for the currently selected tab.
  final Color colorSelected;

  /// Color for the borders of the tabs.
  final Color colorBorder;

  /// Width of the border around each tab.
  final double borderWidth;

  /// [Color] used for all accents such as drop spot or selection in the workspace.
  final Color? accentColor;
  
  /// A list of [Outlook] objects that define the initial tabs in the widget.
  final List<Outlook> outlooks;

  late final UniqueKey panelKey;

  Sight({
    super.key,
    this.minWidth = 300,
    this.minButtonWidth = 85,
    this.maxButtonWidth = 265,
    this.tabPanelHeight = 30,
    this.background = const Color(0xFF18181E),
    this.colorSelected = const Color(0xFF18181E),
    this.colorUnselected = const Color(0xFF0F0F13),
    this.rowBackground = const Color(0xFF0F0F13),
    this.colorBorder = const Color(0xFF07070A),
    this.accentColor,
    this.borderWidth = 1,
    required this.outlooks,
  }) {
    panelKey = UniqueKey();
  }
  @override
  State<Sight> createState() => _SightState();
}
class _SightState extends State<Sight> with TickerProviderStateMixin {

  /// The list of outlooks currently displayed in this state as tabs in the widget.
  List<OutlookTab> outlooks = [];

  /// Index of the currently selected tab in this state.
  late int selectedIndex;



  @override
  void initState() {
    selectedIndex = 0;

    for (int index = 0; index < widget.outlooks.length; index++) {
      outlooks.add(
        OutlookTab(
            title: widget.outlooks[index].title,
            content: widget.outlooks[index].content,
            lastIndex: index,
            lastLength: widget.outlooks.length,
          lastPanel: widget.panelKey
        ));
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, possibleConstrains) {
        
        double extendedTotalSightSize = possibleConstrains.maxWidth;
        double tabButtonWidth = extendedTotalSightSize / outlooks.length;

        final bool tabPanelOversized = tabButtonWidth > widget.maxButtonWidth;
        if (possibleConstrains.maxWidth < widget.minWidth)
          extendedTotalSightSize = widget.minWidth;

        if (tabButtonWidth < widget.minButtonWidth)
          tabButtonWidth = widget.minButtonWidth;
        else if (tabPanelOversized) tabButtonWidth = widget.maxButtonWidth;
        
        final List<Widget> tabButtons = [];

        for (int index = 0; index < outlooks.length; index++) {
          tabButtons.add(
              buildButton(
                  index: index,
                  width: tabButtonWidth,
                  oversized: tabPanelOversized,
                  outlook: outlooks[index]
              )
          );
        }

        if (tabPanelOversized) tabButtons.add(
            panelOversizeExtender(
                possibleConstrains.maxWidth -
                    (tabButtonWidth * outlooks.length)
            )
        );

        Widget? viewPortWidget;
        if (outlooks.isNotEmpty) {
          if (selectedIndex > outlooks.length-1) {
            selectedIndex = outlooks.length-1;
          }
          viewPortWidget = outlooks[selectedIndex].content;
        }

        
        return Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: extendedTotalSightSize,
              height: possibleConstrains.maxHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tabPanel(tabButtons),
                  viewPort(possibleConstrains, extendedTotalSightSize, viewPortWidget),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  

  Widget tabPanel(List<Widget> tabButtons) {
    return Container(
        color: widget.rowBackground,
        height: widget.tabPanelHeight,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: tabButtons,
          ),
        )
    );
  }
  
  Widget viewPort(
      BoxConstraints possibleConstrains, 
      double viewPortWidth,
      Widget? viewPortContent
      ) {
    return Container(
      color: widget.background,
      height: possibleConstrains.maxHeight - widget.tabPanelHeight,
      width: viewPortWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: viewPortContent,
      ),
    );
  }


  /// Creates a placeholder for empty space when the tabs are oversized.
  /// This widget also receive drag requests and add them to the end of [outlooks].
  Widget panelOversizeExtender(double extantWidth) {
    return DragTarget<OutlookTab>(

      builder: (context, candidateData, rejectedData) {
        return Container(
            height: widget.tabPanelHeight,
            width: extantWidth,
            decoration: BoxDecoration(
                color: candidateData.isNotEmpty ?
                Colors.white.withOpacity(0.1) : Colors.transparent,
                border: Border(
                    bottom: BorderSide(
                        color: widget.colorBorder,
                        width: widget.borderWidth
                    )
                )
            )
        );
      },
      onAcceptWithDetails: (details) {
        final int afterTheLastItem = outlooks.length;
        addOutlook(details.data, widget.panelKey, afterTheLastItem, false);
      },
    );
  }



  /// Builds a draggable button representing a single tab.
  SightViewButton buildButton({
    required final int index,
    required final double width,
    required final bool oversized,
    required final OutlookTab outlook
  }) {

    bool selected = index == selectedIndex;
    bool leftBorder = index > selectedIndex;
    bool rightBorder = index < selectedIndex;

    if (!rightBorder)
      rightBorder = index == outlooks.length - 1 && oversized;

    return SightViewButton(
      outlook,

      listLength: outlooks.length,
      borderWidth: widget.borderWidth,
      height: widget.tabPanelHeight,

      index: index,
      isSelected: selected,
      width: width,

      functions: TabButtonFunctions(
          close: () => removeOutlook(outlook),
          setSelected: setSelected,
          addOutlook: addOutlook,
          removeOutlook: removeOutlook
      ),

      paint: TabButtonPaint(
          accentColor: widget.accentColor,
          selected: widget.colorSelected,
          unselected: widget.colorUnselected,
          border: widget.colorBorder,
          borderLeft: leftBorder,
          borderRight: rightBorder
      ),

    );
  }


  /// Replaces the current list of [this.outlooks] tabs
  /// with a new list [outlooks] and triggers a re-render of the widget.
  void changeOutlook(List<OutlookTab> outlooks) => setState(() {
    this.outlooks = outlooks;
  });

  /// Changes the selected tab of this [Sight].
  void setSelected(OutlookTab outlook) => setState(() {
    selectedIndex = outlooks.indexOf(outlook);
  });



  /// Removes the specified tab from the list of tabs. ([outlooks])
  void removeOutlook(OutlookTab outlook) => setState(() {
    outlooks.remove(outlook);
  });



  /// Adds a new tab at the specified position in the list.
  ///
  /// [before] determines if the new tab should be added before or after the given index.
  /// If the [deployIndex] is greater than [outlooks.length]
  /// the tab will be added at the end of the new array.
  void addOutlook(OutlookTab outlook, UniqueKey panelKey, int deployIndex, bool before) {
    List<OutlookTab> newOutlooks = [];

    for (int index = 0; index < this.outlooks.length; index++) {

      outlook.lastLength = this.outlooks.length;
      outlook.lastPanel = panelKey;

      if (index == deployIndex && before) newOutlooks.add(outlook);

      newOutlooks.add(this.outlooks[index]);

      if (index == deployIndex && !before) newOutlooks.add(outlook);
    }

    if (deployIndex > this.outlooks.length-1) newOutlooks.add(outlook);

    this.changeOutlook(newOutlooks);
  }
}
