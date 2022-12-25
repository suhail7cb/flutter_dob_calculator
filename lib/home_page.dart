import 'package:dob_calculator/date_formatter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController dateFieldController = TextEditingController();
  DateTime? _dateSelected;
  String yourAge = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DOB Calculator'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dateTextField(),
            _ageTextWidget(),
          ],
        ),
      ),
    );
  }

  Widget _dateTextField() {
    return TextFormField(
      // focusNode: _focusNode,
      keyboardType: TextInputType.phone,
      autocorrect: false,
      controller: dateFieldController,
      onSaved: (value) {
        //data.registrationdate = value;
      },
      onTap: () {
        _selectDate();
        FocusScope.of(context).requestFocus(FocusNode());
      },
      maxLines: 1,
      validator: (value) {
        if (value!.isNotEmpty) {
          return 'Choose Date';
        }
      },
      decoration: const InputDecoration(
        labelText:  'Provide your Date of Birth',
        hintText: '01 Jan 2000',
        labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
      ),
    );
  }

  Widget _ageTextWidget() {
    return Container(
  margin: const EdgeInsets.all(10),
      child: Text( yourAge,
        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),

      ),
      );
}

  Future _selectDate() async {
    showDatePicker(
        context: context,
        initialDate: _dateSelected ?? DateTime(2000),
        firstDate: DateTime(1950),
        lastDate: DateTime.now()).then((DateTime? v) {
          if(null != v) {
            setState(() {
              _dateSelected = v;
              // dateFieldController.text = _dateSelected.toString();
              dateFieldController.text = AppDateFormatter.getFormattedDate(
                  formatter: AppDateFormatter.ddMMMYYYYDateFormatter,
                  date: _dateSelected!);

              yourAge = calculateAge(birthDate: _dateSelected!);
            });
            ///print(_dateSelected);
          }
          else{
            print('date not selected');
          }
    });

  }

  String calculateAge({required DateTime birthDate}) {

    var totalDaysInYear = 365.25;

    DateTime now = DateTime.now();
    int totalDays = now.difference(birthDate).inDays;
    int years = totalDays ~/ totalDaysInYear;
    int months = (totalDays-years*totalDaysInYear) ~/ 30;
    int days = (totalDays-years*totalDaysInYear-months*30).toInt();
    print("$years $months $days $totalDays");
    return 'Your Age is:  ${years > 0 ? '$years years' : ''} '
        '${months > 0 ? '$months months' : ''} '
        '${days > 0 ? '$days days' : ''}';
  }


  /*
  String calculateTimeDifferenceBetween({required DateTime startDate, required DateTime endDate}) {
    int seconds = endDate.difference(startDate).inSeconds;
   if (seconds >= 3600 && seconds < 86400)
      return '${startDate.difference(endDate).inHours} hour';
    else
      return '${startDate.difference(endDate).inDays} day';
  }
  void calculateDifference() {
    int totalDays = daysBetween(_dateSelected!, DateTime.now());
    print(totalDays);
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
  */
}
