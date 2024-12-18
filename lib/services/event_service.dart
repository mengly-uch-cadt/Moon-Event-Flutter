
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moon_event/model/category.dart';
import 'package:moon_event/model/event.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/utils/response_result_util.dart';

class EventService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

  Future<ResponseResult> updateEvent(Map<String, dynamic> event) async {
    try {
      await _firestore.collection('events').doc(event['eventUuid']).update(event);
      return ResponseResult.success(
        data: event,
        message: 'Event updated successfully',
      );
    } catch (e) {
      return ResponseResult.failure(
        message: e.toString(),
      );
    }
  }

  Future<ResponseResult> getEvents({
    bool isAllEvents = false, 
    bool isPopularEvents = false,
    bool isNewReleaseEvents = false
  }) async {
    try {
      QuerySnapshot? eventSnapshot;

      // Fetch all categories once to map them
      QuerySnapshot categorySnapshot = await _firestore.collection('categories').get();
      Map<String, Category> categoryMap = {
        for (var doc in categorySnapshot.docs)
          doc.id: Category.fromMap(doc.data() as Map<String, dynamic>, doc.id),
      };

      // Fetch events based on `isAllEvents` flag
      if (isAllEvents || isPopularEvents) {
        DateTime now = DateTime.now();
        DateTime todayStart = DateTime(now.year, now.month, now.day);
        eventSnapshot = await _firestore.collection('events')
          .where("isPublic", isEqualTo: true)
          .where("date", isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
          .get();
      } 

      else if(isNewReleaseEvents){
        DateTime now = DateTime.now();
        DateTime todayStart = DateTime(now.year, now.month, now.day);

        eventSnapshot = await _firestore.collection('events')
          .where("isPublic", isEqualTo: true)
          .where("date", isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
          .orderBy("date", descending: false)
          .limit(15)
          .get();
      }


      // Map events with their associated categories
      List<GetEvent> events = eventSnapshot!.docs.map((doc) {
        Map<String, dynamic> eventData = doc.data() as Map<String, dynamic>;
        String categoryId = eventData['categoryId'];
        // Find the matching category from the categoryMap
        Category category = categoryMap[categoryId]!;
        // Convert event data to a `GetEvent` object
        return GetEvent(
          eventUuid             : eventData['eventUuid'],
          title                 : eventData['title'],
          description           : eventData['description'],
          date                  : eventData['date'],
          startTime             : eventData['startTime'],
          endTime               : eventData['endTime'],
          location              : eventData['location'],
          imageUrl              : eventData['imageUrl'],
          organizerId           : eventData['organizerId'],
          participantsRegistered: List<String>.from(eventData['participantsRegistered']),
          participantsJoined    : List<String>.from(eventData['participantsJoined']),
          isPublic              : eventData['isPublic'],
          category              : category,
        );
      }).toList();
      
      if(isPopularEvents){
        List<GetEvent> sortedEvents = List<GetEvent>.from(events);
        sortedEvents.sort((a, b) => b.participantsRegistered.length.compareTo(a.participantsRegistered.length));

        // Store the top 15 sorted events back into the original list
          events = sortedEvents.take(15).toList();
      }
      return ResponseResult.success(
        // data: null,
        data: events,
        message: 'Events fetched successfully',
      );
    } catch (e) {
      return ResponseResult.failure(
        message: e.toString(),
      );
    }
  }

  Future<ResponseResult> getEventsByUserUid() async {
    try {
      User? user = _auth.currentUser;
      QuerySnapshot eventSnapshot = await _firestore.collection('events')
        .where('organizerId', isEqualTo: user!.uid)
        .get();

      if(eventSnapshot.docs.isEmpty){
        return ResponseResult.success(
          data: [],
          message: 'No events found',
        );
      }
      
      // Fetch all categories once to map them
      QuerySnapshot categorySnapshot = await _firestore.collection('categories').get();
      Map<String, Category> categoryMap = {
        for (var doc in categorySnapshot.docs)
          doc.id: Category.fromMap(doc.data() as Map<String, dynamic>, doc.id),
      };

      // Map events with their associated categories
      List<GetEvent> events = eventSnapshot.docs.map((doc) {
        Map<String, dynamic> eventData = doc.data() as Map<String, dynamic>;
        String categoryId = eventData['categoryId'];
        // Find the matching category from the categoryMap
        Category category = categoryMap[categoryId]!;
        // Convert event data to a `GetEvent` object
        return GetEvent(
          eventUuid             : eventData['eventUuid'],
          title                 : eventData['title'],
          description           : eventData['description'],
          date                  : eventData['date'],
          startTime             : eventData['startTime'],
          endTime               : eventData['endTime'],
          location              : eventData['location'],
          imageUrl              : eventData['imageUrl'],
          organizerId           : eventData['organizerId'],
          participantsRegistered: List<String>.from(eventData['participantsRegistered']),
          participantsJoined    : List<String>.from(eventData['participantsJoined']),
          isPublic              : eventData['isPublic'],
          category              : category,
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

  Future<ResponseResult> registerEvent(String eventId) async {
    try {
      // Get the current user
      User? user = _auth.currentUser;
      if (user == null) {
        return ResponseResult.failure(
          message: 'You must be logged in to attend an event.',
        );
      }

      DocumentReference eventRef = _firestore.collection('events').doc(eventId);

      // Run a Firestore transaction to safely handle the update
      return await _firestore.runTransaction((transaction) async {
        DocumentSnapshot eventSnapshot = await transaction.get(eventRef);

        if (!eventSnapshot.exists) {
          return ResponseResult.failure(
            message: 'The event does not exist.',
          );
        }

        // Extract event details
        Map<String, dynamic> eventData = eventSnapshot.data() as Map<String, dynamic>;
        List participantsRegistered = eventData['participantsRegistered'] ?? [];
        String startTimeStr = eventData['startTime'];
        DateTime eventDate = (eventData['date'] as Timestamp).toDate();

        // Combine eventDate and startTime
        DateTime eventStartTime = DateTime(
          eventDate.year,
          eventDate.month,
          eventDate.day,
          int.parse(startTimeStr.split(':')[0]),
          int.parse(startTimeStr.split(':')[1].split(' ')[0]),
        );

        DateTime now = DateTime.now();

        // Check if the user is already registered
        if (participantsRegistered.contains(user.uid)) {
          return ResponseResult.failure(
            message: 'You are already marked as registerd this event.',
          );
        }

        // Check if the event has already started
        if (now.isAfter(eventStartTime)) {
          return ResponseResult.failure(
            message: 'You cannot register for an event that has already started.',
          );
        }

        // Add the user to participantsRegistered
        participantsRegistered.add(user.uid);

        // Update the participantsRegistered field in the database
        transaction.update(eventRef, {'participantsRegistered': participantsRegistered});

        return ResponseResult.success(
          data: null,
          message: 'You have successfully RSVP for "${eventData['title']}". We look forward to seeing you!',
        );
      });
    } catch (e) {
      return ResponseResult.failure(
        message: 'An error occurred: ${e.toString()}',
      );
    }
  }

  Future<ResponseResult> joinEvent(String eventId) async {
    try {
      // Get the current user
      User? user = _auth.currentUser;
      if (user == null) {
        return ResponseResult.failure(
          message: 'You must be logged in to join an event.',
        );
      }

      DocumentReference eventRef = _firestore.collection('events').doc(eventId);

      // Run a Firestore transaction
      return await _firestore.runTransaction((transaction) async {
        DocumentSnapshot eventSnapshot = await transaction.get(eventRef);

        if (!eventSnapshot.exists) {
          return ResponseResult.failure(
            message: 'The event does not exist.',
          );
        }

        // Extract event details
        Map<String, dynamic> eventData = eventSnapshot.data() as Map<String, dynamic>;
        List participantsJoined = eventData['participantsJoined'] ?? [];
        String endTimeStr = eventData['endTime'];
        DateTime eventDate = (eventData['date'] as Timestamp).toDate();

        // Combine eventDate and endTime
        DateTime eventEndTime = DateTime(
          eventDate.year,
          eventDate.month,
          eventDate.day,
          int.parse(endTimeStr.split(':')[0]),
          int.parse(endTimeStr.split(':')[1].split(' ')[0]),
        );

        DateTime now = DateTime.now();

        // Check if the user is already joined
        if (participantsJoined.contains(user.uid)) {
          return ResponseResult.failure(
            message: 'You have already joined this event.',
          );
        }

        // Check if the event has already ended
        if (now.isAfter(eventEndTime)) {
          return ResponseResult.failure(
            message: 'You cannot join an event that has already ended.',
          );
        }

        // Add the user to participantsJoined
        participantsJoined.add(user.uid);

        // Update the participantsJoined field in the database
        transaction.update(eventRef, {'participantsJoined': participantsJoined});

        return ResponseResult.success(
          data: null,
          message: 'You have successfully joined "${eventData['title']}". Enjoy the event!',
        );
      });
    } catch (e) {
      return ResponseResult.failure(
        message: 'An error occurred: ${e.toString()}',
      );
    }
  }

  Future<ResponseResult> getEventById(String eventId) async {
    try {
      DocumentSnapshot eventSnapshot = await _firestore.collection('events').doc(eventId).get();
      if(!eventSnapshot.exists){
        return ResponseResult.failure(
          message: 'Event not found',
        );
      }

      // Fetch all categories once to map them
      QuerySnapshot categorySnapshot = await _firestore.collection('categories').get();
      Map<String, Category> categoryMap = {
        for (var doc in categorySnapshot.docs)
          doc.id: Category.fromMap(doc.data() as Map<String, dynamic>, doc.id),
      };

      Map<String, dynamic> eventData = eventSnapshot.data() as Map<String, dynamic>;
      String categoryId = eventData['categoryId'];
      Category category = categoryMap[categoryId]!;

      GetEvent event = GetEvent(
        eventUuid             : eventData['eventUuid'],
        title                 : eventData['title'],
        description           : eventData['description'],
        date                  : eventData['date'],
        startTime             : eventData['startTime'],
        endTime               : eventData['endTime'],
        location              : eventData['location'],
        imageUrl              : eventData['imageUrl'],
        organizerId           : eventData['organizerId'],
        participantsRegistered: List<String>.from(eventData['participantsRegistered']),
        participantsJoined    : List<String>.from(eventData['participantsJoined']),
        isPublic              : eventData['isPublic'],
        category              : category,
      );

      return ResponseResult.success(
        data: event,
        message: 'Event fetched successfully',
      );

    } catch (e) {
      return ResponseResult.failure(
        message: e.toString(),
      );
    }
  }

  Future<ResponseResult> getRegisterEvents() async {
    try {
      User? user = _auth.currentUser;
      DateTime now = DateTime.now();
      DateTime todayStart = DateTime(now.year, now.month, now.day);

      QuerySnapshot eventSnapshot = await _firestore.collection('events')
        .where('participantsRegistered', arrayContains: user!.uid)
        .where('isPublic', isEqualTo: true)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
        .orderBy('date', descending: false)
        .get();

      // Fetch all categories once to map them
      QuerySnapshot categorySnapshot = await _firestore.collection('categories').get();
      Map<String, Category> categoryMap = {
        for (var doc in categorySnapshot.docs)
          doc.id: Category.fromMap(doc.data() as Map<String, dynamic>, doc.id),
      };

      if (eventSnapshot.docs.isEmpty) {
        return ResponseResult.success(
          data: [],
          message: 'No events found',
        );
      }

      // Map events with their associated categories
      List<GetEvent> events = eventSnapshot.docs.map((doc) {
        Map<String, dynamic> eventData = doc.data() as Map<String, dynamic>;
        String categoryId = eventData['categoryId'];
        // Find the matching category from the categoryMap
        Category category = categoryMap[categoryId]!;
        // Convert event data to a `GetEvent` object
        return GetEvent(
          eventUuid             : eventData['eventUuid'],
          title                 : eventData['title'],
          description           : eventData['description'],
          date                  : eventData['date'],
          startTime             : eventData['startTime'],
          endTime               : eventData['endTime'],
          location              : eventData['location'],
          imageUrl              : eventData['imageUrl'],
          organizerId           : eventData['organizerId'],
          participantsRegistered: List<String>.from(eventData['participantsRegistered']),
          participantsJoined    : List<String>.from(eventData['participantsJoined']),
          isPublic              : eventData['isPublic'],
          category              : category,
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

  Future<ResponseResult> getJoinedEvents() async{
    try {
      User? user = _auth.currentUser;
      QuerySnapshot eventSnapshot = await _firestore.collection('events')
        .where('participantsJoined', arrayContains: user!.uid)
        .where('isPublic', isEqualTo: true)
        .orderBy('date', descending: true)
        .get();

      // Fetch all categories once to map them
      QuerySnapshot categorySnapshot = await _firestore.collection('categories').get();
      Map<String, Category> categoryMap = {
        for (var doc in categorySnapshot.docs)
          doc.id: Category.fromMap(doc.data() as Map<String, dynamic>, doc.id),
      };

      if (eventSnapshot.docs.isEmpty) {
        return ResponseResult.success(
          data: [],
          message: 'No events found',
        );
      }

      // Map events with their associated categories
      List<GetEvent> events = eventSnapshot.docs.map((doc) {
        Map<String, dynamic> eventData = doc.data() as Map<String, dynamic>;
        String categoryId = eventData['categoryId'];
        // Find the matching category from the categoryMap
        Category category = categoryMap[categoryId]!;
        // Convert event data to a `GetEvent` object
        return GetEvent(
          eventUuid             : eventData['eventUuid'],
          title                 : eventData['title'],
          description           : eventData['description'],
          date                  : eventData['date'],
          startTime             : eventData['startTime'],
          endTime               : eventData['endTime'],
          location              : eventData['location'],
          imageUrl              : eventData['imageUrl'],
          organizerId           : eventData['organizerId'],
          participantsRegistered: List<String>.from(eventData['participantsRegistered']),
          participantsJoined    : List<String>.from(eventData['participantsJoined']),
          isPublic              : eventData['isPublic'],
          category              : category,
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