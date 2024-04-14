import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_hospital/common/components/buttons/b1.dart';
import 'package:virtual_hospital/common/components/dropdowns/custom_dropdown.dart';
import 'package:virtual_hospital/common/components/textfields/input_decoration.dart';
import 'package:virtual_hospital/doctor/controllers/doctor_controller.dart';
import 'package:virtual_hospital/doctor/doctor_profile.dart';
import 'package:virtual_hospital/util/util.dart';

class CreateProfileDoctor extends StatefulWidget {
  const CreateProfileDoctor({super.key});

  @override
  State<CreateProfileDoctor> createState() => _CreateProfileDoctorState();
}

class _CreateProfileDoctorState extends State<CreateProfileDoctor> {
  Uint8List? image;
  @override
  void initState() {
    doctorController.selectedDays = [false, false, false, false, false, false];
    doctorController.firstNameController.clear();
    doctorController.lastNameController.clear();
    doctorController.specificationController.clear();
    doctorController.qualificationController.clear();
    doctorController.startHourController.clear();
    doctorController.clinicAddressController.clear();
    doctorController.phoneNumberController.clear();
    doctorController.genderController.clear();
    doctorController.bioController.clear();
    doctorController.endHourController.clear();
    doctorController.experienceController.clear();
    super.initState();
  }

  @override
  void dispose() {
    doctorController.selectedDays = [false, false, false, false, false, false];
    doctorController.firstNameController.clear();
    doctorController.lastNameController.clear();
    doctorController.specificationController.clear();
    doctorController.qualificationController.clear();
    doctorController.startHourController.clear();
    doctorController.endHourController.clear();
    doctorController.clinicAddressController.clear();
    doctorController.phoneNumberController.clear();
    doctorController.genderController.clear();
    doctorController.bioController.clear();
    doctorController.experienceController.clear();
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
                'Lets Create Your Account',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 24,
              ),
              image != null
                  ? GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: MemoryImage(image!),
                      ),
                    )
                  : CircleAvatar(
                      radius: 50,
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 32,
                        ),
                        onPressed: () {
                          selectImage();
                        },
                      ),
                    ),
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
                          controller: _doctorController.firstNameController,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: FormInputField.textFieldInputDecoration(
                              context, 'First Name*')),
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
                          controller: _doctorController.lastNameController,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: FormInputField.textFieldInputDecoration(
                              context, 'Last Name*')),
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
                        context,
                        _doctorController.emailController.text,
                      )),
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
                    inputFormatters: [LengthLimitingTextInputFormatter(2)],
                    controller: _doctorController.experienceController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Years of Experience*'),
                  ),
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
                    controller: _doctorController.specificationController,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Specialization*'),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Availablity*',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2)
                              ],
                              keyboardType: TextInputType.number,
                              controller: _doctorController.startHourController,
                              style: GoogleFonts.plusJakartaSans(
                                
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration:
                                  FormInputField.textFieldInputDecoration(
                                context,
                                '9:00*',
                              ),
                            ),
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2)
                              ],
                              keyboardType: TextInputType.number,
                              controller: _doctorController.endHourController,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration:
                                  FormInputField.textFieldInputDecoration(
                                context,
                                '14:00*',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i = 0; i < 6; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  doctorController.selectedDays[i] =
                                      !doctorController.selectedDays[i];
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: doctorController.selectedDays[i]
                                          ? Colors.blue
                                          : Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getDayName(i),
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              doctorController.selectedDays[i]
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
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
                    
                    controller: _doctorController.qualificationController,
                    
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Highest Qualification*'),
                  ),
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
                    
                    controller: _doctorController.clinicAddressController,
                   
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Clinic Address*'),
                  ),
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
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    controller: _doctorController.phoneNumberController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Phone Number*'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 100,
                  width: 320,
                  decoration: FormInputField.formTextFieldContainer(context),
                  child: TextField(
                    maxLines: null,
                    expands: false,
                    controller: _doctorController.bioController,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Enter your bio*'),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomDropdown(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ButtonOne(
                  buttonText: 'Create Account',
                  onTap: () {
                    saveProfile();
                    _doctorController.createDoctorProfile();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _getDayName(int index) {
    switch (index) {
      case 0:
        return 'Mon';
      case 1:
        return 'Tue';
      case 2:
        return 'Wed';
      case 3:
        return 'Thu';
      case 4:
        return 'Fri';
      case 5:
        return 'Sat';
      default:
        return '';
    }
  }
  
}
