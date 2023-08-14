import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:e_commerce_ui_kit/src/utils/font_sizes.dart';
import 'package:flutter/material.dart';

/// Slidable raw with tags
class EComSlidableTags extends StatelessWidget {
  /// Widget title
  final String? title;

  /// Tags titles
  final List<String> tags;

  /// Tags titles
  final List<String> selectedTags;

  /// Unselected tags background color
  final Color tagColor;

  /// Selected tags background color
  final Color selectedTagColor;

  /// Style for title
  final TextStyle titleTextStyle;

  /// Style for unselected tags titles
  final TextStyle tagTextStyle;

  /// Style for unselected tags titles
  final TextStyle selectedTagTextStyle;

  /// Called after tapping on tag
  final ValueChanged<int> onTagSelected;

  const EComSlidableTags({
    Key? key,
    required this.tags,
    required this.onTagSelected,
    required this.selectedTags,
    this.title,
    this.tagColor = const Color(0xFFF6F6F6),
    this.selectedTagColor = const Color(0xFFF5D254),
    this.titleTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: FontSizes.sizeXL,
      fontWeight: FontWeight.bold,
    ),
    this.tagTextStyle = const TextStyle(
      color: Colors.grey,
      fontSize: FontSizes.sizeM,
      fontWeight: FontWeight.normal,
    ),
    this.selectedTagTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: FontSizes.sizeM,
      fontWeight: FontWeight.normal,
    ),
  }) : super(key: key);

  bool isTagSelected(int index) => selectedTags.contains(tags[index]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Text(title!, style: titleTextStyle),
          if (tags.isNotEmpty)
            SizedBox(
              height: Dimensions.tagHeight,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: Dimensions.marginSmall,
                    ),
                    child: FilledButton.tonal(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isTagSelected(index) ? selectedTagColor : tagColor,
                      ),
                      onPressed: () => onTagSelected(index),
                      child: Text(
                        tags[index],
                        style: isTagSelected(index)
                            ? selectedTagTextStyle
                            : tagTextStyle,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
