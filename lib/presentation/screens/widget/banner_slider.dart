import 'package:amond/domain/models/banner_info.dart';
import 'package:amond/presentation/controllers/banner_view_model.dart';
import 'package:amond/presentation/screens/widget/web_view_screen.dart';
import 'package:amond/widget/platform_based_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BannerSliderState();
  }
}

class _BannerSliderState extends State<BannerSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  var _isLoading = true;

  final List<BannerInfo> imgList = [
    BannerInfo(
        imageUrl:
            'https://sienaconstruction.com/wp-content/uploads/2017/05/test-image.jpg',
        contentUrl:
            'https://pub.dev/packages/webview_flutter'),
    BannerInfo(
        imageUrl:
            'https://sienaconstruction.com/wp-content/uploads/2017/05/test-image.jpg',
        contentUrl:
            'https://pub.dev/packages/webview_flutter'),
  ];

  @override
  void initState() {
    super.initState();

    // 데이터를 불러옴
    Future.microtask(() {
      context.read<BannerViewModel>().setBannerInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BannerViewModel>();

    if (viewModel.isLoading) {
      return const Center(
        child: PlatformBasedIndicator(),
      );
    }

    // return viewModel.infos.isEmpty
    //     ? const SizedBox()
         return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                items: imgList
                    .map((item) => GestureDetector(
                        onTap: () async {
                          final url = Uri.parse(item.contentUrl);
                          if (await canLaunchUrl(url)) {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewScreen(initialUrl: item.contentUrl)));
                          }
                        },
                        child: Image.network(
                          item.imageUrl,
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        )))
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 4.2 / 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
  }
}
