import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/AppConstant/app_constant.dart';
import 'package:news_app/BLoC/CarouselSlider/carousel_slider_bloc.dart';
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
                Container(
                  child: CarouselSlider.builder(
                      itemCount: 5,
                      itemBuilder: (context, index, realIndex) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "images/news.jpg",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
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
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedSmoothIndicator(
                  activeIndex: success.activeIndex,
                  count: 5,
                  effect: const SlideEffect(
                      dotHeight: 10, dotWidth: 12, activeDotColor: blueColor),
                )
              ],
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
