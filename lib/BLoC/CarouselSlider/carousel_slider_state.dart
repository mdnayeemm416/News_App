// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'carousel_slider_bloc.dart';

@immutable
sealed class Carousel_SliderState {}

final class CarouselSliderInitial extends Carousel_SliderState {}

class CarouselSliderDataLoadState extends Carousel_SliderState {
  final Carouselslidermodel carouselslidernews;
  int activeIndex;
  CarouselSliderDataLoadState({
    required this.carouselslidernews,
    required this.activeIndex,
  });
}
