
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui/outview/outlook.dart';

/// [TabButtonPaint] holds the styling information for the tab buttons.
///
/// It defines the [Colors] and the presence of borders for each tab.
class TabButtonPaint {

  /// Color used for the selected tab.
  final Color selected;

  /// Color used for unselected tabs.
  final Color unselected;

  /// Color for the borders of the tabs.
  final Color border;

  /// Whether to show a left border for the tab.
  final bool borderLeft;

  /// Whether to show a right border for the tab.
  final bool borderRight;

  /// [Color] used for all accents such as drop spot or selection in the workspace.
  final Color? accentColor;

  TabButtonPaint({
    required this.selected,
    required this.unselected,
    required this.border,
    required this.borderLeft,
    required this.borderRight,
    this.accentColor
  });
}

/// [TabButtonFunctions] provides the actions that can be performed on a tab.
///
/// This includes closing a tab, adding a new one, removing a tab,
/// and setting a tab as selected.
class TabButtonFunctions {

  /// Function to close the tab from inside an [OutlookTitleWidget].
  final void Function() close;

  /// Function to add an [OutlookTab] at a specified index to the tab panel.
  ///
  /// Used by the drag and drop mechanism.
  final void Function(OutlookTab outlook, UniqueKey panelKey, int deployIndex, bool before) addOutlook;

  /// Function to remove an [OutlookTab] from the tab panel.
  ///
  /// Used by the drag and drop mechanism.
  final void Function(OutlookTab outlook) removeOutlook;

  /// Function to set an [OutlookTab] as selected in the [Sight] this button belongs to.
  final void Function(OutlookTab outlook) setSelected;

  TabButtonFunctions({
    required this.setSelected,
    required this.addOutlook,
    required this.removeOutlook,
    required this.close
  });

}

/// SightViewButton represents the UI-button for a single [OutlookTab] in the [Sight] widget.
///
/// It provides the structure for such a button, defined as an [Outlook] of the program.
/// Each button is a [Draggable] and a [DragTarget]
/// so consider the instances if making changes to the source.
class SightViewButton extends StatefulWidget {

  /// Index of this [OutlookTab] in the list of [OutlookTab]s in the [Sight] widget.
  final int index;

  /// Length of the list of [OutlookTab]s in the [Sight] widget, in this state.
  final int listLength;

  /// Whether this tab is selected in the list of [OutlookTab]s in the [Sight] widget.
  final bool isSelected;

  /// The [OutlookTab] that this tab represents.
  final OutlookTab outlook;

  /// Final width of the tab button.
  final double width;

  /// Final height of the tab button.
  final double height;

  /// Width of the border around the tab button if active.
  final double borderWidth;

  /// The paint settings for the tab button (colors and borders).
  final TabButtonPaint paint;

  /// The set of functions for interacting with the tab (e.g., close, select).
  final TabButtonFunctions functions;

  const SightViewButton(
      this.outlook,
      {
        required this.borderWidth,
        required this.height,
        required this.index,
        required this.isSelected,
        required this.width,
        required this.paint,
        required this.functions,
        required this.listLength,
      });

  @override
  State<SightViewButton> createState() => _SightViewButtonState();
}

class _SightViewButtonState extends State<SightViewButton> {

  /// Indicates whether the tab button is being hovered, influence only if not dragged.
  bool isHover = false;

  @override
  Widget build(BuildContext context) {

    BorderSide coloredBorder = BorderSide(
        color: widget.paint.border,
        width: widget.borderWidth
    );

    BorderSide transparentBorder = BorderSide(
        width: widget.borderWidth,
        color: Colors.transparent
    );

    Border border = Border(
      bottom: widget.isSelected ? transparentBorder : coloredBorder,
      left: widget.paint.borderLeft ? coloredBorder : transparentBorder,
      right: widget.paint.borderRight ? coloredBorder : transparentBorder,
    );

    Widget titleWidget = Center(
      child: widget.outlook.title(
        context,
        isHover,
        widget.isSelected,
        widget.functions.close,
      ),
    );

    return Stack(
      children: [
        Draggable<OutlookTab>(
          data: widget.outlook,
          childWhenDragging: childWhileDragging(title: titleWidget, border: border),
          feedback: draggedChild(title: titleWidget),
          child: defaultChild(title: titleWidget, border: border),
          onDragCompleted: () {
            widget.functions.removeOutlook(widget.outlook);
            trigger();
          },
        ),

        DragTarget<OutlookTab>(
          builder: (context, candidateData, rejectedData) => landingSpotWidget(context, candidateData, rejectedData, true),
          onWillAcceptWithDetails: isPositionValid,
          onAcceptWithDetails: (details) => addAtDeterminedPosition(details, true),
        ),

        Positioned(
          left: widget.width/2,
          child: DragTarget<OutlookTab>(
            builder: (context, candidateData, rejectedData) => landingSpotWidget(context, candidateData, rejectedData, false),
            onWillAcceptWithDetails: isPositionValid,
            onAcceptWithDetails: (details) => addAtDeterminedPosition(details, false),
          ),
        )

      ],
    );
  }



