import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/firebase_func/firebase_functions.dart';
import 'package:todo_app/layout/home_screen.dart';
import 'package:todo_app/modules/singup_screen/singup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  bool isPassword = true;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/SIGN IN.png'),
              fit: BoxFit.fill)),
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: mediaQuery.height * .18,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'email must not be empty';
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return 'please enter valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * .04,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.length < 5) {
                      return 'password must be greater than  4 charcter';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        isPassword = !isPassword;
                        setState(() {});
                      },
                      icon: Icon(
                        isPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * .03,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                            mediaQuery.width * .6, mediaQuery.height * .05)),
                    onPressed: ()  async{
                      if (formKey.currentState!.validate()) {
                        FireBaseFunctions.login(
                                emailController.text, passwordController.text)
                            .then((value) => Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName));
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', emailController.text).then((value) {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }).catchError((e) {
              print(e);
            });
              
                      }
                    },
                    child: const Text('Login')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don`t have an account ',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, SingUpScreen.routeName);
                        },
                        child: const Text(
                          'Sing Up Now',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
