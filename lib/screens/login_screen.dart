import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});
  @override
 State<LoginScreen> createState()=>_LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
           body:Container(
            height:MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
             color:Colors.white
            ),
        
            
            child:  Padding(
              padding: const EdgeInsets.only(top:1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Image.asset('assets/images/logo.png',fit:BoxFit.cover),
                 const Text("Login to Your Account",style:TextStyle(fontSize:20,fontWeight:FontWeight.w900))
                 ],
              ),
            ),
           ),
    );
  }
}