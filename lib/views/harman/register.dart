import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Register extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                   Image.asset("assests/Polygon 1.png"),
                     Padding(
                       padding:  EdgeInsets.fromLTRB(25,20,50,100),
                       child: Image.asset( "assests/register_image.png",),
                     ),
                  Padding(
                padding:  EdgeInsets.fromLTRB(40,160,50,2),
                child: Text("Sign UP",style: TextStyle(fontSize: 15,color:  Color.fromARGB(199, 151, 18, 8))),
              ),
              ],
                ),
              ),
                 Padding(
                   padding: const EdgeInsets.only(right: 140),
                   child: Text("Register",style: TextStyle(fontSize: 30,color: Color.fromARGB(255, 255, 132, 0),),),
                 ),
              
              
              SizedBox(height: size.height*0.02),
              Padding(
                padding: const EdgeInsets.only(left: 10),
               child: Customtextfield(size,"Full Name"),
              ),
              SizedBox(height: size.height*0.02,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child:Customtextfield(size,"Mobile Number")
              ),
              SizedBox(height: size.height*0.02,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Customtextfield(size,"Password")
              ),
              SizedBox(height: size.height*0.001,),
              Padding(
                padding: const EdgeInsets.only(left: 175),
                child: Text("Forget Password?",style: TextStyle(color: Color.fromARGB(255, 132, 131, 131)),),
              ),
              SizedBox(height: size.height*0.001),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Customtextfield(size,"Confirm Password"),
              ),
              SizedBox(height:size.height*0.04,),
              Container(
                 height: size.height*0.044,
                    width: size.width*0.28,
                child: SizedBox(child: ElevatedButton(onPressed: (){}, child: Text("Sign-up",style:  TextStyle(fontSize: 10,color: Colors.white),),
                
               style: ElevatedButton.styleFrom(shape: const StadiumBorder(),
                    backgroundColor:Color.fromARGB(255, 249, 185, 25)),
                 ) )
                ),
                SizedBox(height: size.height*0.03,),
                Text("or connect with",style:TextStyle(fontSize: 10,color: Color.fromARGB(255, 132, 131, 131))),
           SizedBox(height: size.height*0.03,),
           Padding(
             padding: const EdgeInsets.only(left: 65),
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
                         onPressed: (){},),            ],
             ),
           )
            ],

            
          ),
        ],
      ),
      );
  }

  Container Customtextfield(Size size,String Text) {
    return Container(
            height: size.height*0.064,
            width: size.width*0.78,
            color:  Color.fromARGB(255, 244, 217, 161),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: Text
              ),
            ),
          );
  }
}
