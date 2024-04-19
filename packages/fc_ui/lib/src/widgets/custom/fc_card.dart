import 'package:fc_ui/src/src.dart';
import 'package:flutter/material.dart';

class FCCard extends StatelessWidget {
  FCCard({
    super.key,
    required this.child,
    required this.title,
    this.iconData,
    this.showDivier = true,
    this.padding,
  });
  final Widget child;
  final String title;
  final bool showDivier;
  final IconData? iconData;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? edgeInsetsH20,
      child: ClipRRect(
        borderRadius: borderRadius16,
        child: DecoratedBox(
          decoration: BoxDecoration(color: Palette.grey.withOpacity(.2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gap16,
              Padding(
                padding: edgeInsetsH16,
                child: Row(
                  children: [
                    if (iconData != null)
                      Icon(
                        iconData,
                        color: Colors.white.withOpacity(.35),
                        size: 16,
                      ),
                    space4,
                    Expanded(
                      child: Text(
                        title,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: iconData != null
                              ? Palette.white.withOpacity(.35)
                              : Palette.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (showDivier)
                Padding(
                  padding: edgeInsetsL16,
                  child: const Divider(thickness: .5),
                ),
              child,
              gap16,
            ],
          ),
        ),
      ),
    );
  }
}
