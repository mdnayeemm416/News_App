part of 'carousel_slider_bloc.dart';

@immutable
sealed class Carousel_SliderState {}

final class CarouselSliderInitial extends Carousel_SliderState {}

class CarouselSliderDataLoadState extends Carousel_SliderState {
  int activeIndex;
  CarouselSliderDataLoadState({
    required this.activeIndex,
  });
}
