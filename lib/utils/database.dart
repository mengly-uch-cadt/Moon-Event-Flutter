import 'package:mysql1/mysql1.dart';

class Database {
  static Future<MySqlConnection> connect() async {
    final settings = ConnectionSettings(
      host: 'sql12.freemysqlhosting.net', // Use explicit IP for XAMPP
      port: 3306,
      user: 'sql12749268',
      password: '4kLyMjyGRw', // Use the exact password (or leave blank if none)
      db: 'sql12749268',
    );
    return await MySqlConnection.connect(settings);
  }
}
