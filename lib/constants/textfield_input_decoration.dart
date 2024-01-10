import 'package:flutter/material.dart';

InputDecoration textfieldDecoration(String labelText, TextStyle style,String hintText) {
  return InputDecoration(
         
          labelText: labelText,
          labelStyle: style.copyWith(color: Colors.black),
          hintText: hintText,
          hintStyle: style,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.amber,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white54,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
        );
}
