import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fiba_3x3/pages/Auth/login/login.dart';

class SignUpStepTwo extends StatelessWidget {
  final VoidCallback onBack;

  const SignUpStepTwo({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Personal Information",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Enter your personal details to continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF757575)),
                        ),
                        const SizedBox(height: 48),
                        SignUpFormStepTwo(onBack: onBack),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

final OutlineInputBorder authOutlineInputBorder = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(color: Color(0xFF757575)),
);

class SignUpFormStepTwo extends StatelessWidget {
  final VoidCallback onBack;
  const SignUpFormStepTwo({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildTextField(
            "Email",
            "Enter your email",
            suffix: SvgPicture.string(mailIcon),
          ),
          const SizedBox(height: 16),
          buildTextField(
            "Password",
            "Enter your password",
            obscure: true,
            suffix: SvgPicture.string(lockIcon),
          ),
          const SizedBox(height: 16),
          buildTextField(
            "Phone Number",
            "Enter your phone number",
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              onBack();
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            child: const Text("Signup"),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
    String label,
    String hint, {
    bool obscure = false,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: const TextStyle(color: Color(0xFF757575)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        suffixIcon:
            suffix != null
                ? Padding(padding: const EdgeInsets.all(12), child: suffix)
                : null,
        border: authOutlineInputBorder,
        enabledBorder: authOutlineInputBorder,
        focusedBorder: authOutlineInputBorder.copyWith(
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
