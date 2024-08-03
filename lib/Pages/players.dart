import 'dart:convert';

import 'package:basket_ball_api_app/Models/PlayersModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Players extends StatelessWidget {
  Players({super.key});

  List<PlayersModel> allPlayers = [];

  Future getPlayers() async {
    String url = "https://api.balldontlie.io/v1/players";
    String api_key = "API_KEY";
    var reponse = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": api_key,
      },
    );
    var data = jsonDecode(reponse.body)['data'];
    for (var item in data) {
      PlayersModel player = PlayersModel(
        fname: item["first_name"],
        lname: item["last_name"],
        position: item["position"],
        height: item["height"],
        weight: item["weight"],
        jersey_no: item["jersey_number"],
        college: item["college"],
        country: item["country"],
        // team_fullName: i['full_name'],
        // abbreviation: i['abbreviation'],
        // city: i['city'],
        // division: i['division'],
      );

      allPlayers.add(player);
      // for (var i in item['team']) {
      // }
    }
    // print(allPlayers[20].fname);
  }

  @override
  Widget build(BuildContext context) {
    // getPlayers();

    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text("P L A Y E R S"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 29,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPlayers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Center(
                      child: ListView.builder(
                        itemCount: allPlayers.length,
                        itemBuilder: (context, index) {
                          PlayersModel individualPlayer = allPlayers[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, bottom: 11),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              tileColor: Colors.orange[200],
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Full Name: " +
                                        individualPlayer.fname +
                                        " " +
                                        individualPlayer.lname,
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text("Height: " + individualPlayer.height),
                                  Text("Weight: " + individualPlayer.weight),
                                  Text("Jersey Number: " +
                                      individualPlayer.jersey_no),
                                  Text("Possition: " +
                                      individualPlayer.position),
                                  Text("College: " + individualPlayer.college),
                                  Text("Country: " + individualPlayer.country),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("Error Occured in data Loading!"),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
