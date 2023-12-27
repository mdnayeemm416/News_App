import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/trendingNewsModel.dart';
part 'trendingnews_event.dart';
part 'trendingnews_state.dart';

class TrendingnewsBloc extends Bloc<TrendingnewsEvent, TrendingnewsState> {
  TrendingnewsBloc() : super(TrendingnewsInitial()) {
    on<TrendingNewsDataLoadEvent>(trendingNewsDataLoadEvent);
  }

  Future<void> trendingNewsDataLoadEvent(
      TrendingNewsDataLoadEvent event, Emitter<TrendingnewsState> emit) async {
    final response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=b60a6c2fdacc40cd803256ad6154fbe3'),
    );

    if (response.statusCode == 200) {
      final trendingNews =
          Trendingnewsmodel.fromJson(json.decode(response.body));

      // Filter articles with non-null urlToImage
      final filteredArticles = trendingNews.articles
          .where((article) => article.urlToImage != null)
          .toList();

      final filteredTrendingNews = Trendingnewsmodel(
        status: trendingNews.status,
        totalResults: trendingNews.totalResults,
        articles: filteredArticles,
      );

      emit(TrendingNewsDataLoadState(trendingnews: filteredTrendingNews));
    } else {
      throw Exception('Failed to load news');
    }
  }
}
