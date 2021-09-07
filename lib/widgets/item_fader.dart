import 'package:find_the_focus/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ItemFader extends StatefulWidget {
  const ItemFader({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  ItemFaderState createState() => ItemFaderState();
}

class ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  int position = 1;
  late AnimationController _animationController;
  late Animation _animation;
  final Duration _animationDuration = const Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void show() {
    setState(() => position = 1);
    _animationController.forward();
  }

  void hide() {
    setState(() => position = -1);
    _animationController.reverse();
  }

  Future<void> animateDot(Offset startOffset) async {
    OverlayEntry entry = OverlayEntry(
      builder: (context) {
        final Size size = MediaQuery.of(context).size;
        double minTop = MediaQuery.of(context).padding.top + size.height * 0.15;
        return AnimatedBuilder(
          animation: _animationController,
          child: Dot(),
          builder: (_, child) {
            return Positioned(
              left: size.width * 0.2,
              top: minTop +
                  (startOffset.dy - minTop) * (1 - _animationController.value),
              child: child!,
            );
          },
        );
      },
    );
    Overlay.of(context)!.insert(entry);
    await _animationController.forward(from: 0);
    entry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (_, child) {
        return Transform.translate(
          offset:
              Offset(0, (64 * position * (1 - _animation.value)).toDouble()),
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
    );
  }
}
