// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:news_app/AppConstant/app_constant.dart';
import 'package:news_app/BLoC/AllNewsBLoC/allnews_bloc.dart';
import 'package:news_app/views/Article_Web_View/article_web_view.dart';

class AllNewsWiddget extends StatefulWidget {
  final String tabName;
  const AllNewsWiddget({
    Key? key,
    required this.tabName,
  }) : super(key: key);

  @override
  State<AllNewsWiddget> createState() => _AllNewsWiddgetState();
}

class _AllNewsWiddgetState extends State<AllNewsWiddget> {
  @override
  void initState() {
    allnewsBloc.add(AllNewsDataLoadEvent(tabname: widget.tabName));
    super.initState();
  }

  AllnewsBloc allnewsBloc = AllnewsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllnewsBloc, AllnewsState>(
      bloc: allnewsBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case AllNewsDataLoadState:
            final allNewsData = state as AllNewsDataLoadState;
            return ListView.builder(
                itemCount: allNewsData.allnews.articles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(ArticleWebView(
                        url: allNewsData.allnews.articles[index].url,
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 219, 218, 218),
                                    spreadRadius: 1,
                                    blurRadius: 15,
                                    offset: Offset(0, 5))
                              ]),
                          padding: EdgeInsets.all(AppSize.height20(context)),
                          width: AppSize.width(context),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
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
                                  imageUrl: allNewsData
                                      .allnews.articles[index].urlToImage
                                      .toString(),
                                  height: AppSize.height200(context),
                                  width: AppSize.width(context),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                allNewsData.allnews.articles[index].title,
                                style: newsTitleStyle,
                                maxLines: 2,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                allNewsData.allnews.articles[index].description
                                    .toString(),
                                style: newsSubTitleStyle,
                                maxLines: 3,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });

          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
