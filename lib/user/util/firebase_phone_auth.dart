import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:true_counter/common/util/custom_toast.dart';

class FirebasePhoneAuthUtil {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId; // 폰 인증 요청 시 callback 받는 값이며 smsCode 와 같이 인증에 쓰임.

  FirebasePhoneAuthUtil();

  // 유효한 휴대폰 번호 보장.
  Future<void> requestSmsCode({
    required BuildContext context,
    required String phone,
  }) async {
    bool isSuccess = false;

    String refinePhone = phone.trim().replaceFirst('010', '+8210');
    print(refinePhone);

    await _auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (
        String verificationId,
      ) {
        // Auto-resolution timed out...
      },
      phoneNumber: refinePhone,
      verificationCompleted: (
        phoneAuthCredential,
      ) async {
        print("otp 문자옴");
      },
      verificationFailed: (
        verificationFailed,
      ) async {
        print(verificationFailed.code);
        print("코드발송실패");
      },
      codeSent: (
        verificationId,
        resendingToken,
      ) async {
        print("코드보냄");

        showCustomToast(
          context,
          msg: '인증코드를 발송하였습니다.\n잠시만 기다려 주세요.',
        );
        this.verificationId = verificationId;
      },
    );
  }

  Future<bool> verifyUser({
    required String smsCode,
  }) async {
    if (verificationId == null || verificationId!.isEmpty) {
      await Fluttertoast.showToast(
        msg: "No VerificationId",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        fontSize: 16.0,
      );
      return false;
    }

    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );

    bool isSuccess = await _signInWithPhoneAuthCredential(
      phoneAuthCredential: phoneAuthCredential,
    );

    return isSuccess;
  }

  Future<bool> _signInWithPhoneAuthCredential({
    required PhoneAuthCredential phoneAuthCredential,
  }) async {
    try {
      UserCredential authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      // 유저가 생성되면 휴대폰 번호는 유효한 것이다.
      if (authCredential.user != null) {
        // 유효 함이 확인 되면 유저를 삭제 시킨다.
        await _auth.currentUser?.delete();
        print("auth정보삭제");

        // Firebase Auth 를 로그아웃 한다.
        _auth.signOut();
        print("phone로그인된것 로그아웃");
      }
      return true;
    } on FirebaseAuthException catch (e) {
      await Fluttertoast.showToast(
        msg: "${e.message}",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        fontSize: 16.0,
      );

      return false;
    }
  }
}

class PhoneAuthTest extends StatefulWidget {
  const PhoneAuthTest({super.key});

  @override
  State<PhoneAuthTest> createState() => _PhoneAuthTestState();
}

