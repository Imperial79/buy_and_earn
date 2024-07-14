import 'dart:async';

import 'package:flutter/material.dart';

import '../colors.dart';
import '../commons.dart';

class KCarousel extends StatefulWidget {
  final List<Widget> children;
  final double? height;
  final bool isLooped;
  final bool showIndicator;
  final void Function(int)? onPageChange;
  KCarousel({
    super.key,
    required this.children,
    this.height,
    required this.isLooped,
    this.showIndicator = true,
    this.onPageChange,
  });

  static Widget Item({
    EdgeInsetsGeometry? padding,
    required String url,
    double? radius,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: kRadius(radius ?? 15),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  State<KCarousel> createState() => _KCarouselState();
}

class _KCarouselState extends State<KCarousel> {
  final PageController _controller =
      PageController(initialPage: 0, viewportFraction: .9, keepPage: true);
  int _activePage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    if (widget.isLooped) {
      _timer = Timer.periodic(Duration(seconds: 3), (timer) {
        _controller.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.ease);
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height ?? MediaQuery.of(context).size.height * 0.3,
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
              if (widget.onPageChange != null) widget.onPageChange!(value);
              setState(() {
                _activePage = value;
              });
            },
          ),
        ),
        widget.showIndicator
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: _indicator(
                    context,
                    activeImage: _activePage % widget.children.length,
                    length: widget.children.length,
                  ),
                ),
              )
            : SizedBox(),
      ],
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
      children: List.generate(
        length,
        (index) => AnimatedContainer(
          margin: EdgeInsets.symmetric(horizontal: 2),
          height: 5,
          width: activeImage != index ? 5 : 20,
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: kRadius(100),
            color:
                activeImage != index ? Colors.grey.shade300 : kSecondaryColor,
          ),
        ),
      ),
    );
  }
}
