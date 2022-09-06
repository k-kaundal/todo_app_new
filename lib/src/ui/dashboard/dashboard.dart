import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  String selectedValue ='Value 1';
  List<DropdownMenuItem<String>> list =[
    DropdownMenuItem(child: Text("Value 1"),value: 'Value 1',onTap: (){},),
    DropdownMenuItem(child: Text("Value 2"),value: 'Value 2',onTap: (){},),
    DropdownMenuItem(child: Text("Value 3"),value: 'Value 3',onTap: (){},),
    DropdownMenuItem(child: Text("Value 4"),value: 'Value 4',onTap: (){},),

  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            height: size.height * 0.1,
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 30,
                    width: 100,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedValue,
                          items: list,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                        // selectedItemBuilder: (context) => ,
                        // onChanged: (value) {}, child: null,),
                      ),
                    ))
              ],
            ),
          ),
          Container(
            height: size.height*0.82,
            width: size.width,
            child: Center(
              child: Text(selectedValue),
            ),
          )
        ],
      ),
    );
  }
}
