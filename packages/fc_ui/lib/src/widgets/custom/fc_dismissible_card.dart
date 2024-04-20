import 'package:fc_ui/fc_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';

class FCDismissibleCard extends StatelessWidget {
  const FCDismissibleCard({
    super.key,
    required this.onPressed,
    required this.onDeleted,
    required this.dismissibleKey,
    required this.child,
  });
  final VoidCallback onPressed;
  final Future<bool?> Function() onDeleted;
  final Key dismissibleKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius20,
      child: FCGradient(
        child: DismissibleTile(
          rtlDismissedColor: Colors.red,
          confirmDismiss: (direction) {
            if (direction == DismissibleTileDirection.leftToRight) {
              return Future.value();
            }
            return onDeleted.call();
          },
          key: dismissibleKey,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: edgeInsetsH20.add(edgeInsetsV12),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
