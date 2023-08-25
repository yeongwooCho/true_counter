extension InputValidate on String {
  // 이메일 포맷 검증
  bool isValidEmailFormat() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  // 패스워드 포맷 검증: '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.'
  bool isValidPasswordFormat() {
    return RegExp(
            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$')
        .hasMatch(this);
  }

  // 대쉬를 포함하는 010 휴대폰 번호 포맷 검증 (010-1234-5678)
  bool isValidPhoneNumberFormat() {
    return RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$').hasMatch(this);
  }
}
