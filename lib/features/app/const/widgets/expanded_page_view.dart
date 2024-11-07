import 'package:flutter/material.dart' show Easing;
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ExpandablePageView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final PageController? controller;
  final ValueChanged<int>? onPageChanged;
  final bool reverse;

  const ExpandablePageView({
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.onPageChanged,
    this.reverse = false,
    super.key,
  });

  @override
  _ExpandablePageViewState createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView> {
  PageController? _pageController;
  List<double> _heights = [];
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    super.initState();
    _heights = List.filled(widget.itemCount, 0, growable: true);
    _initializePageController();
  }

  @override
  void didUpdateWidget(ExpandablePageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updatePageController();
    }
  }

  void _initializePageController() {
    _pageController = widget.controller ?? PageController();
    _pageController?.addListener(_updatePage);
  }

  void _updatePageController() {
    _pageController?.removeListener(_updatePage);
    _pageController = widget.controller ?? PageController();
    _pageController?.addListener(_updatePage);
  }

  @override
  void dispose() {
    _pageController?.removeListener(_updatePage);
    if (widget.controller == null) {
      _pageController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Easing.standardDecelerate,
      tween: Tween(begin: _heights.first, end: _currentHeight),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.itemCount,
        itemBuilder: _itemBuilder,
        onPageChanged: (index) {
          if (widget.onPageChanged != null) {
            widget.onPageChanged!(index);
          }
        },
        reverse: widget.reverse,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final item = widget.itemBuilder(context, index);
    return OverflowBox(
      minHeight: 0,
      maxHeight: double.infinity,
      alignment: Alignment.topCenter,
      child: SizeReportingWidget(
        onSizeChange: (size) => setState(() => _heights[index] = size.height),
        child: item,
      ),
    );
  }

  void _updatePage() {
    final newPage = _pageController?.page?.round();
    if (_currentPage != newPage) {
      setState(() {
        _currentPage = newPage ?? _currentPage;
      });
    }
  }
}

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const SizeReportingWidget({
    required this.child,
    required this.onSizeChange,
    super.key,
  });

  @override
  _SizeReportingWidgetState createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return widget.child;
  }

  void _notifySize() {
    final size = context.size;
    if (_oldSize != size) {
      _oldSize = size;
      if (size != null) widget.onSizeChange(size);
    }
  }
}
