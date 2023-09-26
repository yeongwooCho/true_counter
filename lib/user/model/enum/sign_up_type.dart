enum SignUpType {
  email('EMAIL'),
  kakao('KAKAO'),
  apple('APPLE');

  const SignUpType(this.label);

  final String label;
}
