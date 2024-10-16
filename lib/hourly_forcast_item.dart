import 'package:flutter/material.dart';


class HourlyForcastItem extends StatelessWidget {
  final String time ;
  final IconData icon;
  final String temp;
  const HourlyForcastItem({
       super.key,
       required this.time,
       required this.icon,
       required this.temp});

  @override
  Widget build(BuildContext context) {
    return  Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                 child:   Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                               
                               
                               //Time is shown here
                    Text(time,
                    style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                    
                   const SizedBox(height: 8,),
                               
                               // cloud icon has been shown here
                    Icon(icon, size: 35,),
                               
                   const SizedBox(height: 8,),
                               
                               // temp has been shown here
                    Text(temp,
                    style: const TextStyle(
                    fontSize: 15,
                    ),
                    ),
                              
                   ],),
                 ),
                ) ;
  }
}

