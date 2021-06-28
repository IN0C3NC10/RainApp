import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String result="Informe quantas polegadas!";

  TextEditingController rainController = TextEditingController();


  //..function for reset fields
  void resetFields(){
    rainController.text="";
    setState(() {
      result="Informe quantas polegadas!";
      formKey = GlobalKey<FormState>();
    });
  }

  //..rules of your app
  void calculate(){
    setState(() {
      double rain = double.parse(rainController.text)*25.4;
      //..make comparisons
      if(rain != null){
        result = "Choveu (${rain.toString()} mm)";
      }else{
        result="Insira a quantidade em polegadas!";
      }
    });
  }

  //..layout of your app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //..configuration from top bar
      appBar: AppBar(
        title: Text("RainApp - Conversor", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: (){
            resetFields();
          })
        ],
      ),

      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        //"SingleChildScrollView" used for don't stay in front of keyboard and did scroll screen
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //..icon on top
              Icon(Icons.cloud_circle, size: 120.0, color: Colors.cyan),

              //..first input
              TextFormField(keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                    labelText: "Polegadas",
                    labelStyle: TextStyle(color: Colors.cyan[100])
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 25.0),
                controller: rainController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty){
                    return "Insira quanto choveu!";
                  }}
              ),

              //..button
              Padding(
                padding: EdgeInsets.only(top:10.0, bottom:10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    //..with this, you can use your function
                    onPressed: (){
                      if (formKey.currentState.validate()){
                        calculate();
                      }
                    },
                    child: Text("Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.cyan,
                  ),
                ),
              ),

              //..the text or result
              Text(result,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.cyan[100],
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
