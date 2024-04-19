import 'package:fc_ui/fc_ui.dart';
import 'package:flutter/cupertino.dart';

class FCTextField extends StatefulWidget {
  const FCTextField({
    super.key,
    this.hint,
    required this.controller,
    this.onChanged,
    this.focusNode,
    this.prefix,
    this.suffix,
    this.padding,
  });
  final String? hint;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;
  final EdgeInsetsGeometry? padding;

  @override
  State<FCTextField> createState() => _FCTextFieldState();
}

class _FCTextFieldState extends State<FCTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? edgeInsetsH20.add(edgeInsetsV8),
      child: CupertinoTextField(
        decoration: const BoxDecoration(
          color: Palette.grey,
          borderRadius: borderRadius12,
        ),
        placeholder: widget.hint,
        placeholderStyle: context.textTheme.bodyMedium?.copyWith(
          fontWeight: AppFontWeight.regular,
        ),
        padding: edgeInsetsH8,
        prefix: widget.prefix,
        suffix: widget.suffix,
        controller: widget.controller,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        cursorColor: Palette.white.withOpacity(.5),
        cursorHeight: 16,
        cursorWidth: 2.5,
        style: context.textTheme.bodyLarge,
      ),
    );
  }
}
