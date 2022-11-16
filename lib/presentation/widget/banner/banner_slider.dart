
import 'package:amond/presentation/controllers/banner_view_model.dart';
import 'package:amond/presentation/widget/banner/web_view_screen.dart';
import 'package:amond/presentation/widget/platform_based_indicator.dart';
import 'package:amond/ui/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
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


  // final List<BannerInfo> imgList = [
  //   BannerInfo(
  //       imageUrl:
  //           'assets/images/test_image.png',
  //       contentUrl:
  //           'https://pub.dev/packages/webview_flutter'),
  //   // BannerInfo(
  //   //     imageUrl:
  //   //         'https://sienaconstruction.com/wp-content/uploads/2017/05/test-image.jpg',
  //   //     contentUrl:
  //   //         'https://pub.dev/packages/webview_flutter'),
  // ];

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
        child: PlatformBasedLoadingIndicator(),
      );
    }

    try {

    return viewModel.infos.isEmpty
        ? const SizedBox()
         :Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                items: viewModel.infos
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
                  autoPlay: viewModel.infos.length > 1 ? true : false,
                  autoPlayInterval: const Duration(seconds: 6),
                  enlargeCenterPage: true,
                  aspectRatio: 4.0 / 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 4),
              if (viewModel.infos.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: viewModel.infos.asMap().entries.map((entry) {
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
                                  : textBlueColor200)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
    } catch (e) {
      // 슬라이더 표시에 예외가 발생하면 해당 위젯 반환
      if (kDebugMode) {
        print(e);
      }
      return const SizedBox();
    }
  }
}