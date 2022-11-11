class ApiError {
  String _error = "";

  ApiError({required String error}) {
    _error = error;
  }

  // ignore: unnecessary_getters_setters
  String get error => _error;

  set error(String error) => _error = error;

  ApiError.fromJson(Map<String, dynamic> json) {
    _error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = _error;
    return data;
  }
}
