import 'package:flutter/material.dart';

//eğer butonların rengi mouse geldiğinde değişsin falan istiyorsak o zaman stateful widget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GymTracker'),
        //en baştaki icon için leading
        leading: IconButton(
          onPressed: () {
            //bişi yapıcak sonra
          },
          icon: Icon(Icons.menu),
        ),
        centerTitle: true,
        //değiştirilicek renk ayarları
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.black,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //yine action
            },
            icon: Icon(Icons.language_rounded),
          ),
        ],
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Positioned(
                top: 10,
                left: MediaQuery.of(context).size.width / 2 - 70,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.person, size: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    fillColor: const Color.fromARGB(255, 236, 172, 193),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 84, 41, 204),
                        width: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    fillColor: const Color.fromARGB(255, 236, 172, 193),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 84, 41, 204),
                        width: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MouseRegion(
                    onEnter: (_) {},
                    onExit: (_) {},
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color.fromARGB(
                          255,
                          48,
                          122,
                          207,
                        ),
                      ),
                      onPressed: () {},
                      child: Text('Sign Up'),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      //işlevi
                    },
                    child: Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}
