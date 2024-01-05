Map<String, String> getHeaders(String token) {
  Map<String, String> header = {};
  header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  return header;
}