class TransactionResponse<T> {
  final String? error;
  final T? data;

  TransactionResponse.success({
    this.data,
  }) : error = null;

  TransactionResponse.fail({
    required this.error,
  }) : data = null;
}
