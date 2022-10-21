
import 'package:bloc/bloc.dart';
import 'package:collaction_admin/presentation/go_routing/browser_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';


class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {

  BrowserNotifier browserNotifier = BrowserNotifier();

  NavigationBloc() : super(NavigationState()) {

    browserNotifier.addListener(() {
      add(BrowserPopStateEvent(route: browserNotifier.routePopState!));
    });

    on<NavigateToPageEvent>((event, emit) {
      emit(state.copyWith(route: event.route));
    });

    on<BrowserPopStateEvent>((event, emit) {
      emit(state.copyWith(route: event.route));
    });
  }
}
