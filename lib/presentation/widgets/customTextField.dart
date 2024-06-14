import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    // super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.suffix,
    this.passwordField,
  });

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final bool? passwordField;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;
  late bool showPrefixIcon;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        style: GoogleFonts.exo(
          color: Colors.black,
          // fontWeight: FontWeight.bold,
          // fontSize: width <= 1050 ? 12 : 14,
          // fontSize: width * 0.02,
          fontSize: width > 1050
              ? width * 0.015
              : width >= 900
                  ? width * 0.018
                  : 14,
        ),
        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
          // hintText: "Last Name",
          hintText: widget.hintText,
          hintStyle: GoogleFonts.orbitron(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            // fontSize: width <= 1050 ? 12 : 14,
            // fontSize: width * 0.02,
            fontSize: width > 1050
                ? width * 0.015
                : width >= 900
                    ? width * 0.018
                    : 14,
          ),
          suffixIcon: widget.passwordField == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: showPassword
                      ? Icon(
                          // Ionicons.eye_off,
                          Icons.remove_red_eye_outlined,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        )
                      : Icon(
                          Icons.remove_red_eye,
                          color: Theme.of(context).primaryColor,
                        ))
              : widget.suffix,
        ),
        validator: widget.validator,
        // validator: widget.validator == null
        //     ? null
        //     : (val) => widget.validator!(val ?? ""),
        obscureText: widget.passwordField == true ? showPassword : false,
      ),
    );
  }
}
