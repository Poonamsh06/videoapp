import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Mobile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
var size=MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset("assests/Rectangle 17.png"),
              Column(
                children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Stack(
                          children: [
                           Image.asset("assests/Polygon 1.png"),
                             Padding(
                               padding:  EdgeInsets.fromLTRB(25,20,50,100),
                               child: Image.asset( "assests/register_image.png",),
                             ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.fromLTRB(18,0,50,2),
                        child: Text("Login",style: TextStyle(fontSize: 15,color:  Color.fromARGB(199, 151, 18, 8),)
                        ),
                      ),
                      SizedBox(height: size.height*0.02,),
                      Container(
                        height: size.height*0.06,
                        width: size.width*0.85,
                        child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(60)
                        ),
                          hintText: "Mobile number",
                          suffixIcon:Icon(Icons.call,color: Colors.blue,)
                          ) ),
                      ),
                        SizedBox(height: size.height*0.04,),
                        Container(
                        height: size.height*0.038,
                        width: size.width*0.28,
                        child: ElevatedButton(onPressed: (){}, child: Text("Get OTP",style: TextStyle(fontSize: 10,color: Colors.white),),
                        style: ElevatedButton.styleFrom(shape: const StadiumBorder(),
                        backgroundColor:Color.fromARGB(255, 249, 185, 25)),
                        ),
                      ),
                      SizedBox(height: size.height*0.09,),
                      Text("Sign Up",style: TextStyle(fontSize: 15,color:  Color.fromARGB(199, 151, 18, 8))),
                      SizedBox(height:size.height*0.06),
                      Text("or connect with",style:TextStyle(fontSize: 10,color: Color.fromARGB(255, 132, 131, 131))),
                   SizedBox(height: size.height*0.03,),
                   Padding(
                     padding: const EdgeInsets.only(left: 70),
                     child: Row(
                      children: [
                        IconButton(onPressed: (){}, icon:Icon( FontAwesomeIcons.facebook,color: Color.fromARGB(255, 26, 26, 171),size:35 ,)),
                         MaterialButton(
                          shape: CircleBorder(),
                          color: Color.fromARGB(255, 26, 26, 171), 
                          padding: EdgeInsets.all(5),
                         child:Icon(FontAwesomeIcons.instagram,color: Colors.white,),
                         onPressed: (){},), 
                          IconButton(onPressed: (){}, icon:Icon( FontAwesomeIcons.pinterest,color: Color.fromARGB(255, 186, 43, 33),size: 35,)),
                          MaterialButton(
                          shape: CircleBorder(),
                          color: Color.fromARGB(255, 25, 127, 211), 
                          padding: EdgeInsets.all(5),
                         child:Icon(FontAwesomeIcons.linkedinIn,color: Colors.white,),
                         onPressed: (){},),        ],
                     ),
                   )
                ],
                      ),
            ],
          ),
        ],
      ),
        );
  }
}
