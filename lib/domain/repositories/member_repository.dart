
abstract class MemberRepository {
  Future<String> login(String provider, String accessToken);
  Future<void> resign(String provider, [Map<String, String>? additional]);
}