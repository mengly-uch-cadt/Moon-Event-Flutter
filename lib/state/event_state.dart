
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/get_event.dart';

class EventNotifier extends StateNotifier<EventState> {
  EventNotifier() : super(EventState());
  //  All Event Data
  void setAllEventData(List<GetEvent> eventData) {
    state = state.copyWith(allEvents: eventData);
  }

  void clearAllEventData() {
    state = state.copyWith(allEvents: null);
  }

  // Popular Event Data
  void setPopularEventData(List<GetEvent> eventData) {
    state = state.copyWith(popularEvents: eventData);
  }

  void clearPopularEventData() {
    state = state.copyWith(popularEvents: null);
  }

  // New Release Event Data
  void setNewReleaseEventData(List<GetEvent> eventData) {
    state = state.copyWith(newReleaseEvents: eventData);
  }

  void clearNewReleaseEventData() {
    state = state.copyWith(newReleaseEvents: null);
  }

  // User Event Data
  void setUserEventData(List<GetEvent> eventData) {
    state = state.copyWith(userEvents: eventData);
  }

  void clearUserEventData() {
    state = state.copyWith(userEvents: null);
  }

}

final eventProvider = StateNotifierProvider<EventNotifier, EventState>((ref) {
  return EventNotifier();
});


class EventState{
  final List<GetEvent>? allEvents;
  final List<GetEvent>? popularEvents;
  final List<GetEvent>? newReleaseEvents;
  final List<GetEvent>? userEvents;

  EventState({
    this.allEvents, 
    this.popularEvents, 
    this.newReleaseEvents, 
    this.userEvents,
  });

  EventState copyWith({
    List<GetEvent>? allEvents,
    List<GetEvent>? popularEvents,
    List<GetEvent>? newReleaseEvents,
    List<GetEvent>? userEvents,
  }) {
    return EventState(
      allEvents       : allEvents ?? this.allEvents,
      popularEvents   : popularEvents ?? this.popularEvents,
      newReleaseEvents: newReleaseEvents ?? this.newReleaseEvents,
      userEvents      : userEvents ?? this.userEvents,
    );
  }
}