abstract final class ApiPaths {
  // Auth

  static const String servicePath = 'https://api.replicate.com/v1/predictions';

  static const String login = '/login';
  static const String logout = '/logout';
  static const String renewAccessToken = '/renewToken';
  static const String registerPushToken = '/registerPushToken';

  static const String movies = '/movies';
  static const String movie = '/movies/:id';

  static const String groups = '/groups';
}
