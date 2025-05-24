import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class StepOnePage extends StatefulWidget {
  final VoidCallback onNext;

  const StepOnePage({super.key, required this.onNext});
  @override
  _StepOnePageState createState() => _StepOnePageState();
}

class _StepOnePageState extends State<StepOnePage> {
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  DateTime? _selectedDate;

  final List<String> _genders = ['Male', 'Female'];

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.white,
              onPrimary: Colors.black,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  InputDecoration _styledInput(String label, {String? hintText}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFF757575)),
      errorStyle: TextStyle(color: Colors.red),
      errorBorder: authOutlineInputBorder.copyWith(
        borderSide: const BorderSide(color: Colors.red),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      border: authOutlineInputBorder,
      enabledBorder: authOutlineInputBorder,
      focusedBorder: authOutlineInputBorder.copyWith(
        borderSide: const BorderSide(color: Colors.black),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          const Text(
                            "Personal Information",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Enter your personal details to continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xFF757575)),
                          ),
                          const SizedBox(height: 48),

                          TextFormField(
                            controller: _firstNameController,
                            style: const TextStyle(color: Colors.black),

                            decoration: _styledInput(
                              "First Name",
                              hintText: "Enter your first name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          TextFormField(
                            controller: _lastNameController,
                            style: const TextStyle(color: Colors.black),

                            decoration: _styledInput(
                              "Last Name",
                              hintText: "Enter your last name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          DropdownButtonFormField2<String>(
                            isExpanded: true,
                            decoration: _styledInput(
                              "Gender",
                              hintText: "Select your gender",
                            ),
                            hint: const Text(
                              'Gender',
                              style: TextStyle(color: Color(0xFF757575)),
                            ),
                            items:
                                _genders
                                    .map(
                                      (gender) => DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(
                                          gender,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            value: _gender,
                            onChanged: (val) => setState(() => _gender = val),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select your gender';
                              }
                              return null;
                            },
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(8),
                            ),
                          ),

                          const SizedBox(height: 16),

                          InkWell(
                            onTap: () => _selectDate(context),
                            child: InputDecorator(
                              decoration: _styledInput("Date of Birth"),
                              child: Text(
                                _selectedDate == null
                                    ? "Select date"
                                    : "${_selectedDate!.toLocal()}".split(
                                      ' ',
                                    )[0],
                                style: TextStyle(
                                  color:
                                      _selectedDate == null
                                          ? const Color(0xFF757575)
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                widget.onNext();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                            child: const Text("Continue"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

const OutlineInputBorder authOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(color: Color(0xFF757575)),
);
