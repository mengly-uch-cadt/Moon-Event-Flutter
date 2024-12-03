import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

String hashPassword(String password) {
  final bytes = utf8.encode(password); 
  final hased = sha256.convert(bytes); 
  return hased.toString(); 
}