class ApiResponse {
  /// _data will hold any response converted into its own object.
  /// For example user for authenticate purpose.
  late Object _data;

  /// _apiError will hold the error object
  late Object _apiError;

  // ignore: unnecessary_getters_setters
  Object get data => _data;

  set data(Object data) => _data = data;

  // ignore: unnecessary_getters_setters
  Object get apiError => _apiError;

  set apiError(Object error) => _apiError = error;
}
