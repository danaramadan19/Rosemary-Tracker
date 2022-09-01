import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormSign extends StatelessWidget {
  final String hint;
  final TextEditingController myController;
  final String Function(String) valid;
  const CustomTextFormSign({Key key, @required this.hint,@required this.myController,@required this.valid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
  margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
            
              maxLines: 20,  
              keyboardType: TextInputType.multiline,
        controller: myController,
        validator: valid,
        decoration: InputDecoration(

          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: hint

        ),
      ),
    );
  }
}
