import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:baytak/screens/register_screen.dart';
import "package:baytak/utils/utils.dart";
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
 final emailFocusNode=FocusNode();
  final passwordFocusNode=FocusNode();
   void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  String _errorMessage = '';
  final TextEditingController emailController= TextEditingController();
  final TextEditingController passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> login() async {
    try {
       if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in both email and password.';
      });
      return;
    }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
 
    } catch (e) {
      setState(() {
        _errorMessage = 'Login failed: ${e.toString()}';
      });
    }
  }

    return Scaffold(
      body:SingleChildScrollView(
      child:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset('assets/images/logo.png',
                    height: 150, width: 150),
              ),
              const SizedBox(height:10),
              const Text("Login Here!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                   
                 
                  
                    Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                       const Text("Username",style:TextStyle(color:Color(0xff8F92A1))),
                         const SizedBox(height:5),
                        Container(
                          decoration:BoxDecoration(
                            color:const Color(0xff8592a1).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value){
                              emailController.text=value!;
                            },
                          textInputAction:TextInputAction.next,
                            focusNode: emailFocusNode,
                          onFieldSubmitted:(value){
                            Utils.fieldFocus(context, emailFocusNode, passwordFocusNode);
                          },
                          decoration: const InputDecoration(
                            prefixIcon:  Icon(Icons.email),
                               enabledBorder: InputBorder.none,
                               focusedBorder: InputBorder.none,
                               disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                          ),
                        )
                      
                        ),

                         const Text("Password",style:TextStyle(color:Color(0xff8F92A1))),
                         const SizedBox(height:5),
                        Container(
                          decoration:BoxDecoration(
                            color:const Color(0xff8592a1).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        child: TextFormField(
                        autofocus:false,
                        controller: passwordController,
                        onSaved: (value){
                        passwordController.text=value!;
                        },
                      textInputAction:TextInputAction.done,
                           focusNode: passwordFocusNode,
                        obscureText: _obscureText,
                          decoration:  InputDecoration(
                            prefixIcon:  const Icon(Icons.lock),
                            suffix:IconButton(icon:const Icon(Icons.visibility_off,color:Colors.black),onPressed: _toggleVisibility),
                               enabledBorder: InputBorder.none,
                               focusedBorder: InputBorder.none,
                               disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                          ),
                        )
                      
                        ),
                      ],
                    ),

                   const SizedBox(height:20),
                     if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(_errorMessage, style: const TextStyle(color: Colors.red)),
                        ),
                     Material(
                      color: Colors.black,
                      elevation: 6,
                      borderRadius: BorderRadius.circular(8),
                      child:MaterialButton(
                        minWidth: double.infinity,
                        onPressed:(){
                         login();
                        },
      
                        child:const Text("Sign Up",style:TextStyle(color:Colors.white))
                      ),
                    ),
                    const SizedBox(height:20),
                     Text.rich(
                      TextSpan(
                         text: 'Create an account?',
                        style:  const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  
                ),
                children: [
                  TextSpan(
            text: 'Sign Up', 
            style: const  TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
               Navigator.push(
                context,
                MaterialPageRoute(builder:(context)=>const RegisterScreen())
               );
              },
          ),
                ]
                      ),
                    ),
                  ],
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

