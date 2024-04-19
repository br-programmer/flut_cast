import 'package:fc_ui/fc_ui.dart';
import 'package:flutter/material.dart';

class FCSearchTextField extends FCTextField {
  const FCSearchTextField({
    super.key,
    required super.hint,
    required this.onFocus,
    required super.controller,
    required this.cancelText,
    required super.focusNode,
    required this.hasFocus,
    required this.query,
    this.duration = duration500ms,
    super.onChanged,
  });

  final Duration duration;
  final ValueChanged<bool> onFocus;
  final String cancelText;
  final ValueNotifier<bool> hasFocus;
  final ValueNotifier<String> query;

  @override
  State<FCSearchTextField> createState() => _FCSearchTextFieldState();
}

class _FCSearchTextFieldState extends State<FCSearchTextField> {
  late final debouncer = Debouncer(duration: widget.duration);
  late final focusNode = widget.focusNode!..addListener(listener);
  late final hasFocus = widget.hasFocus;
  late final query = widget.query;

  void listener() {
    hasFocus.value = focusNode.hasFocus || query.value.isNotEmpty;
    widget.onFocus(hasFocus.value);
  }

  void onChanged(String query) {
    this.query.value = query;
    if (query.isEmpty) {
      return widget.onChanged?.call(query);
    }
    debouncer.run(() => widget.onChanged?.call(query));
  }

  @override
  void dispose() {
    debouncer.cancel();
    focusNode.removeListener(listener);
    super.dispose();
  }

  void clear() {
    widget.controller.text = '';
    onChanged('');
  }

  void cancel() {
    clear();
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox.expand(
            child: ValueListenableBuilder(
              valueListenable: hasFocus,
              builder: (_, value, __) => FCTextField(
                focusNode: focusNode,
                controller: widget.controller,
                onChanged: onChanged,
                hint: widget.hint,
                padding: edgeInsetsV8.add(
                  EdgeInsets.only(left: 20, right: value ? 0 : 20),
                ),
                prefix: Padding(
                  padding: edgeInsetL8,
                  child: Icon(
                    Icons.search,
                    color: Palette.white.withOpacity(.5),
                    size: 20,
                  ),
                ),
                suffix: ValueListenableBuilder(
                  valueListenable: query,
                  builder: (_, value, child) {
                    if (value.isEmpty) return SizedBox.shrink();
                    return child!;
                  },
                  child: Padding(
                    padding: edgeInsetR8,
                    child: InkWell(
                      onTap: clear,
                      child: Icon(
                        Icons.cancel_sharp,
                        color: Palette.white.withOpacity(.5),
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: hasFocus,
          builder: (_, value, child) {
            if (value) {
              return Padding(
                padding: EdgeInsets.only(right: 20, left: 10),
                child: child,
              );
            }
            return SizedBox.shrink();
          },
          child: InkWell(
            onTap: cancel,
            child: Text(
              widget.cancelText,
              style: context.textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}
