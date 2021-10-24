import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_login/Model/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final styleBole =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);
  var _isActive = true;

  final _formKey = GlobalKey<FormState>();
  Profile profile = new Profile(email: "", password: "");
  final Future<FirebaseApp> _firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Center(
                      child: Text("Register",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.bold))),
                  SizedBox(height: 20),
                  Text("Email", textAlign: TextAlign.left, style: styleBole),
                  TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: "กรุณาป้อนอีเมลด้วยครับ"),
                      EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                    ]),
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.zero,
                          child: Icon(Icons.people),
                        ),
                        border: UnderlineInputBorder(),
                        labelText: "Type your Email"),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String? email) {
                      profile.email = email!;
                    },
                  ),
                  SizedBox(height: 20),
                  Text("Password", textAlign: TextAlign.left, style: styleBole),
                  TextFormField(
                    validator: RequiredValidator(
                        errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
                    obscureText: true,
                    onSaved: (String? password) {
                      profile.password = password!;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.zero,
                          child: Icon(Icons.lock),
                        ),
                        border: UnderlineInputBorder(),
                        labelText: "Type your password"),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          primary: Colors.transparent,
                          elevation: 0.0),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          try {
                            print(profile.email + " " + profile.password);
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: profile.email,
                                    password: profile.password)
                                .then((value) => {
                                      print(profile.email +
                                          " " +
                                          profile.password),
                                      Fluttertoast.showToast(
                                        msg: "สร้างบัญชีเรียบร้อยแล้ว",
                                        gravity: ToastGravity.CENTER,
                                      ),
                                      _formKey.currentState!.reset(),
                                      Navigator.pop(context)
                                    });
                          } on FirebaseAuthException catch (e) {
                            Fluttertoast.showToast(
                              msg: e.message!,
                              gravity: ToastGravity.CENTER,
                            );
                          }
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: _isActive
                                ? LinearGradient(colors: [
                                    Color(0xFF5cfbff),
                                    Color(0xFFf481bb)
                                  ])
                                : LinearGradient(colors: [
                                    Color(0xFFE8EBEB),
                                    Color(0xFFC0C0C0)
                                  ]),
                            borderRadius: BorderRadius.circular(44)),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'register',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
