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

class TextValidator {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      // return '이메일을 입력 해주세요';
      return null;
    }

    if (!value.isValidEmailFormat()) {
      return '알맞은 이메일 형식을 입력 해주세요.';
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      // return '값을 입력해주세요';
      return null;
    }

    if (!value.isValidPasswordFormat()) {
      return '영문,숫자,특수문자 포함 8~15자로 입력 해주세요.';
    }

    return null;
  }

  static String? passwordCheckValidator(String? previousValue, String? value) {
    if (value == null || value.isEmpty) {
      // return '값을 입력해주세요';
      return null;
    }

    if (value != previousValue) {
      return '비밀번호가 일치하지 않습니다.';
    }

    return null;
  }
}
