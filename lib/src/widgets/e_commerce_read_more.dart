import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Based on https://pub.dev/packages/readmore 
class ReadMoreText extends StatefulWidget {
  const ReadMoreText(
    this.data, {
    Key? key,
    this.trimExpandedText = ' show less',
    this.trimCollapsedText = 'read more',
    this.trimLines = 2,
    this.style,
    this.delimiterStyle,
  }) : super(key: key);

  /// Used on TrimMode.Lines
  final int trimLines;

  /// Widget data
  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;
  final TextStyle? style;
  final TextStyle? delimiterStyle;

  final String delimiter = '$_kEllipsis ';

  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() {
      _readMore = !_readMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = widget.style;
    if (widget.style?.inherit ?? false) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final overflow = defaultTextStyle.overflow;

    TextSpan link = TextSpan(
      text: _readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: const TextStyle(fontWeight: FontWeight.bold),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    TextSpan delimiter = TextSpan(
      text: _readMore
          ? widget.trimCollapsedText.isNotEmpty
              ? widget.delimiter
              : ''
          : '',
      style: const TextStyle(fontWeight: FontWeight.bold),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data
        final text = TextSpan(
          children: [
            TextSpan(text: widget.data, style: effectiveTextStyle),
          ],
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          maxLines: widget.trimLines,
          textDirection: TextDirection.rtl,
          ellipsis: overflow == TextOverflow.ellipsis ? widget.delimiter : null,
        );
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure delimiter
        textPainter.text = delimiter;
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final delimiterSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final readMoreSize = linkSize.width + delimiterSize.width;
          final pos = textPainter.getPositionForOffset(Offset(
            readMoreSize,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset) ?? 0;
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = _buildData(
            data: _readMore
                ? widget.data.substring(0, endIndex) + (linkLongerThanLine ? _kLineSeparator : '')
                : widget.data,
            textStyle: effectiveTextStyle,
            linkTextStyle: effectiveTextStyle?.copyWith(
              decoration: TextDecoration.underline,
              color: Colors.blue,
            ),
            children: [delimiter, link],
          );
        } else {
          textSpan = _buildData(
            data: widget.data,
            textStyle: effectiveTextStyle,
            linkTextStyle: effectiveTextStyle?.copyWith(
              decoration: TextDecoration.underline,
              color: Colors.blue,
            ),
            children: [],
          );
        }

        return Text.rich(
          TextSpan(
            children: [
              textSpan,
            ],
          ),
          softWrap: true,
          overflow: TextOverflow.clip,
        );
      },
    );
    return result;
  }

  TextSpan _buildData({
    required String data,
    TextStyle? textStyle,
    TextStyle? linkTextStyle,
    ValueChanged<String>? onPressed,
    required List<TextSpan> children,
  }) {
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');

    List<TextSpan> contents = [];

    while (exp.hasMatch(data)) {
      final match = exp.firstMatch(data);

      final firstTextPart = data.substring(0, match!.start);
      final linkTextPart = data.substring(match.start, match.end);

      contents.add(
        TextSpan(
          text: firstTextPart,
        ),
      );
      contents.add(
        TextSpan(
          text: linkTextPart,
          style: linkTextStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => onPressed?.call(
                  linkTextPart.trim(),
                ),
        ),
      );
      data = data.substring(match.end, data.length);
    }
    contents.add(
      TextSpan(
        text: data,
      ),
    );
    return TextSpan(
      children: contents..addAll(children),
      style: textStyle,
    );
  }
}
