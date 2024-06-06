abstract class AppConfig {
  String get baseUrl;
}

class AppConfigDev extends AppConfig {
  @override
  String get baseUrl => 'https://jsonplaceholder.typicode.com';
}
