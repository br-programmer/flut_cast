import 'package:flutter/material.dart';

class FCPinnedPersistenHeaderDelegate extends SliverPersistentHeaderDelegate {
  FCPinnedPersistenHeaderDelegate({required this.child, required this.extent});

  final Widget child;
  final double extent;

  @override
  Widget build(BuildContext _, double __, bool ___) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => extent;

  @override
  bool shouldRebuild(FCPinnedPersistenHeaderDelegate oldDelegate) => true;
}
