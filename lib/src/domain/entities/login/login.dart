class Login {
  final String tokenType;
  final String scope;
  final int expiresIn;
  final int extExpiresIn;
  final String accessToken;
  final String refreshToken;
  final String idToken;

  const Login({
    this.tokenType = '',
    this.scope = '',
    this.expiresIn = 0,
    this.extExpiresIn = 0,
    this.accessToken = '',
    this.refreshToken = '',
    this.idToken = '',
  });
}
