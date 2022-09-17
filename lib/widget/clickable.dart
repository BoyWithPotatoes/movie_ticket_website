import 'package:flutter/material.dart';

class ClickableText extends StatefulWidget {
  final String text;
  final VoidCallback onClick;
  final bool hoverUnderline;
  final double fontSize;
  final Color fontColor;
  const ClickableText(this.text, {
    required this.onClick,
    this.hoverUnderline = true,
    this.fontSize = 14,
    this.fontColor = Colors.black,
    super.key
  });

  @override
  State<ClickableText> createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  bool _underline = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (e) {
        setState(() => _underline = widget.hoverUnderline);
      },
      onExit: (e) {
        setState(() => _underline = false);
      },
      child: GestureDetector(
        onTap: widget.onClick,
        child: Text(
          widget.text,
          style: TextStyle(
            decoration: _underline ? TextDecoration.underline : TextDecoration.none,
            color: widget.fontColor,
            fontSize: widget.fontSize,
          ),
        ),
      ),
    );
  }
}

class Button extends StatefulWidget {
  final Widget? child;
  final Color color;
  final Size size;
  final VoidCallback onClick;
  final EdgeInsets? padding;
  const Button({
    required this.onClick,
    this.child,
    this.color = Colors.transparent,
    this.size = const Size(0, 0),
    this.padding,
    super.key
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  double _colorAlpha = 1;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() => _colorAlpha = 0.7),
      onExit: (event) => setState(() => _colorAlpha = 1.0),
      child: GestureDetector(
        onTap: widget.onClick,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutQuad,
          width: widget.size.width,
          height: widget.size.height,
          padding: widget.padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.color.withAlpha((_colorAlpha * 255).toInt()),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}