  /// Returns a widget representing the landing spot when a tab is being dragged over for accessibility.
  Widget landingSpotWidget(BuildContext context, List<OutlookTab?> candidateData, List<dynamic> rejectedData, bool before) {
    bool shine = false;
    for (OutlookTab? entry in candidateData) {
      if (entry != null) {
        if (entry != widget.outlook) {
          shine = candidateData.isNotEmpty;
        }
      }
    }
    if (shine) {
      return Container(
        width: widget.width/2,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          border: Border(
            right: before ?
            BorderSide.none :
            widget.paint.accentColor != null ? BorderSide(
              width: widget.borderWidth*4,
              color: widget.paint.accentColor!
            ) :
            BorderSide.none,
              left: before ? widget.paint.accentColor != null ? BorderSide(
              color: widget.paint.accentColor!,
              width: widget.borderWidth*4
            ) : BorderSide.none : BorderSide.none
          ),
          borderRadius: BorderRadius.only(
          )
        ),
      );
    }
    return SizedBox(
      width: widget.width/2,
      height: widget.height,
    );
  }



  /// Returns the widget for the default visual state of the tab button.
  Widget defaultChild({
    required final Widget title,
    required final Border border
  }) {
    return MouseRegion(
      onEnter: (_) => setHover(true),
      onExit: (_) => setHover(false),
      child: GestureDetector(
        onTapUp: onClick,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              color: widget.isSelected ? widget.paint.selected : widget.paint.unselected,
              border: border
          ),
          child: title,
        ),
      ),
    );
  }



  /// Returns a widget that represents the tab as a dragged item.
  Widget draggedChild({
    required final Widget title
  }) {
    return Opacity(
      opacity: 0.7,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: widget.width,
          height: widget.height,
          color: widget.paint.unselected,
          child: title,
        ),
      ),
    );
  }



  /// Returns the widget that represents the tab while it is being dragged on the default position.
  Widget childWhileDragging({
    required final Widget title,
    required final Border border
  }) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: widget.isSelected ? widget.paint.selected : widget.paint.unselected,
            border: Border(
                top: border.top,
                left: border.left,
                right: border.right,
                bottom: BorderSide(
                    color: widget.paint.border,
                    width: widget.borderWidth
                )
            )
        ),
        child: title,
      ),
    );
  }



  /// Checks if the dragged tab can be placed at the current [DragTarget].
  bool isPositionValid(DragTargetDetails<OutlookTab> details) => details.data != widget.outlook;



  /// Static notifier that insure the adding of a widget is done after its removal.
  static ValueNotifier<bool> _trigger = ValueNotifier(false);

  /// Waits for the [_trigger] to complete before continuing with the drag event.
  ///
  /// The [_trigger] will trigger if any tab of any instance is removed.
  Future<void> waitUntilTrigger() async {

    if (_trigger.value == true) return;

    Completer<void> completer = Completer();
    void listener() {
      if (_trigger.value == true) {
        completer.complete();
        _trigger.removeListener(listener);
      }
    }

    _trigger.addListener(listener);
    return completer.future;
  }


  /// Triggers the static notifier once and deactivate it directly.
  void trigger() {
    _trigger.value = true;
    _trigger.value = false;
  }



  /// Determines a relative position that was intended by the user and inserts the tab there.
  Future<void> addAtDeterminedPosition(DragTargetDetails<OutlookTab> details, bool before) async {
    await waitUntilTrigger();

    // Case 1: The tab comes from another panel
    if (details.data.lastPanel != widget.outlook.lastPanel) {
      details.data.lastIndex = widget.index;
      widget.functions.addOutlook(details.data, widget.outlook.lastPanel, widget.index, before);
      return;
    }

    // Case 2: The tab comes from the same panel but was in an earlier position
    if (details.data.lastIndex < widget.index) {
      details.data.lastIndex = widget.index - 1;
      widget.functions.addOutlook(details.data, widget.outlook.lastPanel, widget.index - 1, before);
      return;
    }

    // Case 3: The tab comes from the same panel and was in a later position or is in the same position
    details.data.lastIndex = widget.index;
    widget.functions.addOutlook(details.data, widget.outlook.lastPanel, widget.index, before);
  }



  /// Updates the hover state for the tab button.
  void setHover(bool isHover) => setState(() {
    this.isHover = isHover;
  });



  /// Handles click events on the tab button, setting the tab as selected if needed.
  void onClick(details) {
    if (widget.isSelected) return;
    widget.functions.setSelected(widget.outlook);
  }
}
