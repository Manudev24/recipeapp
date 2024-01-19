import 'package:cookingenial/screens/bmi/theame.dart';
import 'package:flutter/material.dart';

class ImcSection extends StatefulWidget {
  const ImcSection({super.key});

  @override
  _ImcSectionState createState() => _ImcSectionState();
}

class _ImcSectionState extends State<ImcSection> {
  int _weight = 50;
  int _height = 180;
  int _maxHeight = 220;
  int _minHeight = 120;
  int _maxWeight = 200;
  int _minWeight = 0;
  int _age = 17;
  double _bmi = 0;

  void _incrementWeight() {
    setState(() {
      if (_weight < _maxWeight) _weight++;
      _calculateBmi();
    });
  }

  void _decrementWeight() {
    setState(() {
      if (_weight > _minWeight) _weight--;
      _calculateBmi();
    });
  }

  void _incrementAge() {
    setState(() {
      _age++;
    });
  }

  void _decrementAge() {
    setState(() {
      if (_age > 0) _age--;
    });
  }

  void _calculateBmi() {
    double heightInMeters = _height / 100;
    _bmi = (_weight) / (heightInMeters * heightInMeters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: secondary,
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text("BMI "),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0), color: primary),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('HEIGHT', style: headlines),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("$_height", style: boldNumber),
                    ),
                    Slider(
                        value: _height.toDouble(),
                        min: _minHeight.toDouble(),
                        max: _maxHeight.toDouble(),
                        activeColor: Colors.orangeAccent,
                        inactiveColor: Colors.black,
                        onChanged: (double newValue) {
                          setState(() {
                            _height = newValue.round();
                            _calculateBmi();
                          });
                        },
                        semanticFormatterCallback: (double newValue) {
                          return '${newValue.round()}';
                        })
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('WEIGHT', style: headlines),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("$_weight", style: boldNumber),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: _decrementWeight,
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.orangeAccent),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: secondaryButtonColorStyle,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 40.0,
                              width: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.orangeAccent),
                              child: InkWell(
                                onTap: _incrementWeight,
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: secondaryButtonColorStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('AGE', style: headlines),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("$_age", style: boldNumber),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: _decrementAge,
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.orangeAccent),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: secondaryButtonColorStyle,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 40.0,
                              width: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.orangeAccent),
                              child: InkWell(
                                onTap: _incrementAge,
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: secondaryButtonColorStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              color: primaryButtonColor,
              margin: EdgeInsets.only(top: 10.0),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                child: Text('BMI: ${_bmi.toStringAsFixed(2)}',
                    style: primaryButtonStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
