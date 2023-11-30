// ignore_for_file: public_member_api_docs, sort_constructors_first
class NetworkResponse {
  final int? statusCode;
  final bool isSuccess;
  final dynamic jsonResponse;
  final String? errorMessage;
  NetworkResponse({
    this.statusCode = -1,
    required this.isSuccess,
    this.jsonResponse,
    this.errorMessage = 'Something went wrong',
  });
}
