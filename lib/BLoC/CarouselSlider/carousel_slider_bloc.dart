import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/carousel_slider_modelmodel.dart';

part 'carousel_slider_event.dart';
part 'carousel_slider_state.dart';

class CarouselSliderBloc
    extends Bloc<CarouselSliderEvent, Carousel_SliderState> {
  CarouselSliderBloc() : super(CarouselSliderInitial()) {
    on<CarouselSliderDataLoadEvent>(carouselSliderDataLoadEvent);
  }

  Future<FutureOr<void>> carouselSliderDataLoadEvent(
      CarouselSliderDataLoadEvent event,
      Emitter<Carousel_SliderState> emit) async {
    int activeIndex = 0;
    final Carouselslidermodel carouselslidernews;
    final response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=b60a6c2fdacc40cd803256ad6154fbe3'),
    );

    if (response.statusCode == 200) {
      final carouselslider =
          Carouselslidermodel.fromJson(json.decode(response.body));

      // Filter articles with non-null urlToImage
      final filteredArticles = carouselslider.articles
          // ignore: unnecessary_null_comparison
          .where((article) => article.urlToImage != null)
          .toList();

      final filteredcarouselslider = Carouselslidermodel(
        status: carouselslider.status,
        totalResults: carouselslider.totalResults,
        articles: filteredArticles,
      );
      carouselslidernews = filteredcarouselslider;
    } else {
      throw Exception('Failed to load news');
    }
    emit(CarouselSliderDataLoadState(
        activeIndex: activeIndex, carouselslidernews: carouselslidernews));
  }
}