class _PhoneAuthTestState extends State<PhoneAuthTest> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  TextEditingController phoneNumberController1 = TextEditingController();
  TextEditingController phoneNumberController2 = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  FocusNode verifyPasswordFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode1 = FocusNode();
  FocusNode phoneNumberFocusNode2 = FocusNode();
  FocusNode otpFocusNode = FocusNode();

  bool authOk = false;

  bool passwordHide = true;
  bool requestedAuth = false;
  late String verificationId;
  bool showLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential?.user != null) {
        setState(() {
          print("인증완료 및 로그인성공");
          authOk = true;
          requestedAuth = false;
        });
        await _auth.currentUser?.delete();
        print("auth정보삭제");
        _auth.signOut();
        print("phone로그인된것 로그아웃");
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        print("인증실패..로그인실패");
        showLoading = false;
      });

      await Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          fontSize: 16.0);
    }
  }

  Future<UserCredential?> signUpUserCredential({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      void errorToast(String message) {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            fontSize: 16.0);
      }

      // switch (e.code) {
      switch (e) {
        case "email-already-in-use":
          errorToast("이미 사용중인 이메일입니다");

          break;
        case "invalid-email":
          errorToast("잘못된 이메일 형식입니다");
          break;
        case "operation-not-allowed":
          errorToast("사용할 수 없는 방식입니다");

          break;
        case "weak-password":
          errorToast("비밀번호 보안 수준이 너무 낮습니다");

          break;
        default:
          errorToast("알수없는 오류가 발생했습니다");
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Firebase 폰인증 꼼수'),
        ),
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(flex: 1, child: Text("이메일")),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              isDense: true,
                              hintText: "이메일 입력",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(passwordFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(flex: 1, child: Text("비밀번호")),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              isDense: true,
                              hintText: "비밀번호 입력",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(verifyPasswordFocusNode),
                            focusNode: passwordFocusNode,
                            obscureText: passwordHide,
                            controller: passwordController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(flex: 1, child: Text("")),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              isDense: true,
                              hintText: "비밀번호 재입력",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            focusNode: verifyPasswordFocusNode,
                            obscureText: passwordHide,
                            controller: verifyPasswordController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(flex: 1, child: Text("휴대폰")),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: numberInsert(
                                      editAble: false,
                                      hintText: "010",
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: numberInsert(
                                    editAble: authOk ? false : true,
                                    hintText: "0000",
                                    focusNode: phoneNumberFocusNode1,
                                    controller: phoneNumberController1,
                                    textInputAction: TextInputAction.next,
                                    maxLength: 4,
                                    widgetFunction: () {
                                      FocusScope.of(context)
                                          .requestFocus(phoneNumberFocusNode2);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: numberInsert(
                                    editAble: authOk ? false : true,
                                    hintText: "0000",
                                    focusNode: phoneNumberFocusNode2,
                                    controller: phoneNumberController2,
                                    textInputAction: TextInputAction.done,
                                    maxLength: 4,
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 5,
                            ),
                            authOk
                                ? ElevatedButton(
                                    onPressed: () {},
                                    child: Text("인증완료"),
                                  )
                                : phoneNumberController1.text.length == 4 &&
                                        phoneNumberController2.text.length == 4
                                    ? ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            showLoading = true;
                                          });
                                          await _auth.verifyPhoneNumber(
                                            timeout:
                                                const Duration(seconds: 60),
                                            codeAutoRetrievalTimeout: (
                                              String verificationId,
                                            ) {
                                              // Auto-resolution timed out...
                                            },
                                            phoneNumber: "+8210" +
                                                phoneNumberController1.text
                                                    .trim() +
                                                phoneNumberController2.text
                                                    .trim(),
                                            verificationCompleted: (
                                              phoneAuthCredential,
                                            ) async {
                                              print("otp 문자옴");
                                            },
                                            verificationFailed: (
                                              verificationFailed,
                                            ) async {
                                              print(verificationFailed.code);

                                              print("코드발송실패");
                                              setState(() {
                                                showLoading = false;
                                              });
                                            },
                                            codeSent: (
                                              verificationId,
                                              resendingToken,
                                            ) async {
                                              print("코드보냄");
                                              Fluttertoast.showToast(
                                                msg:
                                                    "010-${phoneNumberController1.text}-${phoneNumberController2.text} 로 인증코드를 발송하였습니다. 문자가 올때까지 잠시만 기다려 주세요.",
                                                toastLength: Toast.LENGTH_SHORT,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                fontSize: 12.0,
                                              );
                                              setState(() {
                                                requestedAuth = true;
                                                FocusScope.of(context)
                                                    .requestFocus(otpFocusNode);
                                                showLoading = false;
                                                this.verificationId =
                                                    verificationId;
                                              });
                                            },
                                          );
                                        },
                                        child: Text("인증요청"))
                                    : ElevatedButton(
                                        onPressed: () {},
                                        child: Text("인증요청"),
                                      ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  authOk
                      ? SizedBox()
                      : Visibility(
                          visible: requestedAuth,
                          child: Row(
                            children: [
                              Expanded(flex: 1, child: Text("")),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: numberInsert(
                                        editAble: true,
                                        hintText: "6자리 입력",
                                        focusNode: otpFocusNode,
                                        controller: otpController,
                                        textInputAction: TextInputAction.done,
                                        maxLength: 6,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          PhoneAuthCredential
                                              phoneAuthCredential =
                                              PhoneAuthProvider.credential(
                                                  verificationId:
                                                      verificationId,
                                                  smsCode: otpController.text);

                                          signInWithPhoneAuthCredential(
                                              phoneAuthCredential);
                                        },
                                        child: Text("확인")),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Text('가입하기'),
                    onPressed: () async {
                      if (emailController.text.length > 1 &&
                          passwordController.text.length > 1 &&
                          verifyPasswordController.text.length > 1) {
                        if (passwordController.text ==
                            verifyPasswordController.text) {
                          if (authOk) {
                            setState(() {
                              showLoading = true;
                            });

                            await signUpUserCredential(
                                email: emailController.text,
                                password: passwordController.text);

                            setState(() {
                              showLoading = false;
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "휴대폰 인증을 완료해주세요.",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                fontSize: 16.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "비밀번호를 확인해 주세요.",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              fontSize: 16.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "이메일 및 비밀번호를 입력해 주세요.",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            fontSize: 16.0);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        minimumSize: Size(double.infinity, 0),
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Visibility(
                  visible: showLoading,
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 80,
                              color: Colors.white,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator()),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("잠시만 기다려 주세요"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Opacity(
                                    opacity: 0,
                                    child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator()),
                                  ),
                                ],
                              )))))),
            )
          ],
        ));
  }

  Widget numberInsert({
    bool? editAble,
    String? hintText,
    FocusNode? focusNode,
    TextEditingController? controller,
    TextInputAction? textInputAction,
    Function? widgetFunction,
    int? maxLength,
  }) {
    return TextFormField(
      enabled: editAble,
      style: TextStyle(
        fontSize: 12,
      ),
      decoration: InputDecoration(
        contentPadding:
            new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        isDense: true,
        counterText: "",
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      textInputAction: textInputAction,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      focusNode: focusNode,
      controller: controller,
      maxLength: maxLength,
      onChanged: (value) {
        if (maxLength != null && value.length >= maxLength) {
          if (widgetFunction == null) {
            print("noFunction");
          } else {
            widgetFunction();
          }
        }
        setState(() {});
      },
      onEditingComplete: () {
        if (widgetFunction == null) {
          print("noFunction");
        } else {
          widgetFunction();
        }
      },
    );
  }
}
