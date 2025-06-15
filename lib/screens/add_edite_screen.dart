import 'package:flutter/material.dart';
import 'package:phonebook_api/widget/MyButton.dart';

import '../widget/MyTextField.dart';

class AddEditeScreen extends StatefulWidget {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();

  const AddEditeScreen({super.key});

  @override
  State<AddEditeScreen> createState() => _AddEditeScreenState();
}

class _AddEditeScreenState extends State<AddEditeScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: const Text(
            'مخاطب جدید',
            style: TextStyle(
              fontFamily: 'iran',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              MyTextField(
                inputType: TextInputType.name,
                controller: AddEditeScreen.nameController,
                hintText: 'نام',
                errorText: 'لطفا نام را وارد کنید',
              ),
              SizedBox(height: 20),
              MyTextField(
                inputType: TextInputType.number,
                controller: AddEditeScreen.phoneController,
                hintText: 'شماره',
                errorText: 'لطفا شماره را وارد کنید',
              ),
              SizedBox(height: 40),
              MyButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
                width: double.infinity,
                child: const Text(
                  'اضافه کردن',
                  style: TextStyle(
                    fontFamily: 'iran',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
