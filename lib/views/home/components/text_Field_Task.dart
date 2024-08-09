import 'package:flutter/material.dart';
import 'package:res/utils/app_strings.dart';



class TTextField extends StatelessWidget {
  const TTextField({
    super.key,
    required this.controller,
    this.isForDesc=false,
    required this.onFieldSubmitted,
    required this.onChanged,
  });

  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  final bool isForDesc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: TextFormField(
          controller: controller,
          //maxLines: !isForDesc? 4:null,
          cursorHeight: !isForDesc? 20:null,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            border: isForDesc? InputBorder.none:null,
            counter: Container(),
            hintText: isForDesc? AppString.addNote:null,
            prefixIcon:
            isForDesc?
            const Icon(Icons.bookmark_border,
              color: Colors.black,)
                :null,
          ),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}