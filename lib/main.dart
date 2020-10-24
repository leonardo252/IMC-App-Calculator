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

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _imcResult = "Informe seus dados";

  void _restFilds() {
    setState(() {
    weightController.text = "";
    heightController.text = "";

      _imcResult = "Informe seus dados";
    });
  }

  void _calculateImc() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      print(imc);
      if (imc < 18.6) {
        _imcResult = "Abaixo do Peso \n(IMC: ${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _imcResult = "Peso Ideal \n(IMC: ${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _imcResult =
        "Levemente Acima do Peso \n(IMC: ${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _imcResult =
        "OBESIDADE GRAU I \n(IMC: ${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _imcResult =
        "OBESIDADE GRAU II \n(IMC: ${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _imcResult =
        "OBESIDADE GRAU III \n(IMC: ${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  // TODO: implement widget
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
          onPressed: _restFilds,)
        ]
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 200.0, color: Colors.teal,),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.teal),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.teal[900], fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu Peso !";
                  }
                  return null;
                },
              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (Cm)",
                  labelStyle: TextStyle(color: Colors.teal),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.teal[900], fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua Altura !";
                  }
                  return null;
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                height: 80.0,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _calculateImc();
                    }
                  },
                  child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  color: Colors.teal,
                ),
              ),
              Text( _imcResult,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.teal, fontSize: 25.0),
              )
            ],
          ),
        ),
      )
    );
  }
}
