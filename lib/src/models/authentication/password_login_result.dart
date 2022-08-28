class PasswordLoginResult {
  String? email, displayName, refreshToken, type;
  int? token;

  PasswordLoginResult({
    this.email,
    this.displayName,
    this.token,
    this.type,
  });
}