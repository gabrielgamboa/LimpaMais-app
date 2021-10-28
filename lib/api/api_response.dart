class ApiResponse<T> {
  bool? ok;
  String? message;
  T? result;

  //construtor nomeado
  ApiResponse.ok(this.result) {
    ok = true;
  }

  //construtor nomeado
  ApiResponse.error(this.message) {
    ok = false;
  }
}