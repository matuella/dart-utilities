import 'package:flutter/widgets.dart';

/// An [IndexedStack] that lazy loads its child widgets.
///
/// The [LazyIndexedStack] widgets are only shown when they need to be displayed on the screen. When the [Widget] must
/// be displayed, [itemBuilder] is called for that index and then the [Widget] is built and displayed.
/// TODO(matuella): forward all Indexed Stack properties do the nested element.
class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack({
    required this.itemBuilder,
    required this.itemCount,
    required this.index,
    this.reuseWidgets = true,
    super.key,
  });

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;

  final int index;

  /// Set if the Widgets must be rebuilt every time they appear
  ///
  /// If set to `false`, [itemBuilder] is called every time that [index] changes, rebuilding the [index] Widget every
  /// time that it appears.
  final bool reuseWidgets;

  @override
  LazyIndexedStackState createState() => LazyIndexedStackState();
}

class LazyIndexedStackState extends State<LazyIndexedStack> {
  late Set<int> _loadedIndexes;
  late List<Widget> _children;

  @override
  void initState() {
    // Builds the initial index widget
    _children = List.generate(widget.itemCount, (index) {
      if (index == widget.index) {
        _loadedIndexes = {index};
        return widget.itemBuilder(context, widget.index);
      }

      return Container();
    });

    super.initState();
  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    final updatedIndex = widget.index;
    if (_loadedIndexes.contains(updatedIndex) && widget.reuseWidgets) {
      return;
    }

    _loadedIndexes.add(updatedIndex);
    _children[updatedIndex] = widget.itemBuilder(context, updatedIndex);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(index: widget.index, children: _children);
  }
}
