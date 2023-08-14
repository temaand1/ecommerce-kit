import 'package:flutter/material.dart';

class EComCounter extends StatefulWidget {
  /// Counter initial value
  final int count;

  /// Counter value color
  final Color countColor;

  /// The callback that is called when value changed
  final ValueChanged<int> onChange;

  /// Counter size
  final double size;

  const EComCounter({
    Key? key,
    required this.count,
    required this.onChange,
    this.countColor = Colors.black,
    this.size = 24,
  }) : super(key: key);

  @override
  State<EComCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<EComCounter> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: IconButton(
                    onPressed: () => widget.onChange(widget.count != 0 ? widget.count - 1 : 0),
                    icon: Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.black)),
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          size: widget.size * 0.6,
                        ),
                      ),
                    ),
                    splashRadius: widget.size,
                    padding: EdgeInsets.all(widget.size * 0.1),
                    constraints: const BoxConstraints(),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                    return currentChild!;
                  },
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final Animation<Offset> inAnimation =
                        Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                            .animate(animation);
                    final Animation<Offset> outAnimation =
                        Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero)
                            .animate(animation);

                    if (child.key.toString() == widget.count.toString()) {
                      return ClipRect(
                        child: SlideTransition(position: inAnimation, child: child),
                      );
                    } else {
                      return ClipRect(
                        child: SlideTransition(position: outAnimation, child: child),
                      );
                    }
                  },
                  child: SizedBox(
                    key: Key(widget.count.toString()),
                    width: widget.size * 0.5,
                    child: Center(
                      child: Text(
                        widget.count.toString(),
                        style: TextStyle(
                          fontSize: widget.size * 0.7,
                          color: widget.countColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: IconButton(
                    onPressed: () => widget.onChange(widget.count + 1),
                    icon: Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: widget.size * 0.6,
                        ),
                      ),
                    ),
                    splashRadius: widget.size,
                    padding: EdgeInsets.all(widget.size * 0.1),
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
