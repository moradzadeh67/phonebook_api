import 'package:flutter/material.dart';

import '../utils/network.dart';
import 'add_edite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Network.checkInternet();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (Network.isConnected) {
        Network.getData().then((value) async {
          await Future.delayed(const Duration(seconds: 3));
          // setState(() {});
        });
      }
      setState(() {});
    });
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        onPressed: () {
          AddEditeScreen.phoneController.clear();
          AddEditeScreen.nameController.clear();
          AddEditeScreen.id = 0;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditeScreen()),
          ).then((value) {
            Network.getData().then((value) async {
              await Future.delayed(const Duration(seconds: 3));
              setState(() {});
            });
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: const Icon(
          Icons.import_contacts_sharp,
          color: Colors.white,
          size: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Network.checkInternet();
              Future.delayed(const Duration(seconds: 3)).then((value) {
                if (Network.isConnected) {
                  Network.getData().then((value) async {
                    await Future.delayed(const Duration(seconds: 3));
                    setState(() {});
                  });
                  // setState(() {});
                } else {
                  Network.showInternetError(context);
                }
                // setState(() {});
              });
            },
            icon: Icon(Icons.refresh_sharp, color: Colors.white, size: 30),
          ),
        ],
        title: const Text(
          'دفترچه تلفن آنلاین',
          style: TextStyle(
            fontFamily: 'iran',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: Network.contacts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onLongPress: () async {
                Network.deleteContact(Network.contacts[index].id.toString());
                await Future.delayed(const Duration(seconds: 3));
                setState(() {});
              },
              leading: CircleAvatar(
                radius: 25,

                backgroundColor: Colors.redAccent,
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.redAccent, size: 30),
                onPressed: () {
                  AddEditeScreen.phoneController.text =
                      Network.contacts[index].phone;
                  AddEditeScreen.nameController.text =
                      Network.contacts[index].fullname;
                  AddEditeScreen.id = int.parse(Network.contacts[index].id!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEditeScreen(),
                    ),
                  ).then((value) {
                    Network.getData().then((value) async {
                      await Future.delayed(const Duration(seconds: 3));
                      setState(() {});
                    });
                    setState(() {});
                  });
                },
              ),
              title: Text(
                Network.contacts[index].fullname,
                style: TextStyle(fontFamily: 'iran'),
              ),
              subtitle: Text(
                Network.contacts[index].phone,
                style: TextStyle(fontFamily: 'iran'),
              ),
            ),
          );
        },
      ),
    );
  }
}
