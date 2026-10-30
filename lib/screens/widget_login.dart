// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customtextfild extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final IconData? prefixIcon;
  
  const Customtextfild ({super.key,
   required this.hintText,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    });

  @override
  State<Customtextfild> createState() => _CustomtextfildState();
}

class _CustomtextfildState extends State<Customtextfild> {

  late bool _obscure;
  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }
  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      decoration: InputDecoration(hintText: widget.hintText,
      prefixIcon: widget.prefixIcon != null 
      ? Icon(widget.prefixIcon, size: 15,) 
      : null,
      suffixIcon: widget.obscureText ? IconButton(icon:Icon(_obscure ? Icons.visibility_off : Icons.visibility, size: 20,),
      onPressed: () {
      setState(() {
        _obscure = !_obscure;
      });
      },
      )
      : null,
      
      border: 
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),)
        ),
        
    );
  }
}