import 'package:flutter/material.dart';


class OTP extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
           const Padding(
              padding:  EdgeInsets.only(top: 150),
              child: Text("Enter OTP",style: TextStyle(fontSize: 15,color: Color.fromARGB(199, 151, 18, 8)),),
            ),
            SizedBox(height: size.height*0.03,),
            Text("Check your mobile for the OTP",style: TextStyle(fontSize:15,color: Color.fromARGB(199, 151, 18, 8) ),),
            SizedBox(height:size.height*0.02),
            Padding(
              padding: const EdgeInsets.only(left: 110),
              child: Row(
                children: [
                  CustomTextField(size),
                    SizedBox(width: size.width*0.023,),
                  CustomTextField(size),
                    SizedBox(width: size.width*0.023,),
                     CustomTextField(size),
                    SizedBox(width: size.width*0.023,),
                     CustomTextField(size), 
                ],
              ),
            ),
            SizedBox(height: size.height*0.058),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: SizedBox(
                height: size.height*0.038,
                width: size.width*0.28,
                child: ElevatedButton(onPressed: (){}, child: Text("Submit",style: TextStyle(fontSize: 10,color: Colors.white),),
                style: ElevatedButton.styleFrom(shape: const StadiumBorder(),
                backgroundColor:Color.fromARGB(255, 249, 185, 25)),
                ),
              ),
            )
            
          ],
        ),
      ),
    );
  }

   CustomTextField(Size size) {
    return SizedBox(
                  height: size.height*0.04,
                  width: size.width*0.07,
                  
                  child:const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)
                      ),                   
  ),
                    ),
                  );
  }
}
