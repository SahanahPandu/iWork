import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

//import files
import '../../../config/config.dart';
import '../../../config/palette.dart';
import '../../../utils/device/sizes.dart';

class ExpandCollapseHeader extends StatefulWidget {
  @override
  ExpandCollapseHeaderState createState() => ExpandCollapseHeaderState();

  final Widget? leading;
  final Widget title;
  final bool centerTitle;
  final List<Widget>? actions;
  final bool alwaysShowLeadingAndAction;
  final bool alwaysShowTitle;
  final Widget? drawer;
  final double headerExpandedHeight;
  final Widget headerWidget;
  final Widget? headerBottomBar;
  final Color? backgroundColor;
  final Color? appBarColor;
  final double curvedBodyRadius;
  final List<Widget> body;
  final bool fullyStretchable;
  final double stretchTriggerOffset;
  final Widget? expandedBody;
  final double stretchMaxHeight;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final Widget? fixedTitle;
  final double? fixedTitleHeight;
  final double? collapseHeight;
  final double? collapseFade;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final bool collapseButton;

  const ExpandCollapseHeader(
      {Key? key,
      this.leading,
      required this.title,
      this.centerTitle = true,
      this.actions,
      this.alwaysShowLeadingAndAction = false,
      this.alwaysShowTitle = false,
      this.headerExpandedHeight = 0.4,
      required this.headerWidget,
      this.headerBottomBar,
      this.backgroundColor,
      this.appBarColor,
      this.curvedBodyRadius = 28,
      required this.body,
      this.drawer,
      this.fullyStretchable = false,
      this.stretchTriggerOffset = 200,
      this.expandedBody,
      this.stretchMaxHeight = 0.8,
      this.bottomSheet,
      this.fixedTitle,
      this.fixedTitleHeight = 20,
      this.collapseHeight = 120,
      this.collapseFade = 60,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.floatingActionButtonAnimator,
      this.collapseButton = false})
      : assert(headerExpandedHeight > 0.0 &&
            headerExpandedHeight < stretchMaxHeight),
        assert(
          (stretchMaxHeight > headerExpandedHeight) && (stretchMaxHeight < .95),
        ),
        super(key: key);
}

