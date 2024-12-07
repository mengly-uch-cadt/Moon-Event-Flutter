
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_event/model/event.dart';
import 'package:moon_event/utils/response_result_util.dart';

class EventService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Future<List<Event>> getEvents() async {
  //   // Fetch events from the server
  // }
  Future<ResponseResult> createEvent(Event event) async {
    try{
      await _firestore.collection('events').doc(event.eventId).set(event.toMap());
      return ResponseResult.success(
        data: event,
        message: 'Event created successfully',
      );
    } catch (e) {
      return ResponseResult.failure(
        message: e.toString(),
      );
    }
  }
}