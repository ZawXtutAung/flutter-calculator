import 'package:flutter/material.dart';

class Btn_layout extends StatelessWidget {
  final txtcolor;
  final color;
  final String btntxt;
  final btn_clck;
  Btn_layout({this.btntxt, this.txtcolor, this.color, this.btn_clck});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btn_clck,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                btntxt,
                style: TextStyle(color: txtcolor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
