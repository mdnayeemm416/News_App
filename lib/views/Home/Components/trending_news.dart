import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/AppConstant/app_constant.dart';
import 'package:news_app/BLoC/TrendingNews/trendingnews_bloc.dart';

class TrendingNews extends StatefulWidget {
  const TrendingNews({super.key});

  @override
  State<TrendingNews> createState() => _TrendingNewsState();
}

class _TrendingNewsState extends State<TrendingNews> {
  final TrendingnewsBloc trendingnewsBloc = TrendingnewsBloc();
  @override
  void initState() {
    trendingnewsBloc.add(TrendingNewsDataLoadEvent());
    super.initState();
  }

  String preprocessImageUrl(String originalUrl) {
    Uri uri = Uri.parse(originalUrl);
    return uri.replace(queryParameters: {}).toString().replaceAll('?', '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrendingnewsBloc, TrendingnewsState>(
      bloc: trendingnewsBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case TrendingNewsDataLoadingState:
            return const Center(child: CircularProgressIndicator());
          case TrendingNewsDataLoadState:
            final trendingnewsdata = state as TrendingNewsDataLoadState;
            return Expanded(
                child: ListView.builder(
                    itemCount: trendingnewsdata.trendingnews.articles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      errorWidget: (context, url, error) {
                                        return Image.asset('images/news.jpg');
                                      },
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      imageUrl: preprocessImageUrl(
                                          trendingnewsdata.trendingnews
                                              .articles[index].urlToImage
                                              .toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: AppSize.width25(context),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        trendingnewsdata
                                            .trendingnews.articles[index].title,
                                        style: newsTitleStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }));

          default:
            return SizedBox();
        }
      },
    );
  }
}
