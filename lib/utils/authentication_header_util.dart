import 'dart:convert';

class AuthenticatorHeaderUtil {
  static String basicAuth(String clientId, String clientSecret) =>
      'Basic ${base64.encode(utf8.encode('$clientId:$clientSecret'))}';

  static String baererAuth(String baerer) => 'Baerer $baerer';
}
