import 'package:flutter/material.dart';

// ignore: camel_case_types
class additionalinfoitems extends StatelessWidget {
  final IconData icon;
  final String lable;
  final String value;
  const additionalinfoitems({
    super.key, 
    required this.icon, 
    required this.lable, 
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Column( children: [
    Icon(icon,
      size: 35,),
    
    const SizedBox(height:8,),
    
                        Text(lable,
                        style: const TextStyle(
                        fontSize: 15,
                        ),
                        ),
    
                        Text(value,
                        style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        ),
                        ),
    ]
    ,);
  }
}
