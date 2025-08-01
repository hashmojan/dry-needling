
import 'package:flutter/material.dart';



class UiHelper{
  static CustomTextField(TextEditingController controller ,String text, IconData iconData,bool toHide){
    return TextFormField(
      controller: controller,
      obscureText: toHide,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData),
        hintText: text,
        fillColor: Colors.grey[500],
        // filled: true,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(40),
        // )
      ),
    );

  }


  static CustomListTile(VoidCallback voidCallback,String title,IconData iconData,Color color){
    return ListTile(
      title:  Text(title,style: TextStyle(color: color),),
      leading:  Icon(iconData,color: color,),
      onTap: voidCallback,

    );
  }

}