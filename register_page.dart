// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap,});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  final emailController= TextEditingController();
  final passwordController= TextEditingController();
  final confirmPasswordController= TextEditingController();

  // sign up user
  void signUp() async{
    if (passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("passwords do not Match!"),
      ),
      );
      return;
    }

    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpwithEmailandPassword(
        emailController.text, 
        passwordController.text,
        );


    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()),
      ),
      );
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                //logo
                Icon(
                  Icons.message,
                  size:100,
                  color: Colors.grey[800],
                ),

                const SizedBox(height: 50),
            
                //create account message
               const Text(
                  "Let's create an account for u!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),
                //email textfield
                MyTextField(
                  controller: emailController, 
                  hinText: 'Email', 
                  obsureText: false,
                  ),

                  const SizedBox(height: 10),
            
                //password textfield
                MyTextField(
                  controller: passwordController, 
                  hinText: 'password', 
                  obsureText: true,
                  ),

                  const SizedBox(height: 10),
            
                //confirm password textfield
                MyTextField(
                  controller: confirmPasswordController, 
                  hinText: 'Confirm password', 
                  obsureText: true,
                  ),

                  const SizedBox(height: 25),
            
                //sign up button
                MyButton(onTap: signUp, text: "Sign Up"),

                const SizedBox(height: 50),
            
                //not a member ? register now

                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already a member?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text('Login now',
                      style: TextStyle(
                        fontWeight:FontWeight.bold,
                      ),
                      ),
                    ),

                  ],
                )
              ],
              ),
          ),
        
      ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('passwordController', passwordController));
  }
}