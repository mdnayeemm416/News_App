// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trendingnews_bloc.dart';

@immutable
sealed class TrendingnewsState {}

final class TrendingnewsInitial extends TrendingnewsState {}
class TrendingNewsDataLoadingState extends TrendingnewsState{}

class TrendingNewsDataLoadState extends TrendingnewsState {
  final Trendingnewsmodel trendingnews;
  TrendingNewsDataLoadState({
    required this.trendingnews,
  });
  
}
