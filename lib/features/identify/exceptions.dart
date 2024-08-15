class IdentitfyException implements Exception {
  String message;
  IdentitfyException(this.message);

  @override
  String toString() => message;
}

class IdentifyEmptyImageException implements Exception {
  String message;
  IdentifyEmptyImageException(this.message);

  @override
  String toString() => message;
}

class IdentifyImageDiscardedException implements Exception {
  String message;
  IdentifyImageDiscardedException(this.message);

  @override
  String toString() => message;
}

class IdentifyApiException implements Exception {
  String message;
  IdentifyApiException(this.message);

  @override
  String toString() => message;
}
