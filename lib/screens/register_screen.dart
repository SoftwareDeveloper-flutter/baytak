import 'package:flutter/material.dart';
class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});
  @override
 State<RegisterScreen> createState()=>_RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{
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
              padding: const EdgeInsets.only(top:30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                  ClipOval(
                   child:Image.asset('assets/images/logo.png',height:200,width:200),
                  ),
                 const Text("Sign Up Here!",style:TextStyle(fontSize:20,fontWeight:FontWeight.w900)),
                 const Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 30),
                   child: Column(
                    children: [
                          ReuseableSocialContainer(color:Color(0xff2684FB),asset:'assets/images/fb_icon.png',title:"Sign up with facebook"),
                          ReuseableSocialContainer(color:Color.fromARGB(255, 245, 63, 59),asset:'assets/images/google_icon.png',title:"Sign up with google"),

                    ],
                   ),
                   
                   
                 ),
                 ],
             
              ),

            ),
           ),
    );
  }
}

class ReuseableSocialContainer extends StatelessWidget{
  final String title,asset;
  final Color color;
   const ReuseableSocialContainer({super.key ,required this.color,required this.title,required this.asset});
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height:50,
        width:double.infinity,
        decoration: BoxDecoration(
          color:color,
          borderRadius: BorderRadius.circular(5),
        ),
        child:Padding(
          padding:const EdgeInsets.only(left:20),
        child:Row(
          children: [
            Image(image:AssetImage(asset),),
            const SizedBox(width:20),
            Text(title,style:const TextStyle(color:Colors.white))
          ],
        ),
        ),
      ),
    );
  }
}