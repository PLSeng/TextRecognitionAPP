import 'package:flutter/material.dart';
import 'package:dscc_project/widgets/rounded_circular_button.dart';
import 'package:dscc_project/widgets/rounded_text_form_field.dart';
import 'package:rive/rive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color.fromRGBO(
        255,
        255,
        255,
        1.0,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        _header(),
        _loginForm(),
      ],
    );
  }

  Widget _header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      color: const Color.fromRGBO(230, 253, 253, 1.0),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              "Sign In",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            height: 200,
            child: RiveAnimation.asset(
              'assets/animations/animated_login_character.riv',
              stateMachines: const ["Login Machine"],
              onInit: (artboard) {
                controller = StateMachineController.fromArtboard(artboard, "Login Machine");
                if (controller == null) return;

                artboard.addController(controller!);
                isChecking = controller?.findInput("isChecking");
                isHandsUp = controller?.findInput("isHandsUp");
                trigSuccess = controller?.findInput("trigSuccess");
                trigFail = controller?.findInput("trigFail");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return SingleChildScrollView( // Added SingleChildScrollView
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        // Remove the fixed height to allow dynamic resizing
        child: Container(
          color: const Color.fromRGBO(
            255,
            255,
            255,
            1.0,
          ),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 25,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _formFields(),
                  // Dynamic height if keyboard is open
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom > 0
                        ? MediaQuery.of(context).size.height * 0.05
                        : MediaQuery.of(context).size.height * 0.35,
                  ),
                  _bottomButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formFields() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.20,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RoundedTextFormField(
            onChanged: (value) {
              if (isHandsUp != null) {
                isHandsUp!.change(false);
              }
              if (isChecking == null) return;

              isChecking!.change(true);
            },
            hintText: "Username",
            prefixIcon: Icons.email_outlined,
            controller: usernameController,
          ),
          RoundedTextFormField(
            onChanged: (value) {
              if (isChecking != null) {
                isChecking!.change(false);
              }
              if (isHandsUp == null) return;

              isHandsUp!.change(true);
            },
            hintText: "Password",
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            controller: passwordController,
          ),
        ],
      ),
    );
  }

  Widget _bottomButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          height: MediaQuery.of(context).size.height * 0.06,
          child:  RoundedCircularButton(
            text: "Sign In",
            idController: usernameController,
            passwordController: passwordController,
          ),
        ),
      ],
    );
  }
}
