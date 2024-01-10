import 'package:crime_analysis_flutter/controllers/services/Complain%20Services/complain_services.dart';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/view/Auth/widgets/textfield_widget.dart';
import 'package:crime_analysis_flutter/resources/buttons/rounded_button_expanded.dart';
import 'package:crime_analysis_flutter/utilities/responsive.dart';
import 'package:crime_analysis_flutter/utilities/validator.dart';
import 'package:crime_analysis_flutter/view/Create%20Complain/pick_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class CreateComplainScreen extends StatefulWidget {
  const CreateComplainScreen({super.key});

  @override
  State<CreateComplainScreen> createState() => _CreateComplainScreenState();
}

class _CreateComplainScreenState extends State<CreateComplainScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool loading = false;

  final TextEditingController _victimNameController = TextEditingController();
  final TextEditingController _crimeTypeController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  LatLng addressLatLng = const LatLng(24.8607, 67.0011);
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  updaetaddressLatLng(LatLng value) {
    setState(() {
      addressLatLng = value;
    });
  }

  void handleLogin(context) async {
    String formatedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate).toString();
    String formatedTime =
        '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00';
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        loading = true;
      });
      await createComplain(
              victimName: _victimNameController.text,
              type: _crimeTypeController.text,
              date: formatedDate,
              time: formatedTime,
              address: _addressController.text,
              addresslatLng: addressLatLng,
              context: context)
          .then((value) => setState(() {
                loading = false;
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.main,
        title: const Text("Create Spot"),
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height(20),
                  ),
                  TextFieldContainer(
                    title: "Reporter Name",
                    hint: "Enter victim name",
                    controller: _victimNameController,
                    validator: Validator.requiredValidator, icon: Icons.person,
                    // inputType: TextInputType.number,
                  ),
                  // TextFieldContainer(
                  //   title: " Crime Type",
                  //   hint: "Enter crime type",
                  //   controller: _crimeTypeController,
                  //   validator: Validator.requiredValidator, icon: Icons.person,
                  //   // inputType: TextInputType.number,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(bottom: width(10), top: width(12)),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " Date of Spot",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.black_light, width: 1.5)),
                    child: ListTile(
                      onTap: () {
                        _selectDate(context);
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              padding: const EdgeInsets.all(0),
                              alignment: Alignment.centerLeft,
                              icon: const Icon(
                                Icons.date_range,
                                color: AppColors.grey,
                              )),
                          Text(
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                            style: const TextStyle(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: width(10), top: width(12)),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " Time of Spot",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.black_light, width: 1.5)),
                    child: ListTile(
                      onTap: () {
                        _selectTime(context);
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                _selectTime(context);
                              },
                              padding: const EdgeInsets.all(0),
                              alignment: Alignment.centerLeft,
                              icon: const Icon(
                                Icons.timer_outlined,
                                color: AppColors.grey,
                              )),
                          Text(
                            "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')} ${selectedTime.period.name.toUpperCase()}",
                            style: const TextStyle(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: width(10), top: width(12)),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " Location",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.black_light, width: 1.5)),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PickLocationScreen(
                                    addressController: _addressController,
                                    updateAddressLatLng: updaetaddressLatLng,
                                  )),
                        );
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                // _selectTime(context);
                              },
                              padding: const EdgeInsets.all(0),
                              alignment: Alignment.centerLeft,
                              icon: const Icon(
                                Icons.location_on,
                                color: AppColors.grey,
                              )),
                          _addressController.text.isEmpty
                              ? const Text(
                                  'Tap to Pick Location',
                                  style: TextStyle(color: AppColors.grey),
                                )
                              : Text(
                                  _addressController.text,
                                  style: const TextStyle(color: AppColors.grey),
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: width(20)),
                  RoundedButtonExpanded(
                    title: "Create Spot",
                    onPress: () => handleLogin(context),
                    loading: loading,
                  ),
                  SizedBox(
                    height: height(20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.main, // header background color
              // onPrimary: Colors.black, // header text color
              onSurface: AppColors.main, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.main, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
  //
  //                       FUNCTION FOR TIME
  //

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.main, // header background color
              onSurface: AppColors.main, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.main, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
