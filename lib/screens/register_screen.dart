import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:baytak/screens/login_screen.dart';
import "package:baytak/utils/utils.dart";
import 'package:fluttertoast/fluttertoast.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;

   void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final emailFocusNode=FocusNode();
  final passwordFocusNode=FocusNode();
  String _errorMessage = '';
  final TextEditingController emailController= TextEditingController();
  final TextEditingController passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> signUp() async {
      setState(() {
        _errorMessage = '';
      });
    try {
       if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in both email and password.';
      });
      return;
    }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Future.microtask(() {
         ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Sign Up Successful!"),
      duration: Duration(seconds: 2),
    ),
  ).closed.then((_) {
      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>const LoginScreen()));
      });
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Sign Up failed: ${e.toString()}';
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
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset('assets/images/logo.png',
                    height: 90, width: 90),
              ),
              const Text("Sign Up Here!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const ReuseableSocialContainer(
                        color: Color(0xff2684FB),
                        asset: 'assets/images/fb_icon.png',
                        title: "Sign up with facebook"),
                  const  ReuseableSocialContainer(
                        color: Color.fromARGB(255, 245, 63, 59),
                        asset: 'assets/images/google_icon.png',
                        title: "Sign up with google"),
                   const Row(
                      children: [
                        Expanded(child: Divider()),
                        SizedBox(width: 30),
                        Text("OR", style: TextStyle(fontSize: 20)),
                        SizedBox(width: 30),
                        Expanded(child: Divider()),
                      ],
                    ),
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
                          focusNode: emailFocusNode,
                          onFieldSubmitted:(value){
                            Utils.fieldFocus(context, emailFocusNode, passwordFocusNode);
                          },
                           controller: emailController,
                        onSaved: (value){
                        emailController.text=value!;
                        },
                      textInputAction:TextInputAction.next,
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

                   const SizedBox(height:10),
                     Material(
                      color: Colors.black,
                      elevation: 6,
                      borderRadius: BorderRadius.circular(8),
                      child:MaterialButton(
                        minWidth: double.infinity,
                        onPressed:(){
                          signUp();
                        },
      
                        child:const Text("Sign Up",style:TextStyle(color:Colors.white))
                      ),
                    ),
                    const SizedBox(height:5),
                     Text.rich(
                      TextSpan(
                         text: 'Already have an account?',
                        style:  const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  
                ),
                children: [
                  TextSpan(
            text: 'Login', 
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
                MaterialPageRoute(builder:(context)=>const LoginScreen())
               );
              },
          ),
          
                ]
                      ),
                    ),
                     if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(_errorMessage, style: const TextStyle(color: Colors.red)),
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

class ReuseableSocialContainer extends StatelessWidget {
  final String title, asset;
  final Color color;
  const ReuseableSocialContainer(
      {super.key,
      required this.color,
      required this.title,
      required this.asset});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Image(
                image: AssetImage(asset),
              ),
              const SizedBox(width: 20),
              Text(title, style: const TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
