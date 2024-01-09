import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app/AppConstant/app_constant.dart';
import 'package:news_app/BLoC/CarouselSlider/carousel_slider_bloc.dart';
import 'package:news_app/views/Article_Web_View/article_web_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  @override
  void initState() {
    carouselSliderBloc.add(CarouselSliderDataLoadEvent());
    super.initState();
  }

  CarouselSliderBloc carouselSliderBloc = CarouselSliderBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarouselSliderBloc, Carousel_SliderState>(
      bloc: carouselSliderBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case CarouselSliderDataLoadState:
            final success = state as CarouselSliderDataLoadState;

            return Column(
              children: [
                CarouselSlider.builder(
                    itemCount: success.carouselslidernews.articles.length,
                    itemBuilder: (context, index, realIndex) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(ArticleWebView(
                            url: success.carouselslidernews.articles[index].url,
                          ));
                        },
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                  'images/news.jpg',
                                  width: AppSize.width(context),
                                  fit: BoxFit.cover,
                                );
                              },
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              imageUrl: success
                                  .carouselslidernews.articles[index].urlToImage
                                  .toString(),
                              fit: BoxFit.cover,
                              width: AppSize.width(context),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .18,
                            ),
                            height: AppSize.height(context) * .12,
                            decoration: const BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Text(
                              success.carouselslidernews.articles[index].title,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ]),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      height: MediaQuery.of(context).size.height * .28,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          success.activeIndex = index;
                        });
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                AnimatedSmoothIndicator(
                  activeIndex: success.activeIndex,
                  count: success.carouselslidernews.articles.length,
                  effect: const SlideEffect(
                      dotHeight: 10, dotWidth: 12, activeDotColor: blueColor),
                )
              ],
            );
          default:
            return SizedBox(
              height: AppSize.height(context) * .28,
              width: AppSize.width(context),
              child: const Center(child: CircularProgressIndicator()),
            );
        }
      },
    );
  }
}
