abstract class BaseApiService {
  Future getGetApiResponse(String url, {Map<String, String> requestHeaders});
  Future getPostApiResponse(String url,
      {dynamic data, Map<String, String> requestHeaders});
  Future getPutApiResponse(String url,
      {dynamic data, Map<String, String> requestHeaders});
  Future getDeleteApiResponse(String url,
      {dynamic data, Map<String, String> requestHeaders});
}
