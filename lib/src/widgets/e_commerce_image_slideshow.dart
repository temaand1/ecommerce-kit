// ignore_for_file: library_private_types_in_public_api
import 'dart:async';

import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Image slideshow
class EComImageSlideshow extends StatefulWidget {
  /// Images used in the slider
  final List<String> imageURLs;

  /// Fit type for images
  final BoxFit imageFit;

  /// The color to paint the indicator.
  final Color indicatorColor;

  /// The color to paint behind the indicator.
  final Color indicatorBackgroundColor;

  /// Callback which is invoked after user clicks on the Promo
  final VoidCallback? onBannerClick;

  const EComImageSlideshow({
    Key? key,
    this.onBannerClick,
    required this.imageURLs,
    required this.imageFit,
    required this.indicatorColor,
    required this.indicatorBackgroundColor,
  }) : super(key: key);

  @override
  _EComImageSlideshowState createState() => _EComImageSlideshowState();
}

class _EComImageSlideshowState extends State<EComImageSlideshow> {
  late final ValueNotifier<int> _currentPageNotifier;
  late final PageController _pageController;
  Timer? _timer;

  void _autoPlayTimerStart() {
    const autoPlayInterval = 10000;
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: autoPlayInterval),
      (timer) {
        final nextPage = _currentPageNotifier.value + 1;
        _goToPage(nextPage);
      },
    );
  }

  void _goToPage(int index) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void initState() {
    _pageController = PageController();
    _currentPageNotifier = ValueNotifier(0);
    _autoPlayTimerStart();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageCount = widget.imageURLs.length;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView.builder(
            scrollBehavior: const ScrollBehavior().copyWith(
              scrollbars: false,
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            onPageChanged: (index) => _currentPageNotifier.value = index,
            controller: _pageController,
            itemBuilder: (context, index) {
              final correctIndex = index % imageCount;
              final image = Image(
                image: NetworkImage(widget.imageURLs[correctIndex]),
                fit: widget.imageFit,
              );
              return (widget.onBannerClick == null)
                  ? image
                  : GestureDetector(
                      onTap: widget.onBannerClick,
                      child: image,
                    );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.marginMiddle),
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPageNotifier,
              builder: (context, value, child) {
                return _Indicator(
                  count: imageCount,
                  currentIndex: value % imageCount,
                  activeColor: widget.indicatorColor,
                  backgroundColor: widget.indicatorBackgroundColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    Key? key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.backgroundColor,
  }) : super(key: key);

  final int count;
  final int currentIndex;
  final Color? activeColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Dimensions.marginMicro,
      runSpacing: Dimensions.marginMicro,
      alignment: WrapAlignment.center,
      children: List.generate(
        count,
        (index) {
          return CircleAvatar(
            radius: Dimensions.microCircularRadius,
            backgroundColor:
                currentIndex == index ? activeColor : backgroundColor,
          );
        },
      ),
    );
  }
}
