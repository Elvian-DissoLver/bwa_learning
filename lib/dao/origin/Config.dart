import 'package:mysql1/mysql1.dart';

class Config {

  static final Config conn = Config();

  Future<MySqlConnection> mysqlConfiguration() async {
    print('conInit');

    final conn = await MySqlConnection.connect(new ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        password: 'root',
        db: 'test'));

    print('conConnect');

    return conn;
  }
}