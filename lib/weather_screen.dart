import 'dart:convert';

import 'dart:math';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info_items.dart';
import 'package:weather_app/hourly_forcast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';


class WeatherScreen extends StatefulWidget {
 const WeatherScreen
({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  
  
 Future<Map<String,dynamic>>getCurrentWeather() async{
  try{
    String city ='London';
    final res = await http.get(
    Uri.parse('http://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$openWeatherApiKey',)
    );
    final data = jsonDecode(res.body);
    if(data['cod']!='200'){
       throw data['message'];
    }
     //data['list'][0]['main']['temp'];
     return data;
    }catch(e){
    throw e.toString();
  }
 
  }
  
   

     @override

  Widget build(BuildContext context) {
     const textstyle = TextStyle(
                    letterSpacing: 2,
                    fontSize: 25,
                    wordSpacing: 3,
                    );


    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: ln10,
        ),
        ),
        
        actions: [
          IconButton(onPressed: (){
            setState(() {
              getCurrentWeather();
            });
          }, icon:const Icon(Icons.refresh,)),
          
          ],
      ),

      body:  FutureBuilder(
         future: getCurrentWeather(),
         builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
           return const Center(child: CircularProgressIndicator.adaptive());
          } if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }




          
          final data = snapshot.data!;
          final weatherdata = data['list'][0];
          final currenttemp = weatherdata['main']['temp'];
          final cloud = weatherdata['weather'][0]['main'];
          final  windspeed = weatherdata['wind']['speed'];
          final humidity = weatherdata['main']['humidity'];
          final pressure = weatherdata['main']['pressure'];
           
           
           
           
           
           return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            //Main box 
             SizedBox(
              width: double.infinity,
              child:  Card(
                
                elevation: 16,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                 
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(16),
                 child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                   
                   child: Padding(
                     padding:const EdgeInsets.all(20),
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                                 
                                 
                                 //Temperature is shown here
                      Text('$currenttemp k',
                      style:const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      ),
                      ),
                      
                      const SizedBox(height: 20,),
                                 
                                 // cloud icon has been shown here
                     cloud == 'Clouds' || cloud =='Rain' ? const Icon(Icons.cloud, size: 75,) :const Icon(Icons.sunny, size: 75,),
                                 
                    const  SizedBox(height: 20,),
                                 
                                 // weather has been shown here
                      Text(cloud,
                      style: const TextStyle(
                      fontSize: 20,
                      ),
                      ),
                                
                     ],),
                   ),
                 ),
               ),
              ),
            ),
            
            const SizedBox(height: 20,),
            
            //Text has been shown here 
            const Text('Weather Forecast',
                      textAlign: TextAlign.left,
                      style: textstyle,
                      ),
                 
            const SizedBox(height: 20,),
                 
            //list of whether has been show here
            //scrollable text is here
            
            SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: List.generate(5, (i) {
      final time = DateTime.parse(data['list'][i + 1]['dt_txt']); // Corrected here

      return HourlyForcastItem(
        time: DateFormat.Hms().format(time), // Pass the parsed time here
        icon: data['list'][i + 1]['weather'][0]['main'] == 'Clouds' || data['list'][i + 1]['weather'][0]['main'] == 'Rain' ? Icons.cloud : Icons.sunny,
        temp: data['list'][i + 1]['main']['temp'].toString(),
      );
    }),
  ),
),
                 
              const SizedBox(height: 20,),
                 
                 //Another text 
                 const Text('Additional Information',
                      textAlign: TextAlign.left,
                      style: textstyle,
                      ), 
                 
             const SizedBox(height: 20,),
                 
                 //other details
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                       
                 
                       additionalinfoitems(icon: Icons.water_drop,lable: 'Humidity',value: humidity.toString(),),
                       additionalinfoitems(icon: Icons.air,lable: 'wind Speed',value: windspeed.toString(),),
                       additionalinfoitems(icon: Icons.beach_access_rounded,lable: 'Pressure',value: pressure.toString(),),
                 
                      ],
                      ),       
          ],
          ),
                 );
         },
      ),
    );
  }
}
