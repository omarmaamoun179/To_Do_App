import 'package:flutter/material.dart';
import 'package:todo_app/core/firebase_func/firebase_functions.dart';
import 'package:todo_app/modules/login_screen/login_screen.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});
  static const String routeName = 'Singup';

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: mediaQuery.height * .3,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == '' || value.length < 3) {
                        return 'the name is requried';
                      }
                      return null;
                    },
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Name',
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
                      if (value == null || value == '') {
                        return 'age is requried';
                      }
                      return null;
                    },
                    controller: ageController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Age',
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
                    height: mediaQuery.height * .06,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                              mediaQuery.width * .6, mediaQuery.height * .05)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FireBaseFunctions.singup(
                            emailController.text,
                            passwordController.text,
                            int.parse(ageController.text),
                            nameController.text,
                          ).then((value) => Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName));
                        }
                      },
                      child: const Text('Login')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have an acoount already  ',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: const Text(
                            'Login',
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
      ),
    );
  }
}
