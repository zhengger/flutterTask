import 'package:flutter/material.dart';

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
  final String hintText;
  final String labelText;
  final String helperText;
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
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off
          ),
        ),
      ),
    );
  }
}

class LoginFormState extends State<LoginForm> {

   void showInSnackBar(String value) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
      showInSnackBar(
        "登录前请先修复红色提示错误!",
      );
    } else {
      form.save();
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
                      hintText: "groupones",
                      labelText:
                     "请输入登录账号*",
                    ),
                    validator: _validateName,
                  ),
                  sizedBoxSpace,
                  PasswordField(
                    helperText:
                    "密码长度不超过8位",
                    labelText:
                    "请输入登录密码*",
                  ),
                  sizedBoxSpace,
                  Expanded(
                    child:  Center(
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                            "登录"),
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


