import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.deepPurple,
      centerTitle: true,
      title: const Text(
        'Dashboard',
        style:
            TextStyle(fontSize: 17, color: Colors.white, letterSpacing: 0.53),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      leading: InkWell(
        onTap: () {},
        child: const Icon(
          Icons.subject,
          color: Colors.white,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications,
              size: 20,
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: Container(
            padding: const EdgeInsets.only(left: 30, bottom: 20),
            child: Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person_outline_rounded),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.deepPurple,
                        size: 20,
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hubert Wong',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Text(
                        'hubert.wong@mail.com',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '+1 1254 251 241',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    ),
      body: const Center(),
    );
  }

}
