import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/all_news_model.dart';

part 'allnews_event.dart';
part 'allnews_state.dart';

class AllnewsBloc extends Bloc<AllnewsEvent, AllnewsState> {
  AllnewsBloc() : super(AllnewsInitial()) {
    on<AllNewsDataLoadEvent>(allNewsDataLoadEvent);
  }

  Future<FutureOr<void>> allNewsDataLoadEvent(
      AllNewsDataLoadEvent event, Emitter<AllnewsState> emit) async {
    final response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=${event.tabname}&apiKey=b60a6c2fdacc40cd803256ad6154fbe3'),
    );

    if (response.statusCode == 200) {
      final allNews = Allnewsmodel.fromJson(json.decode(response.body));

      // Filter articles with non-null urlToImage
      final filteredArticles = allNews.articles
          .where((article) => article.urlToImage != null)
          .toList();

      final filteredTrendingNews = Allnewsmodel(
        status: allNews.status,
        totalResults: allNews.totalResults,
        articles: filteredArticles,
      );

      emit(AllNewsDataLoadState(allnews: filteredTrendingNews));
    } else {
      throw Exception('Failed to load news');
    }
  }
}
