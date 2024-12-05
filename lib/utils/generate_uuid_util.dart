import 'package:uuid/uuid.dart';

String generateUuid() {
  var uuid = const Uuid();
  return uuid.v4(); 
}