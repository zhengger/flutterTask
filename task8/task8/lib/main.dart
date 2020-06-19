import 'package:flutter/material.dart';
import 'package:task8/personalData.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginWidget(),
    );
  }
}

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.validator,
  });

  final Key fieldKey;
  final String helperText;
  final String hintText;
  final String labelText;
  final FormFieldValidator<String> validator;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      cursorColor: Theme.of(context).cursorColor,
      maxLength: 8,
      validator: widget.validator,
      //TODO onSaved
      onSaved: (newValue) {},
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.lock),
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}

class LoginFormState extends State<LoginForm> {
  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PersonalData personalData =
      PersonalData(name: "hello", password: "123456");
  static const period = Duration(seconds: 1);
  int _ticker = 60;

  int _counter = 3;

  void showInSnackBar(String value) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true;

      setState(() {
        _counter--;
        // _ticker = 5-timer.tick;
        print(_ticker);
      });
      // Start validating on every change.
      showInSnackBar(
        "登录前请先修复红色提示错误! 您还有$_counter次机会",
      );
      if (_counter <= 0) {
        Timer.periodic(period, (timer) {
          //到时回调
          print('afterTimer=' + DateTime.now().toString());
          setState(() {
            _ticker--;
          });
          if (_ticker == 0) {
            //取消定时器，避免无限回调
            timer.cancel();
            timer = null;
            _counter = 3;
          }
        });
      }
    } else {
      form.save();
      _counter = 3; // state saved
      showInSnackBar("登录成功");
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return "账号不能为空";
    }
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return "账号只能是英文字母";
    } else if (personalData.name != value) {
      return "账号不匹配";
    }
    return null;
  }

  String __validatePassword(String value) {
    if (value.isEmpty) {
      return "密码不能为空";
    } else if (personalData.password != value) {
      return "密码不匹配";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cursorColor = Theme.of(context).cursorColor;
    const sizedBoxSpace = SizedBox(height: 24);

    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 96),
                TextFormField(
                  cursorColor: cursorColor,
                  decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.person),
                    hintText: "hello",
                    labelText: "请输入登录账号*",
                  ),
                  validator: _validateName,
                ),
                sizedBoxSpace,
                PasswordField(
                  helperText: "密码长度不超过8位",
                  labelText: "请输入登录密码*",
                  validator: __validatePassword,
                ),
                sizedBoxSpace,
                Expanded(
                  child: Center(
                    child: RaisedButton(
                      color: _counter > 0 ? Colors.blue : Colors.grey,
                      textColor: Colors.white,
                      child: _counter > 0 ? Text("登录") : Text("$_ticker"),
                      onPressed: _handleSubmitted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
