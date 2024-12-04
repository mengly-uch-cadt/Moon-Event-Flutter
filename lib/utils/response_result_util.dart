class ResponseResult<T> {
  final bool isSuccess;
  final String message;
  final T? data;

  ResponseResult._({required this.isSuccess, required this.message, this.data});

  factory ResponseResult.success({required T data, required String message}) => ResponseResult._(isSuccess: true, message: message, data: data);
  factory ResponseResult.failure({required String message}) => ResponseResult._(isSuccess: false, message: message, data: null);
}

