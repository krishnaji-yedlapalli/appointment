import 'package:appointment/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var autoValidate = false;
  var style = const TextStyle(color: Colors.black, fontSize: 15.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode:
          autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
              children: [
                _buildInputField(CoreDataHolder().userNameCtrl, 'User Name'),
                _buildInputField(CoreDataHolder().pwdCtrl, 'Password'),
                _buildInputField(CoreDataHolder().dateCtrl, 'Date', readOnly: true, suffixIcon: const Icon(Icons.calendar_today)),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: onClickOfSave,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController ctrl, String labelText, {bool readOnly = false, Icon? suffixIcon, int? maxLength = 30}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: ctrl,
        style: style,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            enabledBorder: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(),
            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder: const OutlineInputBorder(),
            labelText: labelText,
            suffixIcon: suffixIcon),
        maxLength: maxLength,
        readOnly: readOnly,
        // onChanged: CoreDataHolder().onChangeOfData,
        validator: (value) {
          if (value!.isEmpty) {
            return '$labelText is required';
          }
          return null;
        },
        onTap: readOnly ? _showDatePicker : null,
      ),
    );
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context, initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100)
    );

    if(pickedDate != null ){
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        CoreDataHolder().dateCtrl.text = formattedDate;
      });
    }else{
      print("Date is not selected");
    }
  }

  Future<void> onClickOfSave() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!_formKey.currentState!.validate()) {
      setState(() {
        autoValidate = true;
      });
      return;
    }else{
      CoreDataHolder().onChangeOfData();
      Navigator.pop(context);
    }
  }
}