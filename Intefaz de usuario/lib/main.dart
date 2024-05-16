import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Invernadero',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _lightIntensity = 50.0;
  bool _isRiegoInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control de Invernadero'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle('Estado del Invernadero'),
            SizedBox(height: 10.0),
            _buildInvernaderoStatusWidget(),
            SizedBox(height: 20.0),
            _buildSectionTitle('Programación de Riego'),
            SizedBox(height: 10.0),
            _buildRiegoProgramadoWidget(context),
            SizedBox(height: 20.0),
            _buildStartRiegoButton(),
            SizedBox(height: 20.0),
            _buildSectionTitle('Control de Luz'),
            SizedBox(height: 10.0),
            _buildLightIntensitySlider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInvernaderoStatusWidget() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusRow('Temperatura', '25°C'),
            _buildStatusRow('Humedad', '60%'),
            _buildStatusRow('Nivel de Luz', '$_lightIntensity%'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildRiegoProgramadoWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),  
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hora de Riego:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.access_time,
              size: 30.0,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      
    }
  }

  Widget _buildStartRiegoButton() {
    return ElevatedButton(
      onPressed: _isRiegoInProgress ? null : _startRiego,
      child: _isRiegoInProgress ? CircularProgressIndicator() : Text('Iniciar Riego'),
    );
  }

  void _startRiego() {
    
    setState(() {
      _isRiegoInProgress = true;
    });
    
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isRiegoInProgress = false;
      });
    });
  }

  Widget _buildLightIntensitySlider() {
    return Slider(
      value: _lightIntensity,
      min: 0,
      max: 100,
      onChanged: (value) {
        setState(() {
          _lightIntensity = value;
        });
      },
      divisions: 10,
      label: '$_lightIntensity%',
    );
  }
}
