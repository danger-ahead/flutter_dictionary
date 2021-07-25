import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> detectNetStatus(context) async {
  var connection = await (Connectivity().checkConnectivity());
  print(connection);

  if (connection != ConnectivityResult.mobile &&
      connection != ConnectivityResult.wifi) {
    noNetworkError(context);
  }
}

noNetworkError(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 170,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/no-signal.png',
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "No Internet",
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700]),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Retry",
                    style: GoogleFonts.michroma(),
                  ),
                )
              ],
            ),
          ),
          actionsPadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      });
}
