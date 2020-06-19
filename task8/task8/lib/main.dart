/*
Task8:
在本节登录例子的基础上进行以下功能扩展：
1. 预先设定一对有效的用户名和密码，
2. 当输入账号和密码连续三次错误时，提示用户登录锁定，
3. 同时将登录按钮变灰，不能使用，并在
4. 登录按钮上显示倒计时 60 秒的动态效果，倒计时结束后方可再次登录验证。
提示：输入信息保存可以考虑使用 onSaved，倒计时使用 Timer.periodic。

链接：https://juejin.im/post/5e4fa3c051882549265caa19
来源：掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

 */
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
  Timer _timer;
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
      });
      // Start validating on every change.
      showInSnackBar(
        "登录前请先修复红色提示错误! 您还有${_counter > 0 ? _counter : 0}次机会",
      );
      if (_counter <= 0) {
        _timer = Timer.periodic(period, (timer) {
          //到时回调
          print('afterTimer=' + DateTime.now().toString());
          setState(() {
            _ticker--;
          });
          if (_ticker <= 0) {
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
                      onPressed:_counter > 0 ? debounce(_handleSubmitted) : (){},
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

  //TODO 防止重复点击
  Function debounce(Function fn, [int t = 1500]) {
    ///防止重复点击导致倒计时失效
    Timer _debounce;
    return () {
      // 还在时间之内，抛弃上一次
      if (_debounce?.isActive ?? false) _debounce.cancel();

      _debounce = Timer(Duration(milliseconds: t), () {
        fn();
      });
    };
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
}
