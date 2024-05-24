import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade500),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inchController = TextEditingController();
  var result = "";

  var bgColor = Colors.lightBlue.shade100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text(widget.title,  style: const TextStyle(
          color: Colors.green, fontSize: 30// Set the text color here
          ),)),
      ),
      body: Container(
        color: bgColor,
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("BMI", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 25,),
                TextField(
                  controller: wtController,
                  decoration: InputDecoration(
                      label:Text("Enter your weight (Kg)"),
                    prefixIcon: Icon(Icons.line_weight),
                  ),
                  keyboardType: TextInputType.number,

                ),
                SizedBox(height: 25,),
                TextField(
                  controller: ftController,
                  decoration: InputDecoration(
                    label:Text("Enter your height (Ft)"),
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,

                ),
                SizedBox(height: 25,),
                TextField(
                  controller: inchController,
                  decoration: InputDecoration(
                    label:Text("Enter your height (Inch)"),
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,

                ),
                SizedBox(height: 25,),
                ElevatedButton(
                  onPressed: () {
                    // onPressed function goes here
                    var wt = wtController.text.toString();
                    var ft = ftController.text.toString();
                    var inch = inchController.text.toString();

                    if(wt!="" && ft!="" && inch!=""){
                      //do calculation
                      var iwt = int.parse(wt);
                      var ift = int.parse(ft);
                      var iinch = int.parse(inch);

                      var total_inch = (ift * 12) + iinch; //1 ft = 12 inch
                      var height_m = total_inch * 0.0254;  //1 inch = 0.0254 meter

                      var bmi = iwt / (height_m * height_m);

                      var msg = "";

                      if(bmi > 25){
                        //overweight
                        msg = "You're Over-weight!";
                        bgColor = Colors.orange.shade300;
                      } else if(bmi < 18){
                        //underweight
                        msg = "You're Under-weight!";
                        bgColor = Colors.red.shade300;
                      }else{
                        //healthy
                        msg = "You're Healthy !";
                        bgColor = Colors.green.shade300;
                      }

                      setState(() {
                        result = "$msg \nYour BMI is = ${bmi.toStringAsFixed(2)}"; //BMI = Body Mass Index
                      });
                    } else{
                      setState(() {
                        result = "Please, fill all the required blanks";
                      });
                    }
                  },
                  child: Text("Calculate"),
                ),
                SizedBox(height: 15,),
                Text(result,style: TextStyle(color: Colors.deepPurple,fontSize: 20),) //show on after calculation


              ],
            ),
          ),
        ),
      )
    );
  }
}
