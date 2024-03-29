import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senior_project/pages/authentication/auth_model.dart';
import 'package:senior_project/widgets/already_have_acc.dart';
import 'package:senior_project/pages/authentication/login/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static const List<String> _genderOptions = ['Female', 'Male', 'Other'];

  static const List<String> _degreeOptions = [
    'Less than high school diploma',
    'High school diploma',
    'Some college, no degree',
    "Bachelor's degree",
    "Master's degree",
    "Doctoral degree"
  ];

  String? _selectedGender;

  String? _selectedDegree;

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(158, 225, 236, 1),
            Color.fromRGBO(229, 167, 224, 1),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: double.infinity,
              height: 650,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign up ',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const _ErrorMessageWidget(),
                  _buildInputField(
                    hintText: 'First Name',
                    controller: model?.firstNameController,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    hintText: 'Last Name',
                    controller: model?.lastNameController,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    hintText: 'Age',
                    controller: model?.ageController,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: DropdownButtonFormField<String>(
                      hint: const Text("Gender"),
                      value: _selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue!;
                        });
                        model!.gender = newValue!;
                      },
                      items: _genderOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.only(left: 15),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: DropdownButtonFormField<String>(
                      hint: const Text("Academic degree level"),
                      value: _selectedDegree,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedDegree = newValue!;
                        });
                        model!.degree = newValue!;
                      },
                      items: _degreeOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.only(left: 15),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    hintText: 'Email',
                    controller: model?.loginTextController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    hintText: 'Password',
                    controller: model?.passwordTextController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),
                  const CreateAccButton(),
                  const SizedBox(height: 16),
                  const Divider(height: 10, color: Colors.black45),
                  const SizedBox(height: 16),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => AuthProvider(
                            model: AuthModel(),
                            child: const Login(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hintText,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.done,
        obscureText: obscureText,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          contentPadding: const EdgeInsets.only(left: 15, bottom: 15),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class CreateAccButton extends StatelessWidget {
  const CreateAccButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;
    return GestureDetector(
      onTap: () => {
        model?.register(context),
      },
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(131, 89, 227, 1),
        ),
        child: const Center(
          child: Text('Create account',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
        ),
      ),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthProvider.watch(context)?.model.errorMessage;
    if (errorMessage == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(errorMessage,
          style: const TextStyle(fontSize: 17, color: Colors.red)),
    );
  }
}
