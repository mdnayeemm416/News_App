import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carousel_slider_event.dart';
part 'carousel_slider_state.dart';

class CarouselSliderBloc
    extends Bloc<CarouselSliderEvent, Carousel_SliderState> {
  CarouselSliderBloc() : super(CarouselSliderInitial()) {
    on<CarouselSliderDataLoadEvent>(carouselSliderDataLoadEvent);
  }

  FutureOr<void> carouselSliderDataLoadEvent(
      CarouselSliderDataLoadEvent event, Emitter<Carousel_SliderState> emit) {
    int activeIndex = 0;
    emit(CarouselSliderDataLoadState(activeIndex: activeIndex));
  }
}
