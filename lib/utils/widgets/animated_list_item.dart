import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

/// Animate List Item
class AnimatedListItem extends StatelessWidget {
  /// Item Index
  final int index;

  /// Item Widget
  final Widget child;

  const AnimatedListItem({required this.index, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 80.0,
        child: FadeInAnimation(child: child),
      ),
    );
  }
}
