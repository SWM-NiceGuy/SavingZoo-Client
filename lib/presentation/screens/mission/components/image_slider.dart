import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../ui/colors.dart';

class ImageSlider extends StatefulWidget {
  final List<Image> images;
  final double width;
  final double height;

  const ImageSlider({
    required this.images,
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  State<ImageSlider> createState() => _CarouselState();
}

class _CarouselState extends State<ImageSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFA4A7B1),
                spreadRadius: 0.0,
                blurRadius: 17.0,
              ),
            ],
          ),
          child: CarouselSlider(
            items: widget.images.map((image) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: image,
              );
            }).toList(),
            options: CarouselOptions(
              enableInfiniteScroll: false,
              scrollPhysics: const ClampingScrollPhysics(),
              height: widget.width,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.asMap().entries.map((entry) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 4.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == entry.key ? kBlue : kGrey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
