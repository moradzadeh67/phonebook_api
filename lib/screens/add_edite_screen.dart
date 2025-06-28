import 'package:flutter/material.dart';
import 'package:phonebook_api/widget/MyButton.dart';

import '../utils/network.dart';
import '../widget/MyTextField.dart';

class AddEditeScreen extends StatefulWidget {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static int id = 0;

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
          title: Text(
            AddEditeScreen.id == 0 ? 'افزودن مخاطب' : 'ویرایش مخاطب',
            style: const TextStyle(
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
                  if (formKey.currentState!.validate()) {
                    Network.checkInternet();
                    Future.delayed(const Duration(seconds: 3)).then((value) {
                      if (Network.isConnected) {
                        if (AddEditeScreen.id == 0) {
                          Network.postData(
                            phone: AddEditeScreen.phoneController.text,
                            fullname: AddEditeScreen.nameController.text,
                          );
                        } else {
                          Network.putData(
                            phone: AddEditeScreen.phoneController.text,
                            fullname: AddEditeScreen.nameController.text,
                            id: AddEditeScreen.id.toString(),
                          );
                        }
                        Navigator.pop(context);
                      } else {
                        Network.showInternetError(context);
                      }
                    });
                  }
                },
                width: double.infinity,
                child: Text(
                  AddEditeScreen.id == 0 ? 'افزودن' : 'ویرایش',
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
