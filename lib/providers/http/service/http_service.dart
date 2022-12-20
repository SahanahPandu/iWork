class HttpService {
  /// Base url
  final Uri baseUrl = (Uri.parse('http://10.0.2.2:8000/'));

  /// Login url
  final Uri loginUrl = (Uri.parse('http://10.0.2.2:8000/api/login'));

  /// Logout url
  final Uri logoutUrl = (Uri.parse('http://10.0.2.2:8000/api/logout'));

  /// Update Device Id url
  final Uri updateIDUrl =
      (Uri.parse('http://10.0.2.2:8000/api/update_device_id'));

  /// Task Schedules
  /// Below is task schedule data extraction for Compactor Panel
  final Uri loadCompactorTaskUrl =
      (Uri.parse('http://10.0.2.2:8000/api/task/vehicle/details'));

  final loadCompactorTaskUrlTest =
      'http://10.0.2.2:8000/api/task/vehicle/details';
}