class ExpandCollapseHeaderState extends State<ExpandCollapseHeader> {
  final BehaviorSubject<bool> isFullyExpanded =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> isFullyCollapsed =
      BehaviorSubject<bool>.seeded(false);
  late ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (widget.collapseButton) {
      _showButton();
    } else {}
    super.initState();
  }

  @override
  void dispose() {
    isFullyExpanded.close();
    isFullyCollapsed.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _showButton() {
    /// controller checks offset to show/hide/move button
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 32) {
            /// hide/move report button
            button.value = false;
          } else {
            /// show report button
            button.value = true;
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight =
        AppBar().preferredSize.height + widget.curvedBodyRadius;

    final double topPadding = MediaQuery.of(context).padding.top;

    final double expandedHeight =
        Sizes().screenHeight(context) * widget.headerExpandedHeight;

    final double fullyExpandedHeight =
        Sizes().screenHeight(context) * (widget.stretchMaxHeight);

    return Scaffold(
      backgroundColor:
          widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      drawer: widget.drawer,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.axis == Axis.vertical) {
            // isFullyCollapsed
            if ((isFullyExpanded.value) &&
                notification.metrics.extentBefore > 100) {
              isFullyExpanded.add(false);
            }
            //isFullyCollapsed
            if (notification.metrics.extentBefore >
                expandedHeight -
                    AppBar().preferredSize.height -
                    widget.collapseFade!) {
              if (!(isFullyCollapsed.value)) {
                isFullyCollapsed.add(true);
              }
            } else {
              if ((isFullyCollapsed.value)) {
                isFullyCollapsed.add(false);
              }
            }
          }
          return false;
        },
        child: _sliver(context, appBarHeight, fullyExpandedHeight,
            expandedHeight, topPadding),
      ),
      bottomSheet: widget.bottomSheet,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
    );
  }

  CustomScrollView _sliver(
    BuildContext context,
    double appBarHeight,
    double fullyExpandedHeight,
    double expandedHeight,
    double topPadding,
  ) {
    return CustomScrollView(
      controller: _scrollController,
      //physics: const BouncingScrollPhysics(),
      slivers: [
        StreamBuilder<List<bool>>(
          stream: CombineLatestStream.list<bool>([
            isFullyCollapsed.stream,
            isFullyExpanded.stream,
          ]),
          builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
            final List<bool> streams = (snapshot.data ?? [false, false]);
            final bool fullyCollapsed = streams[0];
            final bool fullyExpanded = streams[1];

            return SliverAppBar(
              backgroundColor:
                  !fullyCollapsed ? widget.backgroundColor : widget.appBarColor,
              automaticallyImplyLeading: false,
              leading: widget.alwaysShowLeadingAndAction
                  ? widget.leading
                  : !fullyCollapsed
                      ? widget.leading
                      : widget.leading,
              actions: widget.alwaysShowLeadingAndAction
                  ? widget.actions
                  : !fullyCollapsed
                      ? []
                      : widget.actions,
              elevation: 0,
              pinned: true,
              stretch: true,
              centerTitle: widget.centerTitle,
              title: widget.alwaysShowTitle
                  ? widget.title
                  : AnimatedOpacity(
                      curve: Curves.easeIn,
                      opacity: fullyCollapsed ? 1 : 0,
                      duration: const Duration(milliseconds: 100),
                      child: widget.title,
                    ),
              collapsedHeight: widget.collapseHeight,
              expandedHeight:
                  fullyExpanded ? fullyExpandedHeight : expandedHeight,
              flexibleSpace: Stack(
                children: [
                  FlexibleSpaceBar(
                    stretchModes: const [StretchMode.fadeTitle],
                    collapseMode: CollapseMode.pin,
                    background: Container(
                      margin: const EdgeInsets.only(bottom: 0.2),
                      child: fullyExpanded
                          ? (widget.expandedBody ?? const SizedBox())
                          : widget.headerWidget,
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    left: 0,
                    right: 0,
                    child: _roundedCorner(context),
                  ),
                  Positioned(
                    bottom: widget.curvedBodyRadius,
                    child: AnimatedContainer(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      duration: const Duration(milliseconds: 200),
                      height: fullyCollapsed
                          ? 0
                          : fullyExpanded
                              ? 0
                              : kToolbarHeight,
                      width: Sizes().screenWidth(context),
                      child: fullyCollapsed
                          ? const SizedBox()
                          : fullyExpanded
                              ? const SizedBox()
                              : widget.headerBottomBar ?? Container(),
                    ),
                  )
                ],
              ),
              stretchTriggerOffset: widget.stretchTriggerOffset,
              onStretchTrigger: widget.fullyStretchable
                  ? () async {
                      if (!fullyExpanded) isFullyExpanded.add(true);
                    }
                  : null,
            );
          },
        ),
        _sliverList(context, appBarHeight + topPadding),
      ],
    );
  }

  Container _roundedCorner(BuildContext context) {
    return Container(
      height: widget.fixedTitleHeight,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(widget.curvedBodyRadius),
        ),
      ),
      child: widget.fixedTitle ??
          Container(
            height: 0,
          ),
    );
  }

  SliverList _sliverList(BuildContext context, double topHeight) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
            children: [...widget.body],
          ),
          /*Stack(children: [
            Container(
              height: Sizes().screenHeight(context) - topHeight - 80,
              color: widget.backgroundColor ??
                  Theme.of(context).scaffoldBackgroundColor,
            ),
            Column(
              children: [...widget.body],
            ),
          ]),*/
        ],
      ),
    );
  }
}
