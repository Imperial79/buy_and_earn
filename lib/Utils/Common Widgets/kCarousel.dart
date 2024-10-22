import 'dart:async';

import 'package:flutter/material.dart';

import '../colors.dart';
import '../commons.dart';

class KCarousel extends StatefulWidget {
  final List<Widget> children;
  final double? height;
  final bool isLooped;
  final bool showIndicator;
  final double viewportFraction;
  final double indicatorSpacing;
  final void Function(int)? onPageChange;
  const KCarousel({
    super.key,
    required this.children,
    this.height,
    required this.isLooped,
    this.showIndicator = true,
    this.onPageChange,
    this.viewportFraction = .9,
    this.indicatorSpacing = 10,
  });

  static Widget Item({
    EdgeInsetsGeometry? padding,
    required String url,
    double? radius,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: kRadius(radius ?? 15),
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  @override
  State<KCarousel> createState() => _KCarouselState();
}

class _KCarouselState extends State<KCarousel> {
  late PageController _controller;
  int _activePage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
        initialPage: 0,
        viewportFraction: widget.viewportFraction,
        keepPage: true);

    if (widget.isLooped) {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        _controller.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.children.isNotEmpty
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height:
                    widget.height ?? MediaQuery.of(context).size.height * 0.3,
                child: PageView.builder(
                  itemCount: widget.isLooped ? null : widget.children.length,
                  controller: _controller,
                  padEnds: true,
                  itemBuilder: (context, index) {
                    int adjustedIndex =
                        index % widget.children.length; // Handle looping

                    return widget.children[adjustedIndex];
                  },
                  onPageChanged: (value) {
                    if (widget.onPageChange != null) {
                      widget.onPageChange!(value);
                    }
                    setState(() {
                      _activePage = value;
                    });
                  },
                ),
              ),
              widget.showIndicator
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: widget.indicatorSpacing),
                        child: _indicator(
                          context,
                          activeImage: _activePage % widget.children.length,
                          length: widget.children.length,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          )
        : const Center(
            child: Text(
              "No Image",
              textAlign: TextAlign.center,
            ),
          );
  }

  Widget _indicator(
    BuildContext context, {
    required int activeImage,
    required int length,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(length, (index) {
        bool isActive = activeImage == index;
        return AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          height: 10,
          width: isActive ? 20 : 10,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: kRadius(100),
            color: isActive ? kSecondaryColor : Colors.grey.shade300,
          ),
        );
      }),
    );
  }
}
