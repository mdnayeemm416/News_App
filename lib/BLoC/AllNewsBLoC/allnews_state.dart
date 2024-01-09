// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'allnews_bloc.dart';

@immutable
sealed class AllnewsState {}

final class AllnewsInitial extends AllnewsState {}

class AllNewsDataLoadState extends AllnewsState {
  final Allnewsmodel allnews;
  AllNewsDataLoadState({
    required this.allnews,
  });
  
}
