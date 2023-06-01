

import 'package:flutter/material.dart';
import 'package:newtask/core/extension/media_values.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      leadingWidth:context.width ,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0,top: 15),
        child: Row(children: [
         Container(
          height: 20,
          width: 20,
         decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5)
         ),
         
         child: const Icon(
          Icons.arrow_back_ios_sharp,
          color: Colors.white,size: 14,
         ),
         ),
         const SizedBox(width: 10,),
          Text(
             "Log in",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ]),
      ),
      titleSpacing: 0.0,
   
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
