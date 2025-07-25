import 'package:flutter/material.dart';
import 'package:product_app/views/auth/login_screen.dart';

class OptionScreen extends StatelessWidget {
  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 75,
          ),
          Image(
            image: AssetImage(
              'lib/assets/optionscreen.png',
            ),
            height: 150,
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Select option!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.teal,
                  ),
                    width: 340,
                    height: 90,
                    
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 10,),
                          Text(
                            'Buy',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                ),
                          ),
                          // SizedBox(width: 280,),
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          }, icon: Icon(Icons.arrow_forward_ios,color: Colors.white,))
                        ],
                      ),
                    )
                    ),
                    
              ],
            ),
          ),
          SizedBox(height: 3,),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    // color: Colors.teal,
                    border: Border.all(
                      color: Colors.teal
                    )
                  ),
                    width: 340,
                    height: 90,
                    
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 10,),
                          Text(
                            'Rent',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                ),
                          ),
                          // SizedBox(width: 280,),
                          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,color: Colors.teal,))
                        ],
                      ),
                    )
                    ),
                    
              ],
            ),
          ),
          SizedBox(height: 3,),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    // color: Colors.teal,
                    border: Border.all(
                      color: Colors.teal
                    )
                  ),
                    width: 340,
                    height: 90,
                    
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 10,),
                          Text(
                            'Sell',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                ),
                          ),
                          // SizedBox(width: 280,),
                          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,color: Colors.teal,))
                        ],
                      ),
                    )
                    ),
                    
              ],
            ),
          ),
          Expanded(child: Image.asset('lib/assets/345bd60d710065fe219bdc89188a2907600d3f0f.png'))
        ],
      ),
    );
  }
}
