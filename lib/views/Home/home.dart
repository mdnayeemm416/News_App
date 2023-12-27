import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/AppConstant/app_constant.dart';
import 'package:news_app/BLoC/Home/home_bloc.dart';
import 'package:news_app/views/Home/Components/carousel_slider.dart';
import 'package:news_app/views/Home/Components/trending_news.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final Width = MediaQuery.of(context).size.width;
    HomeBloc homeBloc = HomeBloc();
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Breaking News",
                    style: subTitleStyle,
                  ),
                  TextButton(onPressed: () {}, child: const Text("View All"))
                ],
              ),
              SizedBox(
                height: height * .010,
              ),
              const CarouselSliderWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trending News",
                    style: subTitleStyle,
                  ),
                  TextButton(onPressed: () {}, child: const Text("View All"))
                ],
              ),
              const TrendingNews(),
            ],
          ),
        );
      },
    );
  }
}
