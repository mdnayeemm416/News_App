// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'allnews_bloc.dart';

@immutable
sealed class AllnewsEvent {}


class AllNewsDataLoadEvent extends AllnewsEvent {
  final String tabname;
  AllNewsDataLoadEvent({
    required this.tabname,
  });
}
