enum SignUpType {
  none('NONE'),
  email('EMAIL'),
  kakao('KAKAO'),
  apple('APPLE');

  const SignUpType(this.label);

  final String label;

  static getType({required String type}) {
    switch (type) {
      case 'EMAIL':
        return SignUpType.email;
      case 'KAKAO':
        return SignUpType.kakao;
      case 'APPLE':
        return SignUpType.apple;
      default:
        return SignUpType.none;
    }
  }
}
