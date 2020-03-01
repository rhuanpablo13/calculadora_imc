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

  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();

  String _infoText = "Informe seus dados";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
    });
  }


  void _calcularImc() {
    setState(() {
      double weight = (double.parse(weightController.text));
      double height = (double.parse(heightController.text)) / 100;
      double imc = weight / (height* height);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) { // imc > 40
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ],
      ),


      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Form(
          key: _formKey,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.account_circle, size: 120, color: Colors.green),

              // Peso (Kg)
              TextFormField(
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe seu peso";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (Kg)"
                ),
                style: TextStyle(
                    fontSize: 25
                )
              ),


              // Altura (cm)
              TextFormField(
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe sua altura";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)"
                ),
                style: TextStyle(
                    fontSize: 25
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
                child: Container(
                  height: 45,
                  child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calcularImc();
                        }
                      },
                      child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 20)),
                      color: Colors.green
                  ),
                ),
              ),

              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              )

            ],

          ),
        ),
      )
    );
  }
}
 