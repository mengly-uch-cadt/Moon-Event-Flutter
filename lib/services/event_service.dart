
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_event/model/category.dart';
import 'package:moon_event/model/event.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/services/category_service.dart';
import 'package:moon_event/utils/response_result_util.dart';

class EventService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 
  Future<ResponseResult> createEvent(Event event) async {
    try{
      await _firestore.collection('events').doc(event.eventUuid).set(event.toMap());
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

  // Future<ResponseResult> getEvents({bool isAllEvents = false,}) async {
  //   try {
  //     QuerySnapshot querySnapshot;
  //     if (isAllEvents) {
  //       querySnapshot = await _firestore.collection('events')
  //       .where("isPublic", isEqualTo: true)
  //       .get();
  //     } 
  //     // else if (!isAllEvents) {
  //     //   querySnapshot = await _firestore.collection('events')
  //     //   .where("isPublic", isEqualTo: false)
  //     //   .get();
  //     // }

  //     else {
  //       querySnapshot = await _firestore.collection('events').get();
  //     }

  //     List<GetEvent> events = querySnapshot.docs.map((doc) => GetEvent.fromMap(doc.data() as Map<String, dynamic>)).toList();
  //     return ResponseResult.success(
  //       data: events,
  //       message: 'Events fetched successfully',
  //     );
  //   } catch (e) {
  //     return ResponseResult.failure(
  //       message: e.toString(),
  //     );
  //   }
  // }
  Future<ResponseResult> getEvents({bool isAllEvents = false}) async {
    try {
      print("===========================================  ");
      print("Get events");
      print("===========================================  ");
      QuerySnapshot eventSnapshot;

      // Fetch all categories once to map them
      QuerySnapshot categorySnapshot = await _firestore.collection('categories').get();
      Map<String, Category> categoryMap = {
        for (var doc in categorySnapshot.docs)
          doc.id: Category.fromMap(doc.data() as Map<String, dynamic>, doc.id),
      };

      // Fetch events based on `isAllEvents` flag
      if (isAllEvents) {
        eventSnapshot = await _firestore.collection('events')
            .where("isPublic", isEqualTo: true)
            .get();
      } else {
        eventSnapshot = await _firestore.collection('events').get();
      }


      // Map events with their associated categories
      List<GetEvent> events = eventSnapshot.docs.map((doc) {
        Map<String, dynamic> eventData = doc.data() as Map<String, dynamic>;
        String categoryId = eventData['categoryId'];
        // Find the matching category from the categoryMap
        Category category = categoryMap[categoryId]!;

        print("===========================================  ");
        print(categoryId);
        print("===========================================  ");
        print("Event data");
        print("eventUuid: ${eventData['eventUuid']}");
        print("description: ${eventData['description']}");
        print("title: ${eventData['title']}");
        print("date: ${eventData['date']}");
        print("time: ${eventData['time']}");
        print("location: ${eventData['location']}");
        print("imageUrl: ${eventData['imageUrl']}");
        print("organizerId: ${eventData['organizerId']}");
        print("participants: ${eventData['participants']}");
        print("isPublic: ${eventData['isPublic']}");
        print("category name: ${category.category}");
        print("category id : ${category.uuid}");
        print("category icon : ${category.icon}");
        print("===========================================  ");
        
        // Convert event data to a `GetEvent` object
        return GetEvent(
          eventUuid: eventData['eventUuid'],
          title: eventData['title'],
          description: eventData['description'],
          date: eventData['date'],
          time: eventData['time'],
          location: eventData['location'],
          imageUrl: eventData['imageUrl'],
          organizerId: eventData['organizerId'],
          participants: List<String>.from(eventData['participants']),
          isPublic: eventData['isPublic'],
          category: category,
        );
      }).toList();



      return ResponseResult.success(
        data: events,
        message: 'Events fetched successfully',
      );
    } catch (e) {
      return ResponseResult.failure(
        message: e.toString(),
      );
    }
  }

}