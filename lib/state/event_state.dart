
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/get_event.dart';

class EventNotifier extends StateNotifier<EventState> {
  EventNotifier() : super(EventState());

  void setAllEventData(List<GetEvent> eventData) {
    state = state.copyWith(isAllEvents: eventData);
  }

  void clearAllEventData() {
    state = state.copyWith(isAllEvents: null);
  }


}

final eventProvider = StateNotifierProvider<EventNotifier, EventState>((ref) {
  return EventNotifier();
});


class EventState{
  final List<GetEvent>? isAllEvents;

  EventState({this.isAllEvents});

  EventState copyWith({
    List<GetEvent>? isAllEvents,
  }) {
    return EventState(
      isAllEvents: isAllEvents ?? this.isAllEvents,
    );
  }
}