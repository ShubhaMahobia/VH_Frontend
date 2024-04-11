import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_hospital/common/components/buttons/b1.dart';
import 'package:virtual_hospital/common/components/textfields/input_decoration.dart';
import 'package:virtual_hospital/doctor/controllers/doctor_controller.dart';
import 'package:virtual_hospital/doctor/doctor_profile.dart';
import 'package:virtual_hospital/patient/profile_page.dart';
import 'package:virtual_hospital/util/util.dart';

class GeneratePrescription extends StatefulWidget {
  const GeneratePrescription(
      {super.key, required this.doctorName, required this.doctorId});
  final String doctorName;
  final String doctorId;

  @override
  State<GeneratePrescription> createState() => _GeneratePrescription();
}

class _GeneratePrescription extends State<GeneratePrescription> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _prescription = TextEditingController();
  Uint8List? image;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  void saveProfile() async {
    _doctorController.imageLinkController.text =
        await Util().saveData(file: image!);
  }

  final DoctorController _doctorController = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Text(
                'Generate Prescription',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 24,
              ),
              //Create a profile picture upload
              //This will be a circle avatar

              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: 150,
                      decoration:
                          FormInputField.formTextFieldContainer(context),
                      child: TextField(
                          enabled: false,
                          controller: _doctorController.firstNameController,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: FormInputField.textFieldInputDecoration(
                              context, widget.doctorName)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: 150,
                      decoration:
                          FormInputField.formTextFieldContainer(context),
                      child: TextField(
                          enabled: false,
                          controller: _doctorController.lastNameController,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: FormInputField.textFieldInputDecoration(
                              context, patientController.user['firstName'])),
                    ),
                  ),
                ],
              ),

              //This Field will be uneditable as will be fetched automatically
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: 320,
                  decoration: FormInputField.formTextFieldContainer(context),
                  child: TextField(
                      controller: _doctorController.emailController,
                      enabled: false,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: FormInputField.textFieldInputDecoration(
                          context, patientController.user['Email'])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: 320,
                  decoration: FormInputField.formTextFieldContainer(context),
                  child: TextField(
                      controller: _titleController,
                      enabled: true,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: FormInputField.textFieldInputDecoration(
                          context, 'Enter Title')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 200,
                  width: 320,
                  decoration: FormInputField.formTextFieldContainer(context),
                  child: TextField(
                    maxLines: null,
                    expands: false,
                    controller: _prescription,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Prescription'),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ButtonOne(
                  buttonText: 'Send Prescription',
                  onTap: () {
                    doctorController.generateSendPrescription(
                        widget.doctorId,
                        patientController.user['_id'],
                        _titleController.text,
                        _prescription.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
