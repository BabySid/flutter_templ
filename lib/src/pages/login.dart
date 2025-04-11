import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  //final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("登录页面")),
      body: Form(
        //key: _formKey, //设置globalKey，用于后面获取FormState
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _unameController,
              decoration: InputDecoration(
                labelText: "用户名",
                hintText: "用户名或邮箱",
                icon: Icon(Icons.person),
              ),
              // 校验用户名
              validator: (v) {
                return v!.trim().isNotEmpty ? null : "用户名不能为空";
              },
            ),
            TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "您的登录密码",
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
              //校验密码
              validator: (v) {
                return v!.trim().length > 5 ? null : "密码不能少于6位";
              },
            ),
            // 登录按钮
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        // context是Builder组件的context
                        return ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("登录"),
                          ),
                          onPressed: () {
                            // 使用contxext的方式来获取FormState
                            if (Form.of(context).validate()) {
                              Navigator.of(
                                context,
                              ).pop("登录用户: ${_unameController.text}");
                            }
                          },
                        );
                      },
                    ),
                    // child: ElevatedButton(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Text("登录"),
                    //   ),
                    //   onPressed: () {
                    //     // 通过_formKey.currentState 获取FormState后，
                    //     // 调用validate()方法校验用户名密码是否合法，校验
                    //     // 通过后再提交数据。
                    //     if ((_formKey.currentState as FormState).validate()) {
                    //       Navigator.of(
                    //         context,
                    //       ).pop("登录用户: ${_unameController.text}");
                    //     }
                    //   },
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
