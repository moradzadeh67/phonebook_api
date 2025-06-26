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
    Network.getData().then((value) async {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditeScreen()),
          );
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
            onPressed: () {},
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
                onPressed: () {},
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
