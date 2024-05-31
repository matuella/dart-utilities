import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A [Stack] that knows how to detect out-of-bounds hits.
///
/// Flutter native `Stack` widget doesn't detect gesture on child elements that are not within its bounds.
/// This custom GestureStack overrides `hitTest` function from native Stack to doesn't take into consideration the
/// Stack bounds, since the element can be outside this bounds but still be visible.
/// More details can be found on this thread on SO: https://stackoverflow.com/questions/51366761/
class GestureStack extends Stack {
  const GestureStack({super.children, super.alignment, super.clipBehavior, super.fit});

  @override
  GestureRenderStack createRenderObject(BuildContext context) {
    return GestureRenderStack(
      alignment: alignment,
      textDirection: textDirection,
      fit: fit,
      clipBehavior: clipBehavior,
    );
  }
}

class GestureRenderStack extends RenderStack {
  GestureRenderStack({super.alignment, super.textDirection, super.fit, super.clipBehavior});

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    assert(
      () {
        if (!hasSize) {
          if (debugNeedsLayout) {
            throw FlutterError.fromParts(<DiagnosticsNode>[
              ErrorSummary('Cannot hit test a render box that has never been laid out.'),
              describeForError('The hitTest() method was called on this RenderBox'),
              ErrorDescription(
                "Unfortunately, this object's geometry is not known at this time, "
                'probably because it has never been laid out. '
                'This means it cannot be accurately hit-tested.',
              ),
              ErrorHint(
                'If you are trying '
                'to perform a hit test during the layout phase itself, make sure '
                "you only hit test nodes that have completed layout (e.g. the node's "
                'children, after their layout() method has been called).',
              ),
            ]);
          }
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('Cannot hit test a render box with no size.'),
            describeForError('The hitTest() method was called on this RenderBox'),
            ErrorDescription(
              'Although this node is not marked as needing layout, '
              'its size is not set.',
            ),
            ErrorHint(
              'A RenderBox object must have an '
              'explicit size before it can be hit-tested. Make sure '
              'that the RenderBox in question sets its size during layout.',
            ),
          ]);
        }
        return true;
      }(),
    );
    if (hitTestChildren(result, position: position) || hitTestSelf(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }
}
