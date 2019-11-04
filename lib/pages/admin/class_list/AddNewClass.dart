import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';

class AddNewClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddNewClassState();
  }
}

class _AddNewClassState extends State<AddNewClass>{

  List _cities =
  ["Cluj-Napoca", "Bucuresti", "Timisoara", "Brasov", "Constanta"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  @override
  void initState() {
    setState(() {
      _dropDownMenuItems = getDropDownMenuItems();
      _currentCity = _dropDownMenuItems[0].value;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }

  Widget _addNewClass(BuildContext context) {
    Alert(
        context: context,
        title: "Tambah Kelas",
        content: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            new DropdownButton(
              value: _currentCity,
              items: _dropDownMenuItems,
              onChanged: _changedDropDownItem,
            ),
            TextField(
//                  autofocus: true,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.pinkAccent)),
                  icon: Icon(Icons.account_circle),
                  labelText: 'Nama Kelas',
                  contentPadding: EdgeInsets.only(
                      left: 16.0,
                      top: 20.0,
                      right: 16.0,
                      bottom: 5.0)
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.pinkAccent)),
                  icon: Icon(Icons.lock),
                  labelText: 'Wali Kelas',
                  contentPadding: EdgeInsets.only(
                      left: 16.0,
                      top: 20.0,
                      right: 16.0,
                      bottom: 5.0)
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            width: 80,
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ]).show();
  }

  _changedDropDownItem(String selectedCity) {
    print(selectedCity);
    setState(() {
      _currentCity = selectedCity;
    });
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        'Tambah Kelas',
      ),
    );
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//      body: ClassListView(kelas),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Stack stack = Stack(
          children: <Widget>[
            _buildPageContent(model),
          ],
        );

        return stack;
      },
    );
  }

}