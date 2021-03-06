import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MultiSelect Formfield Example'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: MultiSelectFormField(
                    autovalidate: false,

                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Please select one or more options';
                      }
                      return null;
                    },
                    dataSource: [
                      {
                        "display": "شيبسي",
                        "value": "6شبسي",
                      },
                      {
                        "display": "شيبسي",
                        "value": "5شبسي",
                      },
                      {
                        "display": "شيبسي",
                        "value": "شبس8ي",
                      },
                      {
                        "display": "شيبسي",
                        "value": "شبfسي",
                      },
                      {
                        "display": "شيبسي",
                        "value": "شبسfي",
                      },
                      {
                        "display": "شيبسي",
                        "value": "dشبسي",
                      },
                      {
                        "display": "شبسي",
                        "value": "1شبسي",
                      },
                      {
                        "display": "شيبسي",
                        "value": "شبسي",
                      },
                    ],
                    titleText: 'اختار',
                    textField: 'display',

                    valueField: 'value',
                    okButtonLabel: 'موافق',
                    cancelButtonLabel: 'الغاء',
                    // required: true,
                    hintText: 'Please choose one or more',
                    initialValue: _myActivities,
                    onSaved: (value) {
                      if (value == null) return;
                      print(value);
                      setState(() {
                        _myActivities = value;
                      });
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: _saveForm,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(_myActivitiesResult),
              )
            ],
          ),
        ),
      ),
    );
  }
}
