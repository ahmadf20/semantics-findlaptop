import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shadowColor: Colors.red,
                  ),
                  child: Icon(Icons.home_outlined),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Container(
            // color: Colors.blue[100],
            padding: EdgeInsets.fromLTRB(25, 75, 25, 125),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'FIND',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        fontSize: 50,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      'LAPTOP',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        fontSize: 50,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Text(
                    'FindLaptop adalah sebuah aplikasi berbasis web yang menerapkan semantik web dalam memberikan rekomendasi laptop sesuai kebutuhan spek penggunanya.',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NunitoSans',
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Contributor:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  '140810180023 - Ahmad Faaiz Al-auza\'i\n140810180075 - Mohammad Dhikri',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
